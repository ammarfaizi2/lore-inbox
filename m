Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTDYSQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 14:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263635AbTDYSQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 14:16:48 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:9209 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263636AbTDYSQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 14:16:46 -0400
Date: Sat, 26 Apr 2003 06:28:47 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Fix SWSUSP & !SWAP
In-reply-to: <20030425102014.A26054@schatzie.adilger.int>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>,
       cat@zip.com.au, mbligh@aracnet.com, gigerstyle@gmx.ch,
       geert@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1051295327.1722.7.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030424093534.GB3084@elf.ucw.cz>
 <20030424024613.053fbdb9.akpm@digeo.com>
 <1051182797.2250.10.camel@laptop-linux>
 <20030424043637.71c3812e.akpm@digeo.com> <20030424142632.GB229@elf.ucw.cz>
 <20030424103734.O26054@schatzie.adilger.int> <20030424204805.GA379@elf.ucw.cz>
 <20030424154608.V26054@schatzie.adilger.int>
 <1051232975.1919.26.camel@laptop-linux>
 <20030425125918.GA25733@atrey.karlin.mff.cuni.cz>
 <20030425102014.A26054@schatzie.adilger.int>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-26 at 04:20, Andreas Dilger wrote:
> On Apr 25, 2003  14:59 +0200, Pavel Machek wrote:
> > > I don't believe Pavel was saying the image would be corrupted. Rather,
> > > the rest of the disk contents are corrupted by replaying the journal and
> > > then resuming back to a memory state that has been made inconsistent
> > > with the disk state because of the journal replay.
> > 
> > Right.
> 
> But that is happening regardless of whether a swapfile is in use or not.
> It is a problem whether the filesystem is journaling or not.  Basically,
> if you are entering into a normal boot sequence and mounting filesystems
> and then resuming from your saved state you risk filesystem corruption.
> 
> The only way to avoid that would be for the kernel to detect the swsusp
> magic data in the swap partition _before_ any filesystems are mounted
> (probably via initramfs), and then resume from that image (which will
> implicitly "mount" the filesystem because it was never unmounted in
> that image).  Then, swsusp becomes a special case of the 2-kernel-monte
> (or add your other favourite kernel-booting-kernel method here), where
> most of your kernel state is swapped out and only a limited recovery
> state is loaded into RAM before doing the kernel dance).

And that's precisely what we do. SWSUSP runs before any file system is
mounted. It checks the designed partition's swap header, loads the image
and then completely replaces the booting kernel with the saved one.
That's how we avoid corruption at the moment. But if we have a swapfile,
we need to do some initialisation of the filesystem code in order to get
access to our swapfile. Even if we record in the swapfile - while
suspending - information that gives us the locations of blocks, we still
need to find the start of the swapfile, or store it somewhere. If you
have a suggestion in that regard, I might be able to see a swapfile as a
possibility.

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

