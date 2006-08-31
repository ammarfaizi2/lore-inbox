Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751539AbWHaLYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbWHaLYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 07:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWHaLYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 07:24:19 -0400
Received: from math.ut.ee ([193.40.36.2]:2002 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751539AbWHaLYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 07:24:18 -0400
Date: Thu, 31 Aug 2006 14:24:15 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: ahci_host_intr BUG
Message-ID: <Pine.SOC.4.61.0608311419450.9984@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Background: I have a yet-unidentified problem with 2 HDD-s that are very 
slow and often time out. They are connected to Intel ICH5R SATA 
controller. I tried with both ata_piix and ahci drivers. I 2.6.15 era 
driver, any such SATA error hung up the disk. In 2.6.17 (Debian 
2.6.17-2-686 kernel, package version 2.6.17-7) the errors are handled 
much better, woprk is resumed after timeout. ata_piix just logs the 
messages about timeout, drive being { Busy} and then reset and continue. 
AHCI driver on the other hand logs this on every error but then 
continues fine (albeit slowly):

Info fld=0xb530a4
ata1: handling error/timeout
ata1: port reset, p_is 0 is 0 pis 0 cmd 4017 tf d0 ss 113 se 0
BUG: warning at drivers/scsi/ahci.c:853/ahci_host_intr()
  <f003945c> ahci_interrupt+0xda/0x1b5 [ahci]  <b0139ada> handle_IRQ_event+0x23/0x4c
  <b0139b81> __do_IRQ+0x7e/0xd1  <b0104fe1> do_IRQ+0x19/0x24
  <b0103592> common_interrupt+0x1a/0x20  <b0120a49> __do_softirq+0x4f/0xc2
  <b0120aea> do_softirq+0x2e/0x32  <b0103620> apic_timer_interrupt+0x1c/0x24
  <b0271d13> _spin_unlock_irqrestore+0x6/0x7  <f003960d> ahci_eng_timeout+0x65/0x71 [ahci]
  <f004aad8> ata_scsi_error+0x8c/0xe8 [libata]  <f005d213> scsi_error_handler+0xab/0xa4a [scsi_mod]
  <f005d168> scsi_error_handler+0x0/0xa4a [scsi_mod]  <b012c1e6> kthread+0x9f/0xcb
  <b012c147> kthread+0x0/0xcb  <b0101005> kernel_thread_helper+0x5/0xb
BUG: warning at drivers/scsi/ahci.c:853/ahci_host_intr()
  <f003945c> ahci_interrupt+0xda/0x1b5 [ahci]  <b0139ada> handle_IRQ_event+0x23/0x4c
  <b0139b81> __do_IRQ+0x7e/0xd1  <b0104fe1> do_IRQ+0x19/0x24
  <b0103592> common_interrupt+0x1a/0x20  <b0101eaf> mwait_idle+0x1f/0x34
  <b0101e77> cpu_idle+0x8f/0xa8
ata1: status=0x50 { DriveReady SeekComplete }
sda: Current: sense key: No Sense
     Additional sense: No additional sense information


-- 
Meelis Roos (mroos@linux.ee)
