Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVCYURk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVCYURk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVCYURk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:17:40 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:40233 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261768AbVCYURU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:17:20 -0500
Message-ID: <424471CB.3060006@mesatop.com>
Date: Fri, 25 Mar 2005 13:17:15 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm3 (cannot read cd-rom, 2.6.12-rc1 is OK)
References: <20050325002154.335c6b0b.akpm@osdl.org> <42446B86.7080403@mesatop.com>
In-Reply-To: <42446B86.7080403@mesatop.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> I'm having trouble reading from the cd-rom with 2.6.12-rc1-mm3.
> 
> Kernel 2.6.12-rc1 behaves normally:
> 
> [root@spc1 steven]# mount /dev/hdc /mnt/cdrom
> mount: block device /dev/hdc is write-protected, mounting read-only
> [root@spc1 steven]# df -T
> Filesystem    Type    Size  Used Avail Use% Mounted on
> /dev/hda1     ext3    304M   96M  193M  34% /
> /dev/hda9 reiserfs    8.3G  7.2G  1.1G  88% /home
> /dev/hda8     ext3    464M  8.1M  432M   2% /tmp
> /dev/hda6     ext3    7.4G  1.5G  5.5G  22% /usr
> /dev/hda7     ext3    1.9G   96M  1.7G   6% /var
> /dev/hdc   iso9660     38M   38M     0 100% /mnt/cdrom
> [root@spc1 steven]# ls -l /mnt/cdrom
> total 37859
> -rw-r--r--  1 501 501 38673949 Mar 25 07:41 linux-2429tar.gz
> -rw-r--r--  1 501 501    92317 Mar 25 07:43 patch-2430-rc1.bz2
> [root@spc1 steven]# uname -r
> 2.6.12-rc1-GX110
> 
> Snipped from dmesg:
> 
> [   51.440018] EXT3-fs: mounted filesystem with ordered data mode.
> [   58.585093] PCI: Found IRQ 5 for device 0000:01:0c.0
> [  232.333180] ISO 9660 Extensions: IEEE_P1282
> 
> 
> 
> Kernel 2.6.12-rc1-mm3 does not: (same CD left in device)
> 
> [root@spc1 steven]# mount /dev/hdc /mnt/cdrom
> mount: block device /dev/hdc is write-protected, mounting read-only
> [root@spc1 steven]# df -T
> Filesystem    Type    Size  Used Avail Use% Mounted on
> /dev/hda1     ext3    304M   96M  193M  34% /
> /dev/hda9 reiserfs    8.3G  7.2G  1.1G  88% /home
> /dev/hda8     ext3    464M  8.1M  432M   2% /tmp
> /dev/hda6     ext3    7.4G  1.5G  5.5G  22% /usr
> /dev/hda7     ext3    1.9G   96M  1.7G   6% /var
> /dev/hdc   iso9660     38M   38M     0 100% /mnt/cdrom
> [root@spc1 steven]# ls -l /mnt/cdrom
> total 0
> [root@spc1 steven]# uname -r
> 2.6.12-rc1-mm3-GX110
> 
> Snipped from dmesg:
> 
> [   49.198779] EXT3-fs: mounted filesystem with ordered data mode.
> [   56.310394] PCI: Found IRQ 5 for device 0000:01:0c.0
> [  222.804956] rock: directory entry would overflow storage
> [  222.804978] rock: sig=0x5245, size=8, remaining=0
> [  235.551953] rock: directory entry would overflow storage
> [  235.551969] rock: sig=0x5850, size=36, remaining=34
> [  235.551976] rock: directory entry would overflow storage
> [  235.551981] rock: sig=0x5850, size=36, remaining=34
> 
> Sorry, I don't have the time to do further troubleshooting, but I
> hope this is enough information.  The .config for this machine was
> posted earlier in another thread here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111167720523853&w=2
> 
> Steven

I found a few more minutes to test two more kernels.  The problem
first occured with 2.6.12-rc1-mm2:

2.6.12-rc1     reads the cd-rom OK as reported earlier
2.6.12-rc1-mm1 also reads the cd-rom OK
2.6.12-rc1-mm2 broken same as -mm3 described as above
2.6.12-rc1-mm3 broken as reported earlier

Steven
