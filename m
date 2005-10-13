Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVJMKpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVJMKpz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 06:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVJMKpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 06:45:54 -0400
Received: from starnet.skynet.com.pl ([213.25.173.230]:47341 "EHLO
	skynet.skynet.com.pl") by vger.kernel.org with ESMTP
	id S932491AbVJMKpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 06:45:54 -0400
Date: Thu, 13 Oct 2005 12:45:36 +0200
From: Marcin Owsiany <marcin@owsiany.pl>
To: linux-kernel@vger.kernel.org
Subject: SCSI "asking for cache data failed"
Message-ID: <20051013104536.GA10525@kufelek>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Scanner: exiscan *1EQ0af-0006QL-00*401RuMBEjoE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering about the following messages, which appeared when I upgraded from
2.4 to 2.6:

| sda: asking for cache data failed
| sda: assuming drive cache: write through

(a larger log snippet below)

I have found another message:
http://groups.google.com/group/fa.linux.kernel/browse_thread/thread/853b2b5a5cc2f837/87bcabcf8a07f065
whosese author asks about whether this means that data inconsistencies can
appear. I also have a megaraid card, and a similar situation, but I have a
bit more general question.

I'm wondering WHY can't the caching mode cannot be obtained by the kernel?
 - Is it because the kernel is trying to inquire about the cache on a physical
   disk, and the sda and sdb it sees are actually logical drives, and the
   situation is perfectly normal?
 - Or is it something wrong with the card?
 - Or maybe there is no support for such operation in the megaraid
   driver?
 - Is it something else even? Do I need to do something more to find
   out?

The message is simply a little worrying for me, because I don't understand why
the "asking" fails.

here's some context:

| megaraid cmm: 2.20.2.5 (Release Date: Fri Jan 21 00:01:03 EST 2005)
| SCSI subsystem initialized
| megaraid: 2.20.4.5 (Release Date: Thu Feb 03 12:27:22 EST 2005)
| megaraid: probe new device 0x1000:0x0407:0x8086:0x0532: bus 5:slot 0:func 0
| ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 52 (level, low) -> IRQ 169
| megaraid: fw version:[411M] bios version:[H404]
| scsi0 : LSI Logic MegaRAID driver
| scsi[0]: scanning scsi channel 0 [Phy 0] for non-raid devices
| scsi[0]: scanning scsi channel 1 [Phy 1] for non-raid devices
| scsi[0]: scanning scsi channel 2 [virtual] for logical drives
|   Vendor: MegaRAID  Model: LD 0 RAID1   35G  Rev: 411M
|   Type:   Direct-Access                      ANSI SCSI revision: 02
|   Vendor: MegaRAID  Model: LD 1 RAID5  245G  Rev: 411M
|   Type:   Direct-Access                      ANSI SCSI revision: 02
[...]
| SCSI device sda: 71772160 512-byte hdwr sectors (36747 MB)
| sda: asking for cache data failed
| sda: assuming drive cache: write through
| SCSI device sda: 71772160 512-byte hdwr sectors (36747 MB)
| sda: asking for cache data failed
| sda: assuming drive cache: write through
|  /dev/scsi/host0/bus2/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
| Attached scsi disk sda at scsi0, channel 2, id 0, lun 0
| SCSI device sdb: 502720512 512-byte hdwr sectors (257393 MB)
| sdb: asking for cache data failed
| sdb: assuming drive cache: write through
| SCSI device sdb: 502720512 512-byte hdwr sectors (257393 MB)
| sdb: asking for cache data failed
| sdb: assuming drive cache: write through
|  /dev/scsi/host0/bus2/target1/lun0: p1 p2
| Attached scsi disk sdb at scsi0, channel 2, id 1, lun 0

This is kernel 2.6.12 with Debian patches.

regards,

Marcin
-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 1024D/60F41216  FE67 DA2D 0ACA FC5E 3F75  D6F6 3A0D 8AA0 60F4 1216
 
"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
