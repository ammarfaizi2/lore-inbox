Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136309AbREGQtx>; Mon, 7 May 2001 12:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136314AbREGQtn>; Mon, 7 May 2001 12:49:43 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:16813 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136309AbREGQt1>; Mon, 7 May 2001 12:49:27 -0400
Date: Mon, 7 May 2001 12:49:16 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@devserv.devel.redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero^H^H^H^Hsingle copy pipe
In-Reply-To: <001601c0d713$d60a17b0$5517fea9@local>
Message-ID: <Pine.LNX.4.33.0105071243450.8156-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, Manfred Spraul wrote:

> The main problem is that map_user_kiobuf() locks pages into memory.
> It's a bad idea for pipes. Either we must severely limit the maximum
> amount of data in the direct-copy buffers, or we must add a swap file
> based backing store. If I understand the BSD direct-pipe code correctly
> it has a swap file based backing store. I think that's insane. And
> limiting the direct copy buffers to a few kB defeats the purpose of
> direct copy.

Okay, how about the following instead (I'm thinking of generic code that
we can reuse): continue to queue the mm, address, length tuple (I've
actually got use for this too), and then use a map_mm_kiobuf (which is
map_user_kiobuf but with an mm parameter) for the portion of the buffer
that's currently being copied.  That improves code reuse and gives us a
few primatives that are quite useful elsewhere.

> And the current pipe_{read,write} are a total mess with nested loops and
> gotos. It's possible to create wakeup storms. I rewrote them as well ;-)

Cool! =)

		-ben

