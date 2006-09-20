Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWITVsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWITVsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWITVsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:48:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932170AbWITVsi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:48:38 -0400
Date: Wed, 20 Sep 2006 14:47:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: ajberry@usa.net, linux-kernel@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org
Subject: Re: [Bug 7174] New: init run before all EXT3 drives are detected,
 stopping init
Message-Id: <20060920144759.2f93b7a0.akpm@osdl.org>
In-Reply-To: <200609202127.k8KLRu9Z006693@fire-2.osdl.org>
References: <200609202127.k8KLRu9Z006693@fire-2.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Switched from bugzilla to email.  Please retaain all cc's).

On Wed, 20 Sep 2006 14:27:56 -0700
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=7174
> 
>            Summary: init run before all EXT3 drives are detected, stopping
>                     init
>     Kernel Version: 2.6.18
>             Status: NEW
>           Severity: low
>              Owner: akpm@osdl.org
>          Submitter: ajberry@usa.net
> 
> 
> Most recent kernel where this bug did not occur:
> Distribution:
> Hardware Environment:
> Intel DG965MS  (ICH8)
> 2 GB Ram
> 200GB Sata II Hard Drive 2 ext3 partitions, 1 swap
> 
> Software Environment:
> Ubuntu 6.06.1 Desktop
> All of EXT3 and SATA is Build into the kernel, no initrd at boottime.
> 
> Problem Description:
> When booting init starts running fsck and /dev/sda2 is "no such file or
> directory".  Boot stops and Control-D must be pressed. After this the partition
> is dectected and the drive comes up and is properly mounted. I can boot 2.6.15
> with out this problem (but with acpi=off).  I have not run into this on other
> systems with similar configurations with 2.6.16/17.
> 
> Excpert From Console Log:
>  * Checking all filesystems...       [80G fsck.ext3: No such file or directory
> while trying to open /dev/sda2
> 
> /dev/sda2: 
> The superblock could not be read or does not describe a correct ext2
> filesystem.  If the device is valid and it really contains an ext2
> filesystem (and not swap or ufs or something else), then the superblock
> is corrupt, and you might try running e2fsck with an alternate superblock:
>     e2fsck -b 8193 <device>
> 
> 
> [74G[ ok ]
>  [31m*[39;49m File system check failed.  Please repair manually.
>  [31m*[39;49m CONTROL-D will exit from this shell and continue syste[  
> 68.657843] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> m startup.
> root@ubuntu:~# [   70.313668] NET: Registered protocol family 10
> [   70.318177] lo: Disabled Privacy Extensions
> [   70.322825] IPv6 over IPv4 tunneling driver
> exit
> [   77.191994] kjournald starting.  Commit interval 5 seconds
> [   77.192165] EXT3 FS on sda2, internal journal
> [   77.192170] EXT3-fs: mounted filesystem with ordered data mode.
> [   77.234688] Adding 1036184k swap on /dev/sda3.  Priority:-1 extents:1
> across:1036184k
>  * Configuring network interfaces...       [80G 
> [74G[ ok ]
> 
>  * INIT: Entering runlevel: 2
> 

What version of udev are you running?

All I can think of is that udev was too slow in creating the /dev/sda2
device node.  I could understand that happening if the sata drivers were
modular (perhaps), but you have CONFIG_SCSI_SATA=y CONFIG_SCSI_SATA_AHCI=y,
CONFIG_SCSI_ATA_PIIX=y.

[ lots snipped - it's at http://bugzilla.kernel.org/show_bug.cgi?id=7174 ]
