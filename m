Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753561AbWKMAKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbWKMAKA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 19:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753583AbWKMAKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 19:10:00 -0500
Received: from nz-out-0102.google.com ([64.233.162.202]:6870 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1753561AbWKMAJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 19:09:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=HIkgs53M4RR5X3CLSBmUgA0ODSu3RYj3E2WtxaMeECGE2JUUm1aEAcHNOLRTk2YsV6ky4tMUCJ7gyuukqmtnmY3xaUqOODSOvy1wUxFur7HV2CaaEtcPTuMD+upZHvbDC9L5MtU9Ad3D7a1gFkAkIWuPIrPzqBS6n4RrS3p/JXY=
Message-ID: <4557B7D2.2050004@gmail.com>
Date: Sun, 12 Nov 2006 17:09:54 -0700
From: "Berck E. Nash" <flyboy@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.6.18 - AHCI detection pauses excessively
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AHCI pauses heartily on during detection boot, but eventually proceeds. 
  I've mentioned the problem before, but have since narrowed it down a 
bit.  The problem does not occur in 2.6.17.3, but does occur in 2.6.18. 
  The problem is still occurring both in 2.6.19-rc5 as well as 
2.6.19-rc5-mm1.

Please cc me on replies since I am not subscribed to LKML.

Messages surrounding the hang:

scsi2 : ahci
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata2: port is slow to respond, please be patient (Status 0x80)
ata2: port failed to respond (30 secs, Status 0x80)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA
ata2.00: ata2: dev 0 multi count 1
ata2.00: configured for UDMA/133

I should note that on this system ata1 and ata3 both detect quickly, but 
they have 1.5 Gbps devices whereas ata2 has a 3.0Gbps device.

The device:
00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) 
Serial ATA Storage Controller AHCI (rev 01) (prog-if 01 [AHCI 1.0])
         Subsystem: ASUSTeK Computer Inc. Unknown device 2606
         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 50
         I/O ports at e400 [size=8]
         I/O ports at e080 [size=4]
         I/O ports at e000 [size=8]
         I/O ports at dc00 [size=4]
         I/O ports at d880 [size=16]
         Memory at febfb800 (32-bit, non-prefetchable) [size=1K]
         Capabilities: <access denied>

dmesg snip from 2.6.17.3, without the hangup:

scsi1 : ahci
ata2: port reset, p_is 40000001 is 2 pis 0 cmd 4017 tf 451 ss 123 se 0
ata2: SATA link up 3.0 Gbps (SStatus 123)
ata2: dev 0 cfg 49:2f00 82:0068 83:5060 84:4000 85:0000 86:1000 87:4000 
88:407f
ata2: dev 0 ATA-6, max UDMA/133, 640 sectors: LBA
ata2: dev 0 configured for UDMA/133


Thanks,
Berck
