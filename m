Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265129AbUD3JWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265129AbUD3JWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 05:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265130AbUD3JWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 05:22:19 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:19591 "EHLO
	mailfe02.swip.net") by vger.kernel.org with ESMTP id S265129AbUD3JWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 05:22:12 -0400
X-T2-Posting-ID: 8K36kL4f8d1GI2lMBg03PQ==
X-Originating-IP: [192.106.52.2]
From: <lapo.pasqui@tele2.it>
To: linux-kernel@vger.kernel.org
Subject: sata_sis driver does not detect SATA HD on P4S800D MB (2.6.6-rc1)
Date: Fri, 30 Apr 2004 11:22:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <auto-000027004750@mailfe02.swip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I've tried everything to make my HD being detected by the sata_sis driver.
I've googled around and I notice there are no succesfully stories with the sata_driver and the P4S800D  MB.

Whilst there are no problem with the sis964 chipset  in general, a few complain some difficulties with the MB P4S800D.

http://lkml.org/lkml/2004/4/3/34
http://www.linuxquestions.org/questions/history/160949

I'm confident the HW is set up correctly (winXP is working).
Whem the driver is probing the HW, it always get this 

ata1: no device found (phy stat 8276fffe)

Looking at the code, it looks like the SATA status register never gets cleared.

I'm using the version 2.6.6-rc1 version of the kernel and this is what I get
(I also enabled the "Driver Core verbose debug messages")

cat /var/log/messages
[snip]
Apr 28 20:06:28 vanessa kernel: PCI: Found IRQ 10 for device 0000:00:05.0
Apr 28 20:06:28 vanessa kernel: ata_device_add: ENTER
Apr 28 20:06:28 vanessa kernel: ata_host_add: ENTER
Apr 28 20:06:28 vanessa kernel: ata_port_start: prd alloc, virt f763b000, dma 3763b000
Apr 28 20:06:28 vanessa kernel: ata1: SATA max UDMA/133 cmd 0xEFF0 ctl 0xEFE6 bmdma 0xEF90 irq 10
Apr 28 20:06:28 vanessa kernel: ata_host_add: ENTER
Apr 28 20:06:28 vanessa kernel: ata_thread_iter: ata1: thr_state THR_PROBE_START
Apr 28 20:06:28 vanessa kernel: ata_port_start: prd alloc, virt f76f4000, dma 376f4000
Apr 28 20:06:28 vanessa kernel: ata2: SATA max UDMA/133 cmd 0xEFA8 ctl 0xEFE2 bmdma 0xEF98 irq 10
Apr 28 20:06:28 vanessa kernel: ata_device_add: probe begin
Apr 28 20:06:28 vanessa kernel: ata_device_add: ata1: probe begin
Apr 28 20:06:28 vanessa kernel: ata_device_add: ata1: probe-wait begin
Apr 28 20:06:28 vanessa kernel: ata_thread_iter: ata2: thr_state THR_PROBE_START
Apr 28 20:06:28 vanessa kernel: ata_thread_iter: ata1: new thr_state THR_PORT_RESET, returning 0
Apr 28 20:06:28 vanessa kernel: ata_thread_iter: ata1: thr_state THR_PORT_RESET
Apr 28 20:06:29 vanessa kernel: ata1: no device found (phy stat 8276fffe)
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata1: new thr_state THR_PROBE_FAILED, returning 0
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata1: thr_state THR_PROBE_FAILED
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata1: new thr_state THR_AWAIT_DEATH, returning 0
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata1: thr_state THR_AWAIT_DEATH
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata1: new thr_state THR_AWAIT_DEATH, returning -1
Apr 28 20:06:29 vanessa kernel: ata_device_add: ata1: probe-wait end
Apr 28 20:06:29 vanessa kernel: scsi1 : sata_sis
Apr 28 20:06:29 vanessa kernel: ata_device_add: ata2: probe begin
Apr 28 20:06:29 vanessa kernel: ata_device_add: ata2: probe-wait begin
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata2: new thr_state THR_PORT_RESET, returning 0
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata2: thr_state THR_PORT_RESET
Apr 28 20:06:29 vanessa kernel: ata2: no device found (phy stat 008f0f98)
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata2: new thr_state THR_PROBE_FAILED, returning 0
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata2: thr_state THR_PROBE_FAILED
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata2: new thr_state THR_AWAIT_DEATH, returning 0
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata2: thr_state THR_AWAIT_DEATH
Apr 28 20:06:29 vanessa kernel: ata_thread_iter: ata2: new thr_state THR_AWAIT_DEATH, returning -1
Apr 28 20:06:29 vanessa kernel: ata_device_add: ata2: probe-wait end
Apr 28 20:06:29 vanessa kernel: scsi2 : sata_sis
Apr 28 20:06:29 vanessa kernel: ata_device_add: probe begin
Apr 28 20:06:29 vanessa kernel: ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 62 f7 6c
Apr 28 20:06:29 vanessa kernel: ata_device_add: EXIT, returning 2
[snip]

Below is my HD description
MB P4S800D
SATA controller SIS 964/180
SATA HD MAXTOR D.MaxPlus9 6Y160P0
3 IDE devices

I'm not part of this mailing list so, please, if you whish, CC me to this address
lapo.pasqui@tele2.it

Could it be a Mother board related issue?
Can somebody help? Can someone provide me with a datasheet for the SIS 964 chip and or the meaning of the 0x8276fffe value for the register?
I would like to help (and to be helped ;)

Thanks a lot
  Lapo

-------------------------------------------------
WebMail Tele2 http://www.tele2.it
-------------------------------------------------

