Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUD2Shg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUD2Shg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUD2Shg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:37:36 -0400
Received: from av3-1-sn4.m-sp.skanova.net ([81.228.10.114]:37849 "EHLO
	av3-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S264914AbUD2Shc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:37:32 -0400
Message-ID: <40916793.9020001@telia.com>
Date: Thu, 29 Apr 2004 22:37:39 +0200
From: Mikael Eriksson <miffe-miffe@telia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthieu Foillard <m.foillard@iota-online.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA and Software RAID on 82801EB (ICH5)
References: <200404291213.35341.m.foillard@iota-online.com>
In-Reply-To: <200404291213.35341.m.foillard@iota-online.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthieu Foillard wrote:
> Hello list members,
> I'm trying to make software raid working on SATA drives for two days with 
> partial success.
> I'm using kernel 2.6.5 with Debian.The server has two 160Go drives and i want 
> to make RAID 1 on them. It works partially since the server boot on a raid 
> partition w/o problem. 
> The problem comes when i try to construct RAID 1 array on big partition (it 
> seems to works when partition size is not too big) e.g. /home which is about 
> 140 Go. When i mkraid or raidhotadd, it starts to construct the array and 
> seems to work for some times but fails after an random amount of time. At 
> this moment, disk led shows disks are busy and the system is no more usable 
> (but does not panic since i can magic sysrq to reboot).
> I tried to use the "standard" ATA drivers. It works, for sure, but performance 
> are really poor. I've also tried to create more little partitions but even 
> with a 70Go partition, array construction fails.
> Hope you can help, thanks !
> 
> P.S. : Do you think I should use iswraid on 2.4.22 kernel ?

There is a iswraid patch for 2.4.25, I have been using it since it was 
posted on lkml without problems.

http://marc.theaimsgroup.com/?l=linux-kernel&m=107733169708896&w=2

> 
> here are some informations about hardware :
>  # lspci
> ..
> 0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage 
> Controller (rev 02)
> 
> # dmesg
> ..
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> hda: CD-224E, ATAPI CD/DVD-ROM drive
> ide1: I/O resource 0x170-0x177 not free.
> ide1: ports already in use, skipping probe
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: ATAPI 24X CD-ROM drive, 128kB Cache
> Uniform CD-ROM driver Revision: 3.20
> libata version 1.02 loaded.
> ata_piix version 1.02
> ata_piix: combined mode detected
> ata: 0x1f0 IDE port busy
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
> 88:407f
> ata1: dev 0 ATA, max UDMA/133, 320173056 sectors (lba48)
> ata1: dev 1 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
> 88:407f
> ata1: dev 1 ATA, max UDMA/133, 320173056 sectors (lba48)
> ata1: dev 0 configured for UDMA/133
> ata1: dev 1 configured for UDMA/133
> scsi0 : ata_piix
>   Vendor: ATA       Model: Maxtor 6Y160M0    Rev: 1.02
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ata1: dev 0 max request 32MB (lba48)
>   Vendor: ATA       Model: Maxtor 6Y160M0    Rev: 1.02
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ata1: dev 1 max request 32MB (lba48)
> SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
> SCSI device sda: drive cache: write through
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
> SCSI device sdb: drive cache: write through
>  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
> Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
> ..
> 
> 

