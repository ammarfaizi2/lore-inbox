Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVBKO24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVBKO24 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 09:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVBKO24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 09:28:56 -0500
Received: from nina-2.cs.keele.ac.uk ([160.5.89.35]:16833 "EHLO
	nina.cs.keele.ac.uk") by vger.kernel.org with ESMTP id S262170AbVBKO2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 09:28:52 -0500
Subject: aacraid fails under kernel 2.6
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Feb 2005 14:28:52 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1Czbmu-0006yr-00@nina.cs.keele.ac.uk>
From: Jonathan Knight <jonathan@cs.keele.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We are having major problems with the aacraid module under fedora core 2 on
Dell poweredge 2500.  These use PERC3/Di controllers.

01:02.1 RAID bus controller: Dell Computer Corporation PowerEdge Expandable RAID Controller 3 (rev 01)
01:0c.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
01:0c.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)


interrupts are shared:

           CPU0
  0:   16288777          XT-PIC  timer
  1:         12          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:    2332026          XT-PIC  aic7xxx, aacraid, eth0
  7:       4402          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:          1          XT-PIC  ohci_hcd
 11:    1636985          XT-PIC  aic7xxx, eth1
 12:         66          XT-PIC  i8042
 14:        489          XT-PIC  ide0
NMI:          0
ERR:       4070

We had no problems with Redhat 9 running a 2.4 kernel, but since our move to
Fedora and the 2.6 kernel nothing has worked well.  The latest 2.6.10 build
is the worst so far.  We've even gone and unpacked the rc3 for 2.6.11 and
dug out the aacraid controller but that didn't perform any better.  We think
2.6.8 was the most usable of the 2.6's so far.

The systems run fine with no users, but as soon as the disks go under load
we get the following:

Feb 10 08:20:56 romeo kernel: aacraid: Host adapter reset request. SCSI hang ?
Feb 10 08:21:56 romeo kernel: aacraid: SCSI bus appears hung
Feb 10 08:21:56 romeo kernel: scsi: Device offlined - not ready after error recovery: host 2 channel 0 id 0 lun 0
Feb 10 08:21:56 romeo kernel: SCSI error : <2 0 0 0> return code = 0x6000000
Feb 10 08:21:56 romeo kernel: end_request: I/O error, dev sdc, sector 296582775
Feb 10 08:21:56 romeo kernel: scsi2 (0:0): rejecting I/O to offline device
Feb 10 08:21:56 romeo last message repeated 4 times
Feb 10 08:21:56 romeo kernel: Buffer I/O error on device sdc1, logical block 33660323
Feb 10 08:21:56 romeo kernel: scsi2 (0:0): rejecting I/O to offline device
Feb 10 08:21:56 romeo kernel: Buffer I/O error on device sdc1, logical block 33660323
....and so on.


Careful rebooting shows nothing untoward on the raid array and the system
will start with no problems.

Does anyone know why these controllers are broken under 2.6 and whether
there is any workaround we can implement?


We did discover that the megaraid driver claims to support the PERC3/Di but
couldn't get the module to recognise the card.  A check on the source code
seems to show that the code for the PERC3/Di isn't present.

-- 
  ______    jonathan@cs.keele.ac.uk    Jonathan Knight,
    /                                  Department of Computer Science
   / _   __ Telephone: +44 1782 583437 University of Keele, Keele,
(_/ (_) / / Fax      : +44 1782 713082 Staffordshire.  ST5 5BG.  U.K.
