Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318043AbSG2GXR>; Mon, 29 Jul 2002 02:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318059AbSG2GXQ>; Mon, 29 Jul 2002 02:23:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18185 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318043AbSG2GXQ>; Mon, 29 Jul 2002 02:23:16 -0400
Date: Sun, 28 Jul 2002 23:27:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <20020728.231017.40779367.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0207282324340.872-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, David S. Miller wrote:
>
> So when the user's reference is dropped, does that operation kill it
> from the LRU or will the socket's remaining reference to that page
> defer the LRU removal?

That is indeed the question. Right now it will defer, which looks like a
bug. Or at least it is a bug without the interrupt-safe LRU manipulations.

I'm starting to be more convinced about Andrew's alternate patch, the
"move LRU lock innermost and make it irq-safe".

Which also would make it saner to do the LRU handling inside
__put_pages_ok() (and actually remove the BUG_ON(in_interrupt()) that
Andrew had there in the old patch).

		Linus

