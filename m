Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279739AbRKROuo>; Sun, 18 Nov 2001 09:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279749AbRKROuf>; Sun, 18 Nov 2001 09:50:35 -0500
Received: from ns.suse.de ([213.95.15.193]:22543 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279739AbRKROuY>;
	Sun, 18 Nov 2001 09:50:24 -0500
Date: Sun, 18 Nov 2001 15:50:21 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] moving F0 0F bug check to bugs.h
In-Reply-To: <Pine.LNX.4.33.0111181631380.16977-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.30.0111181541040.29315-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Zwane Mwaikambo wrote:

> > hpa moved it (And some others) during his 2.3.99 big cleanup of setup.c
> > and friends.
> Hmm most of them were gone, but f00f is indeed still there in 2.4.15-pre6

The move went the other way. bugs.h -> setup.c
As well as f00f, things like the K6 bug check got moved there too.

tbh, I don't agree with hiding such code in a .h file. A better approach
may have been to split off a bugs.c file in arch/i386/kernel that gets
called after we've done CPU identification.

I'd like to shrink setup.c by moving a lot of things out of there.
If you look at what we currently have in that file..

- (unmaintained?) SGI visws support.
- bootmem allocator.
- CPU identification.
- CPU feature enabling/disabling.
- CPU errata workarounds.

Whilst you get to know your way around the 3000 or so lines after hacking
there a few times, it's constantly growing with each new CPU we support.
I think it's going to come to a point where this has to be split up to
some extent to keep it maintainable.

Something on my list for 2.5. I've already got patches doing some of this,
but theres still work to do.

> This particular bug hits all 586s so we're safe in this regard.

Good point. I had forgotten that. (And likewise, SMP K6's are unlikely)
In which case, I guess the reason was to get code 'hidden' in header
files in a common place.

> > It's questionable we should support such nightmare scenarios, but
> > as this is __initcode anyway, it's not that big a deal.
> ahh but isn't that the beauty of Linux ;)

Of course 8)

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

