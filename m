Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTKCPsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 10:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTKCPsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 10:48:50 -0500
Received: from home.wiggy.net ([213.84.101.140]:39402 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262072AbTKCPsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 10:48:45 -0500
Date: Mon, 3 Nov 2003 16:48:43 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lock failure when creating raid on 2.6.0-test9
Message-ID: <20031103154843.GA1719@wiggy.net>
Mail-Followup-To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20031103133526.GC24627@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031103133526.GC24627@wiggy.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cc'ing linux-kernel as well since I suspect another subsystem may be
involved).

I noticed something else in addition to the problem below: I also
can no longer mount /dev/hdc1 since mount tells me the device
is busy. It looks like something scans the various block devices during
boot and forgets to release something.

Wichert.

Previously Wichert Akkerman wrote:
> I am trying to setup RAID 1 array on two SCSI disks on a 2.6.0-test9
> kernel but I am hitting the following:
> 
> vortex:~# mkraid /dev/md0
> handling MD device /dev/md0
> analyzing super-block
> disk 0: /dev/hda2, 35077927kB, raid superblock at 35077824kB
> disk 1: /dev/hdc2, 35077927kB, raid superblock at 35077824kB
> md: bind<hda2>
> md: could not lock hdc2.
> md: error, md_import_device() returned -16
> mkraid: aborted.
> (In addition to the above messages, see the syslog and /proc/mdstat as well
>  for potential clues.)
> 
> -16 is EBUSY, which is unepexted since nothing else is using that disk.
> At this stage /proc/mdstat contains:
> 
> Personalities : [raid1] 
> md0 : inactive hda2[0]
>       35077824 blocks
> unused devices: <none>

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

