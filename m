Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbTLFSIA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 13:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbTLFSIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 13:08:00 -0500
Received: from sartre.ispvip.biz ([209.118.182.154]:39109 "HELO
	sartre.ispvip.biz") by vger.kernel.org with SMTP id S265224AbTLFSHu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 13:07:50 -0500
From: "Michael J. Cohen" <mjc@325i.org>
To: <gijoe@poczta.onet.pl>, <linux-kernel@vger.kernel.org>
Subject: RE: OOPS - ide-scsi bug - SCSI BUS number increasing
Date: Sat, 6 Dec 2003 13:07:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20031206171551.GA5917@us-pc3>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcO8HfGaO8x5QVrgTIW3EW1HnEwR7AABX2Vw
Message-Id: <S265224AbTLFSHu/20031206180750Z+1571@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from what I know, ide-scsi is broken in 2.6 and deprecated in favor of atapi
burning.  You can use cdrecord dev=/dev/hdx.  Patches would be much
appreciated though.

------
Michael J. Cohen

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of
gijoe@poczta.onet.pl
Sent: Saturday, December 06, 2003 12:16 PM
To: linux-kernel@vger.kernel.org
Subject: OOPS - ide-scsi bug - SCSI BUS number increasing




There is a bug in ide-scsi module (kernel version 2.6.0-test10 with enabled
preemptible kernel) - this bug causes SCSI BUS number to be increased by one

everytime ide-scsi module is reloaded  (modprobe -r ide-scsi then 
do modprobe ide-scsi) - it is easy to spot that with cdrecord -scanbus.
This bug doesn't appear to exist in 2.4 kernel series, I've not tested this
with 2.5 series though, this is not cdrtools fault since I tried both
versions
(2.00 and 2.00.3) with the same result.When ide-scsi is compiled into the
kernel, obviously the SCSI BUS number doesn't increase since there is no 
possibility to reload it during the same kernel session.

/proc/scsi/scsi says:

Attached devices:
Host: scsi13 Channel: 00 Id: 00 Lun: 00
  Vendor: LITE-ON  Model: LTR-48246S       Rev: SS0D
  Type:   CD-ROM                           ANSI SCSI revision: 02
  
  
And here is the reproduction of bug -

1) Before reloading ide-scsi, output of cdrecord -scanbus:

Linux sg driver version: 3.5.29
Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Using libscg version 'schily-0.7'
scsibus13:
	13,0,0	1300) 'LITE-ON ' 'LTR-48246S      ' 'SS0D' Removable CD-ROM
	13,1,0	1301) *
	13,2,0	1302) *
	13,3,0	1303) *
	13,4,0	1304) *
	13,5,0	1305) *
	13,6,0	1306) *
	13,7,0	1307) *
	
2) After preloading (modprobe -r ide-scsi && modprobe ide-scsi)

Linux sg driver version: 3.5.29
Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Using libscg version 'schily-0.7'
scsibus14:
	14,0,0	1400) 'LITE-ON ' 'LTR-48246S      ' 'SS0D' Removable CD-ROM
	14,1,0	1401) *
	14,2,0	1402) *
	14,3,0	1403) *
	14,4,0	1404) *
	14,5,0	1405) *
	14,6,0	1406) *
	14,7,0	1407) *
	
	
Output of uname -r:

2.6.0-test10-athlon

	
I was trying to fix this bug myself in ide-scsi.c code, but I unfortunately
I
don't know it's structure...


