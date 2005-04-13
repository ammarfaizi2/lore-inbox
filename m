Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVDMR0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVDMR0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 13:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVDMR0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 13:26:07 -0400
Received: from passcal.passcal.nmt.edu ([129.138.26.245]:25222 "EHLO
	passcal.passcal.nmt.edu") by vger.kernel.org with ESMTP
	id S261157AbVDMRZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 13:25:35 -0400
Subject: compact flash bug introduce 2.4.21
From: Lloyd Carothers <lloyd@passcal.nmt.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 13 Apr 2005 11:25:34 -0600
Message-Id: <1113413134.7148.234.camel@firestorm.passcal.nmt.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
 A bug was introduced in 2.4.20. I determined this with a Barthomje,
pardon my misspelling, is he still on this team, a few months back, I
now have the logs of the card being inserted into the same laptop with
the 2.4.20 and the 2.4.21.
 The problem cf cards are SimpleTech 1GB.
 Used with a pcmcia adapter on IBM thinkpads, I get the same results
with other laptops.
 All other brands of CF I tried work fine through 2.6.10

 The errors repeat for a while I put them all in


2.4.20
...
Mar  7 00:35:26 localhost cardmgr[995]: socket 0: ATA/IDE Fixed Disk
Mar  7 00:35:26 localhost kernel: cs: memory probe
0xa0000000-0xa0ffffff: clean.
Mar  7 00:35:27 localhost kernel: hde: STI Flash S.1.0, ATA DISK drive
Mar  7 00:35:28 localhost kernel: ide2 at 0x100-0x107,0x10e on irq 3
Mar  7 00:35:28 localhost kernel: hde: 2002896 sectors (1025 MB) w/1KiB
Cache, CHS=1987/16/63
Mar  7 00:35:28 localhost kernel:  hde: [PTBL] [993/32/63] hde1
Mar  7 00:35:28 localhost kernel: ide_cs: hde: Vcc = 3.3, Vpp = 0.0
Mar  7 00:37:17 localhost kernel:  hde: hde1
...

2.4.21
...
Mar  7 00:35:27 localhost kernel: hde: STI Flash S.1.0, ATA DISK drive
Mar  7 00:35:28 localhost kernel: ide2 at 0x100-0x107,0x10e on irq 3
Mar  7 00:35:28 localhost kernel: hde: 2002896 sectors (1025 MB) w/1KiB
Cache, CHS=1987/16/63
Mar  7 00:35:28 localhost kernel:  hde: [PTBL] [993/32/63] hde1
Mar  7 00:35:28 localhost kernel: ide_cs: hde: Vcc = 3.3, Vpp = 0.0
Mar  7 00:37:17 localhost kernel:  hde: hde1
...

Mar  7 00:41:54 localhost cardmgr[993]: socket 0: ATA/IDE Fixed Disk
Mar  7 00:41:54 localhost kernel: cs: memory probe
0xa0000000-0xa0ffffff: clean.
Mar  7 00:41:54 localhost kernel: hde: STI Flash S.1.0, CFA DISK drive
Mar  7 00:41:57 localhost kernel: ide2 at 0x100-0x107,0x10e on irq 3
Mar  7 00:41:57 localhost kernel: hde: attached ide-disk driver.
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: hde: 2002896 sectors (1025 MB) w/1KiB
Cache, CHS=1987/16/63
Mar  7 00:41:57 localhost kernel:  hde:hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: end_request: I/O error, dev 21:00
(hde), sector 0
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: end_request: I/O error, dev 21:00
(hde), sector 2
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: end_request: I/O error, dev 21:00
(hde), sector 4
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: end_request: I/O error, dev 21:00
(hde), sector 6
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: end_request: I/O error, dev 21:00
(hde), sector 0
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: end_request: I/O error, dev 21:00
(hde), sector 2
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: end_request: I/O error, dev 21:00
(hde), sector 4
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel: ide2: reset: success
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }
Mar  7 00:41:57 localhost kernel: 
Mar  7 00:41:57 localhost kernel: end_request: I/O error, dev 21:00
(hde), sector 6
Mar  7 00:41:57 localhost kernel: hde: drive not ready for command
Mar  7 00:41:57 localhost kernel:  unable to read partition table
Mar  7 00:41:57 localhost kernel: ide_cs: hde: Vcc = 3.3, Vpp = 0.0
Mar  7 00:41:57 localhost kernel: hde: status error: status=0x20
{ DeviceFault }


thanks in advance
-- 
Lloyd Carothers
IRIS PASSCAL Instrument Center
100 East Road
Tech Industrial Park
New Mexico Institute of Mining and Technology
Socorro,  New Mexico  87801

lloyd@passcal.nmt.edu
www.passcal.nmt.edu
ph 505-835-5083
fax 505-835-5079

