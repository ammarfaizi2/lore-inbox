Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267311AbUG1Qyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267311AbUG1Qyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbUG1Qyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:54:36 -0400
Received: from math.ut.ee ([193.40.5.125]:64653 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S267311AbUG1Qya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:54:30 -0400
Date: Wed, 28 Jul 2004 19:54:05 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Strange SCSI error
Message-ID: <Pine.GSO.4.44.0407281948090.4018-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This on on a freshly installed Debian Sarge on a HP 712/60 (hppa),
kernel version 2.4.26-32-smp. The disk is 2.1G IBM:

53c700: Version 2.8 By James.Bottomley@HansenPartnership.com
scsi0: 53c710 rev 2
scsi0 : LASI SCSI 53c700
scsi0: (4:0) Synchronous at offset 8, period 100ns
  Vendor: IBM       Model: DORS-32160    !#  Rev: WA3E
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 4, lun 0
scsi0: (4:0) Enabling Tag Command Queuing
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)

Debian installed fine but on a following package installation I got the
same SCSI error I'm reporting now (at least 2 lines were the same, the
rest might have been different). I rebooted since it seemed to be
hanging and got this again just on boot. I can read the whole disk with
dd bs=1M fine.

ASC=4e ASCQ= 0 seems to mean "Overlapped commands attempted" - does this
mean the kernel got confused (by "tag starvation"?) and sent overlapping
commands?

scsi0 (4:0) Target is suffering from tag starvation.
scsi0 (4:0) broken device is looping in contingent allegiance: ignoring
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 38 a1 b2 00 00 04 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 39 e6 c8 00 00 02 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 3b a6 68 00 00 02 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 0b e6 6a 00 00 02 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 2d 61 b2 00 00 04 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 1c 61 c8 00 00 02 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 3b e1 b2 00 00 04 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 3b a1 d0 00 00 02 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 0b e1 b2 00 00 04 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 2d 61 cc 00 00 04 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 33 a1 d0 00 00 04 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 38 a1 ca 00 00 02 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 3b a5 c4 00 00 02 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 3b 6f ea 00 00 02 00
scsi0 (4:0) New error handler wants to abort command
        0x2a 00 00 36 e6 84 00 00 02 00
scsi0 (4:0) New error handler wants device reset
        0x2a 00 00 3b a6 68 00 00 02 00
scsi0 (4:0) New error handler wants BUS reset, cmd 10538000
        0x2a 00 00 3b a6 68 00 00 02 00
scsi0: Bus Reset detected, executing command 00000000, slot 00000000, dsp 005504a8[04a8]
 failing command because of reset, slot 00010520, cmnd 10538400
 failing command because of reset, slot 00010654, cmnd 10538200
 failing command because of reset, slot 00010788, cmnd 10538000
 failing command because of reset, slot 000108bc, cmnd 10538600
 failing command because of reset, slot 000109f0, cmnd 10537e00
 failing command because of reset, slot 00010b24, cmnd 10537c00
 failing command because of reset, slot 00010d8c, cmnd 10538a00
 failing command because of reset, slot 00010ec0, cmnd 10538c00
 failing command because of reset, slot 00010ff4, cmnd 10538e00
 failing command because of reset, slot 00011128, cmnd 10566000
 failing command because of reset, slot 0001125c, cmnd 10566400
 failing command because of reset, slot 00011390, cmnd 10566600
 failing command because of reset, slot 000114c4, cmnd 10566800
 failing command because of reset, slot 000115f8, cmnd 10538800
 failing command because of reset, slot 0001172c, cmnd 10566200
scsi0: (4:0) Synchronous at offset 8, period 100ns
SCSI disk error : host 0 channel 0 id 4 lun 0 return code = 8000000
Current sd08:05: sns = 70  b
ASC=4e ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00
0x00 0x4e 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xff
0xff 0xff 0xff 0x00 0x00 0x00 0x00
 I/O error: dev 08:05, sector 3589330

(and here the bootup continued).


-- 
Meelis Roos (mroos@linux.ee)

