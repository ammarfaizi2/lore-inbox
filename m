Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUHJMUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUHJMUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUHJMUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:20:31 -0400
Received: from relay.inway.cz ([212.24.128.3]:51172 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S264503AbUHJMUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:20:15 -0400
Message-ID: <4118BD7B.6070307@scssoft.com>
Date: Tue, 10 Aug 2004 14:20:11 +0200
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: performace problem, D state
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am having problems with system performace and I am unable to find the 
real cause of it. I have already
asked some people and polluted several mailing lists, but unfortunately, 
I don't know much more than
on the beginning.

I am having dual Opteron sytem (with two Opteron 244s) on a MSI 
Master2-Far board and 1G of ram.
The system is debian unstable/sid with vanilla 2.6.x kernels. The CPUs 
are running in non-native
mode - the entire system is 32 bit only and I am on 2.6.8-rc3 kernel 
right now.

The board is built around VIA chipset, has two SATA disks connected and 
onboard TG3 gigabit
ethernet interface.

The problem: the system goes to crawl when there is bigger disk 
activity. Bigger disk activity equals to doing
'grep -r foobar *' on uncached kernel source or doing subversion 'svn 
update' on 10Gig database.

I have naively blamed the disk (sata) subsystem, but I have been told 
that the sata is not very likely the culprit.

While doing the 'svn update', grepping the source, or compressing file 
archives, I can usually see following in 'top':

1334 petr      18   0 20724  14m 7516 D  1.6  1.5   0:01.17 svn
153 root       5 -10     0    0    0 D  0.0  0.0   0:01.09 reiserfs/0

with both CPUs usually spending >90% in 'wait state'. At this time, the 
system becomes very non-interactive for
any other task.

The disks are using reiserfs filesystem, but I have also tried to create 
ext2 partition with the same results.
'heavy' disk activity brings the system to a crawl.

The hardware in question is:

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge 
[K8T800 South]
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA 
RAID Controller (rev 80)

Dmesg ouput does not contain anything interesting (at least for a person 
with little or no knowledge, like me)

Just for the reference, this is the 'sata' part.

libata version 1.02 loaded.
sata_via version 0.20
sata_via(0000:00:0f.0): routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 11
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 11
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata1: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_via
ata2: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
88:407f
ata2: dev 0 ATA, max UDMA/133, 72303840 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
Using anticipatory io scheduler
  Vendor: ATA       Model: WDC WD2500JD-00F  Rev: 02.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 35.0
  Type:   Direct-Access                      ANSI SCSI revision: 05

I am really clueless at this point.... If you have any ideas, please let 
me know.

Thanks,
Petr

