Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281793AbRKUNLl>; Wed, 21 Nov 2001 08:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRKUNLW>; Wed, 21 Nov 2001 08:11:22 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:32264 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S281760AbRKUNLB>; Wed, 21 Nov 2001 08:11:01 -0500
Date: Wed, 21 Nov 2001 14:10:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devfs v196 available
In-Reply-To: <200111201819.fAKIJpp10565@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0111211332070.7061-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 20 Nov 2001, Richard Gooch wrote:

> Delayed events are harmless, since devfs ensures correct ordering.

It's not about ordering, timing is currently unpredictable, anything
timing sensitive has to be very careful to touch anything in devfs.

> After consideration, I've decided to dynamically grow the event buffer
> as required, and free up space as it's not needed.

You should use a slab cache and acknowledge events as soon as they are
finished. Right now all processes are waiting until the devfsd is
completely finished and restarted at the same time. This is currently
limited by dropping events, with a dynamic event queue this can become a
problem.

> Since devfsd has to
> wait for a module load to complete, it's not a good idea to block
> waiting for free space in the event buffer (potential deadlock).

What do you mean?

bye, Roman

