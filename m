Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262265AbREZAfO>; Fri, 25 May 2001 20:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262268AbREZAfE>; Fri, 25 May 2001 20:35:04 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:14344 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262265AbREZAet>; Fri, 25 May 2001 20:34:49 -0400
Date: Fri, 25 May 2001 17:34:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.33.0105252007020.3806-100000@toomuch.toronto.redhat.com>
Message-ID: <Pine.LNX.4.31.0105251731090.1105-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 May 2001, Ben LaHaise wrote:
>
> Highmem systems currently manage to hang themselves quite completely upon
> running out of memory in the normal zone.  One of the failure modes is
> looping in __alloc_pages from get_unused_buffer_head to map a dirty page.
> Another results in looping on allocation of a bounce page for writing a
> dirty highmem page back to disk.

That's not the part of the patch I object to - fixing that is fine.

What I object to it that it special-cases the zone names, even though that
doesn't necessarily make any sense at all.

What about architectures that have other zones? THAT is the kind of
fundmanental design mistake that special-casing DMA and NORMAL is horrible
for.

alloc_pages() doesn't have that kind of problem. To alloc_pages(),
GFP_BUFFER is not "oh, DMA or NORMAL". There, it is simply "oh, use the
zonelist pointed to by GFP_BUFFER". No special casing, no stupid #ifdef
CONFIG_HIGHMEM.

THAT is what I object to.

		Linus

