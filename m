Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130264AbRCGFtP>; Wed, 7 Mar 2001 00:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130266AbRCGFtG>; Wed, 7 Mar 2001 00:49:06 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:5808 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S130264AbRCGFs5>;
	Wed, 7 Mar 2001 00:48:57 -0500
Message-Id: <l03130315b6cb7099f738@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.10.10103060526470.13719-100000@master.linux-ide.org>
In-Reply-To: <l0313030ab6ca4912a397@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 7 Mar 2001 05:25:18 +0000
To: Andre Hedrick <andre@linux-ide.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: scsi vs ide performance on fsync's
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeremy Hansen <jeremy@xxedgexx.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am not going to bite on your flame bate, and are free to waste you money.

I don't flamebait.  I was trying to clear up some confusion...

>No, SCSI does with queuing.
>I am saying that the ata/ide driver rips the heart out of the
>io_request_lock what to darn long.  This means that upon execution a
>request virtually all interrupts are wacked and the drivers in dominating
>the system.  Given that IO's are limited to 128 sectors or one DMA PRD,
>this is vastly smaller than the SCSI trasfer limit.

Ah, so the ATA driver hogs interrupts.  Nice.  Kinda explains why I can't
use the mouse on some systems when I use cdparanoia.

>Okay real short....limit to two zones that are equal in size.
>The inner and outer, and the latter will cover more physical media than
>the former.  Simple Two zone model.

Still doesn't make a difference - there is one revolution between writes,
no matter where on disk it is.

>> Under those circumstances,
>> I would expect my 7200rpm Seagate to perform slower than my 10000rpm IBM
>> *regardless* of seeking performance.  Seeking doesn't come into it!
>
>It does, because more RPM means more air-flow and more work to keep the
>position stable.

That's the engineers' problem, not ours.  In fact, it's not really a
problem because my IBM drive gave almost exactly the correct performance
result, even at 10000rpm, therefore it's managing to keep the position
stable regardless of airflow.

>> Why does this sound familiar?
>
>Because of WinBench!
>All the prefetch/caching are modeled to be optimized to that bench-mark.

Lies, damn lies, statistics, benchmarks, delivery dates.  Especially a
consumer-oriented benchmark like WinBench.  It's perfectly natural to
optimise for particular access patterns, but IMHO that doesn't excuse
breaking the drive just to get a better benchmark score.

>> Personally, I feel the bottom line is rapidly turning into "if you have
>> critical data, don't put it on an IDE disk".  There are too many corners
>> cut when compared to ostensibly similar SCSI devices.  Call me a SCSI bigot
>> if you like - I realise SCSI is more expensive, but you get what you pay
>> for.
>
>Let me slap you in the face with a salomi stick!
>ATA 7200 RPM Drives are using SCSI 7200 RPM Drive HDA's
>So you say ATA is Lame?  Then so was your SCSI 7200's.

That isn't the point!  I'm not talking about the physical mechanism, which
indeed is often the same between one generation of SCSI and the next
generation of IDE devices.  I'm talking about the IDE controller which is
slapped on the bottom of said mechanism.  The mech can be of world-class
quality, but if the controller is shot it doesn't cut the grain.

>Since all OSes that enable WC at init will flush
>it at shutdown and do a periodic purge with in-activity.

But Linux doesn't, as has been pointed out earlier.  We need to fix Linux.
Also, as I and someone else have also pointed out, there are drives in
circulation which refuse to turn off write caching, including one sitting
in my main workstation - the one which is rebooted the most often, simply
because I need to use Windoze 95 for a few onerous tasks.  I haven't
suffered disk corruption yet, because Linux unmounts the filesystems and
flushes it's own buffers several seconds before powering down, and uses a
non-pathological access pattern, but I sure don't want to see the first
time this doesn't work properly.

>Err, last time I check all good devices flush their write caching on their
>own to take advantage of having a maximum cache for prefetching.

Which doesn't work if the buffer is filled up by the OS 0.5 seconds before
the power goes.

I'm sorry if this looks like another troll, but I really do like to clear
up confusion.  I do accept that IDE now has good enough real performance
for many purposes, but in terms of enforced quality it clearly lags behind
the entire SCSI field.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


