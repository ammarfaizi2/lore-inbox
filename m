Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280435AbRKKTAG>; Sun, 11 Nov 2001 14:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280387AbRKKS75>; Sun, 11 Nov 2001 13:59:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36109 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280419AbRKKS7n>; Sun, 11 Nov 2001 13:59:43 -0500
Date: Sun, 11 Nov 2001 10:56:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] long-living cache for block devices
In-Reply-To: <Pine.GSO.4.21.0111092010150.12727-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111111053160.21663-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Nov 2001, Alexander Viro wrote:
> >
> > Why do yu care about destroying buffer-heads?
> >
> > You might as well leave them active, I don't see what you win from trying
> > to get rid of them aggressively. They'll go away when the pages go away..
>
> The simplest way to make sure that all IO is over (including readaheads).

Again - why do you actually care?

If we end up removing the module, we'll call "unregister_blockdev()" or
whatever, which in turn gets rid of _all_ pages, and that that time we
will correctly get rid of buffers.

And before you remove the module I see no advantage to have any guarantees
of quiescence and removing the buffer heads. I only see extra code that
doesn't seem to have any real purpose..

		Linus

