Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTLPVZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTLPVZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:25:26 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:6151 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262747AbTLPVZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:25:23 -0500
Date: Tue, 16 Dec 2003 13:25:18 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
Message-ID: <20031216212518.GE1698@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200312151434.54886.adasi@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312151434.54886.adasi@kernel.pl>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause drowsiness.  Do not operate heavy machinery.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 02:34:54PM +0100, Witold Krecicki wrote:
> I've got / on linux-raid0 on 2.6.0-t11-cset-20031209_2107:
> <cite>
> /dev/md/1:
>         Version : 00.90.01
>   Creation Time : Thu Sep 11 22:04:54 2003
>      Raid Level : raid0
>      Array Size : 232315776 (221.55 GiB 237.89 GB)
>    Raid Devices : 2
>   Total Devices : 2
> Preferred Minor : 1
>     Persistence : Superblock is persistent
> 
>     Update Time : Mon Dec 15 12:55:48 2003
>           State : clean, no-errors
>  Active Devices : 2
> Working Devices : 2
>  Failed Devices : 0
>   Spare Devices : 0
> 
>      Chunk Size : 64K
> 
[snip]

> Disks are two ST3120026AS connected to sii3112a controller, driven by sata_sil 
> 'patched' so no limit for block size is applied (it's not needed for it). 
> 
> Those are results of hdparm -tT on drives:
> <cite>
> /dev/md/1:
>  Timing buffer-cache reads:   128 MB in  0.40 seconds =323.28 MB/sec
>  Timing buffered disk reads:  64 MB in  1.75 seconds = 36.47 MB/sec
> /dev/sda:
>  Timing buffer-cache reads:   128 MB in  0.41 seconds =309.23 MB/sec
>  Timing buffered disk reads:  64 MB in  1.46 seconds = 43.87 MB/sec
> /dev/sdb:
>  Timing buffer-cache reads:   128 MB in  0.41 seconds =315.32 MB/sec
>  Timing buffered disk reads:  64 MB in  1.23 seconds = 52.04 MB/sec
> </cite>
> What seems strange to me is that second drive is faster than first one 
> (devices are symmetrical, sd[a,b]2 is swapspace (not mounted at time of 
> test), sd[a,b]1 is /boot (raid1)).

Possible reasons:

	internal differences on controller

	block remapping (even new disks have bad blocks)

	different firmware

	different physical geometry -- two production runs of
	the same make+model drive may have different
	geometry

	cable quality or routing differences, or interface
	variations that cause subtle timing differences


> What is even stranger is that raid0 which should be faster than single drive, 
> is pretty much slower- what's the reason of that?

You could try increasing the read ahead but that may slow
things down in real world use.

AID-0 isn't RAID (no R), but then again for many arrays the
I is also out of place.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
