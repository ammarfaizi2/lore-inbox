Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264347AbTLPECE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 23:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbTLPECE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 23:02:04 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:16390 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S264347AbTLPECA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 23:02:00 -0500
Date: Mon, 15 Dec 2003 20:01:56 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
Message-ID: <20031216040156.GJ12726@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200312151434.54886.adasi@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312151434.54886.adasi@kernel.pl>
User-Agent: Mutt/1.3.27i
X-Message-Flag: If you're running Outlook, look out!
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
>     Number   Major   Minor   RaidDevice State
>        0       8        3        0      active sync   /dev/sda3
>        1       8       19        1      active sync   /dev/sdb3
>            UUID : b66633c2:ff11f60d:00119f8d:7bb9fc6c
>          Events : 0.357
> </cite>
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
> What is even stranger is that raid0 which should be faster than single drive, 
> is pretty much slower- what's the reason of that?

Overhead+randomness would make an md stripe slower.

	This measurement is an indication of  how fast  the
	drive  can sustain sequential data reads

No Linux [R]AID improves sequential performance.  How would
reading 65KB from two disks in alternation be faster than
reading continuously from one disk?

There used to be some HW raid controllers that might have
improved sequential performance by using stripe sizes of 512
bytes (every access hit all disks) but then you suffered
near worst case latency with every non-cached read.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
