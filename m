Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbVCQL3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVCQL3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbVCQL3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:29:49 -0500
Received: from adsl-203-134.38-151.net24.it ([151.38.134.203]:29168 "EHLO
	mail.gnudd.com") by vger.kernel.org with ESMTP id S263032AbVCQKZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:25:55 -0500
Date: Thu, 17 Mar 2005 11:29:01 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: mohanlal@samsung.com, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: why CURRENT->sector is zero??
Message-ID: <20050317102901.GA7077@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Face: #Q;A)@_4.#>0+_%y]7aBr:c"ndLp&#+2?]J;lkse\^)FP^Lr5@O0{)J;'nny4%74.fM'n)M
	>ISCj.KmsL/HTxz!:Ju'pnj'Gz&.
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
In-Reply-To: <01ae01c52ad1$83e79190$3d476c6b@sisodomain.com>
References: <01ae01c52ad1$83e79190$3d476c6b@sisodomain.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

> I downloaded sbull.c (for LDD 2nd Edition) from 

Please note that sbull is a block device not hosting partitions.

> of req->sector in sbull_transfer function). The observations are as follows:
> File System  req->sector
> msdos          0
> vfat              0
> ext2             2
> ext3             2
> iso9000       72

If there is no filesystem in the device, you just get the probe
transfers. Not very interesting, indeed. Some filesystems have their
magic number in the first sector, and some have it later in the device.

> I don't know about other file systems, but I believe the value of 
> req->sector for msdos/vfat is wrong. Because when I mount a CF card having 
> FAT file system on my Linux box (using USB mass storage driver), the first 
> read request contains sector 0x20.

Before you state it's wrong you should see some effect. In your case
there is no effect at all. If you make a filesystem on the device you'll
see it works. So if this concerns you, you should look for an explanation
rather than saying it is wrong.

> Does someone have any clue, why sbull gets this value as 0 rather then 0x20? 

I suspect because the device is not partitioned, while the other one is,
so every transfer just is done inside the partition (while the low-level
access uses absolute sector number of the device).

/alessandro
