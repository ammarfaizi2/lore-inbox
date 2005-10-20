Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbVJTFJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbVJTFJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 01:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbVJTFJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 01:09:23 -0400
Received: from xenotime.net ([66.160.160.81]:58844 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751755AbVJTFJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 01:09:22 -0400
Date: Wed, 19 Oct 2005 22:09:20 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Dale Blount <linux-kernel@dale.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scsi disk size reporting in dmesg
Message-Id: <20051019220920.7c91b922.rdunlap@xenotime.net>
In-Reply-To: <1129577044.17327.11.camel@dale.velocity.net>
References: <1129577044.17327.11.camel@dale.velocity.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005 15:24:04 -0400 Dale Blount wrote:

> Hello,
> 
> I just added 2 external 1TB+ scsi devices to my i686 linux server
> running 2.6.13.4 connected to external LSI MPT card.  fdisk and df both
> show the sizes correctly (see below), but I'm worried that dmesg reports
> them incorrectly.
> 
> SCSI device sda: 2460934144 512-byte hdwr sectors (160487 MB)
> SCSI device sdb: 3790438400 512-byte hdwr sectors (841193 MB)
> 
> I don't think it's as simple as a variable overflow because both
> sdkp->capacity and mb look to be cast as unsigned long longs.  I know a
> workaround is to present less data per LUN, but I'd like to use it as
> it's setup currently if possible.  Is this just printing incorrectly or
> will I run into trouble when the device gets more full?

The casts to (unsigned long long) just fix the printk() args to match
the format strings (and eliminate warnings).

Looks to me like sdkp->capacity is correct.  The <mb> value looks
way off.  Since it's just printed here for user info, I don't see
how it can be a problem later on.

I don't see the error just yet.  Are there any other SCSI device-
related messages near these?  And just to confirm, but you must
have CONFIG_LBD (Large Block Device) enabled, right?



> Thanks, 
> 
> Dale
> 
> 
> 
> 
> # df -h
> /dev/sda1             1.2T  129M  1.1T   1% /mnt/sda1
> /dev/sdb1             1.8T  129M  1.7T   1% /mnt/sdb1
> # df
> /dev/sda1            1211159084    131228 1149504532   1% /mnt/sda1
> /dev/sdb1            1865473692    131228 1770581860   1% /mnt/sdb1
> 
> 
> # fdisk -l /dev/sda
> Disk /dev/sda: 1259.9 GB, 1259998281728 bytes
> 255 heads, 63 sectors/track, 153186 cylinders
> Units = cylinders of 16065 * 512 = 8225280 bytes
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sda1               1      153186  1230466513+  83  Linux
> 
> # fdisk -l /dev/sdb
> 
> Disk /dev/sdb: 1940.7 GB, 1940704460800 bytes
> 255 heads, 63 sectors/track, 235943 cylinders
> Units = cylinders of 16065 * 512 = 8225280 bytes
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sdb1               1      235943  1895212116   83  Linux


---
~Randy
