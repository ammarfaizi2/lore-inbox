Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935138AbWLCORs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935138AbWLCORs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 09:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935199AbWLCORs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 09:17:48 -0500
Received: from twister.ispgateway.de ([80.67.18.17]:27551 "EHLO
	twister.ispgateway.de") by vger.kernel.org with ESMTP
	id S935138AbWLCORr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 09:17:47 -0500
Date: Sun, 3 Dec 2006 15:17:44 +0100
From: Steffen Moser <lists@steffen-moser.de>
To: "Kurtis D. Rader" <krader@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives
Message-ID: <20061203141744.GB7266@steffen-moser.de>
Mail-Followup-To: "Kurtis D. Rader" <krader@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <4570CF26.8070800@scientia.net> <20061203011737.GA2729@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061203011737.GA2729@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

* On Sat, Dec 02, 2006 at 05:17 PM (-0800), Kurtis D. Rader wrote:

> On Sat, 2006-12-02 01:56:06, Christoph Anton Mitterer wrote:
> > The issue was basically the following: I found a severe bug mainly by
> > fortune because it occurs very rarely.  My test looks like the following:
> > I have about 30GB of testing data on my harddisk,... I repeat verifying
> > sha512 sums on these files and check if errors occur.  One test pass
> > verifies the 30GB 50 times,... about one to four differences are found in
> > each pass.
> 
> I'm also experiencing silent data corruption on writes to SATA disks
> connected to a Nvidia controller (nForce 4 chipset). The problem is
> 100% reproducible. Details of my configuration (mainboard model, lspci,
> etc.) are near the bottom of this message. What follows is a summation
> of my findings.
> 
> I have confirmed the corruption is occurring on the writes and not the
> reads. Furthermore, if I compare the original and copy while both are
> still cached in memory no corruption is found. But as soon as I flush the
> pagecache (by reading another file larger than memory) to force the copy
> of the file to be read from disk the corruption is seen. The corruption
> occurs with direct I/O and normal buffered filesystem I/O (ext3).
> 
> Booting with "mem=1g" (system has 4 GiB installed) makes no difference.
> So it isn't due to remapping memory above the 4 GiB boundary.  Booting to
> single user and ensuring no unnecessary modules (video, etc.) are loaded
> also makes no difference.
> 
> The problem affects both disks attached to the nVidia SATA controller but
> not the two disks attached to the PATA side of the same controller. All
> four disks are different models. The same SATA disks attached to
> the Silicon Image 3114 SATA RAID controller (on the same mainboard)
> experiences the same corruption but at a lower probability.  The same
> disks attached to a Promise TX2 SATA controller (in the same system)
> experience no corruption.
> 
> The system has run memtest86 for 24 hours with no errors.

Although your problem report seems rather clearly to be related to 
the disk sub-system (e.g. as it only seems to appear at writings), 
I would just like to point out that running "memtest86" for some 
time without getting any errors does not necessarily state that the 
memory is faultless. 

I recently had one case where a machine (Athlon XP 2200+) crashed
irregularly. "memtest86", running several days, didn't find anything,
but running the "stress test" of "Prime95" [1] for a few minutes 
clearly showed that the machine just miscalculated (Prime95's stress
test stops in this case).

Just removing and reinserting the two memory modules (2 x 256 MB 
DDR-RAM) fixed it. The machine is now stable and "Prime95" hasn't 
stopped due to computational errors anymore since then. I suppose 
that one of the modules wasn't seated in its socket correctly, but 
I don't know why "memtest86" (and "memtest86+") didn't find it.

Bye,
Steffen

[1] http://www.mersenne.org/freesoft.htm
