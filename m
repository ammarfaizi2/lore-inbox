Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266925AbRGHRC3>; Sun, 8 Jul 2001 13:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266926AbRGHRCT>; Sun, 8 Jul 2001 13:02:19 -0400
Received: from [194.213.32.142] ([194.213.32.142]:9988 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266925AbRGHRCH>;
	Sun, 8 Jul 2001 13:02:07 -0400
Date: Sat, 30 Jun 2001 15:37:41 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jason McMullan <jmcmullan@linuxcare.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM Requirement Document - v0.0
Message-ID: <20010630153740.A59@toy.ucw.cz>
In-Reply-To: <20010626155838.A23098@jmcmullan.resilience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010626155838.A23098@jmcmullan.resilience.com>; from jmcmullan@linuxcare.com on Tue, Jun 26, 2001 at 03:58:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	Here's my first pass at a VM requirements document,
> for the embedded, desktop, and server cases. At the end is 
> a summary of general rules that should take care of all of 
> these cases.
> 
> Bandwidth Descriptions:
> 
> 	immediate: RAM, on-chip cache, etc. 
> 	fast:	   Flash reads, ROMs, etc.

Flash reads aresometimes pretty slow. (Flash over IDE over PCMCIA...2MB/sec 
bandwidth. Slower than most harddrives.

> 	medium:    Hard drives, CD-ROMs, 100Mb ethernet, etc.

CDroms are way slower than harddrives (mostly to seek times).

> 	slow:	   Flash writes, floppy disks,  CD-WR burners
> 	packeted:  Reads/write should be in as large a packet as possible
> 
> Embedded Case
> -------------
> 
> 	Overview
> 	--------
> 	  In the embedded case, the primary VM motiviation is to
> 	use as _little_ caching of the filesystem for reads as
> 	possible because (a) reads are very fast and (b) we don't
> 	have any swap. However, we want to cache _writes_ as hard
> 	as possible, because Flash is slow, and prone to wear.
> 	  
> 	Machine Description
> 	------------------
> 		RAM:	4-64Mb	 (reads: immediate, writes: immediate)

MB not Mb. 4Mb = 0.5MB.

> 		Flash:	4-128Mb  (reads: fast, writes: slow, packeted)
> 		CDROM:	640-800Mb (reads: medium)
> 		Swap:	0Mb
> 
> 	Motiviations
> 	------------
> 		* Don't write to the (slow,packeted) devices until
> 		  you need to free up memory for processes.
> 		* Never cache reads from immediate/fast devices.

Flash connected over PCMCIA over IDE is *very* slow. You must cache it.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

