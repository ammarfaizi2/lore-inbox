Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292751AbSBUUYH>; Thu, 21 Feb 2002 15:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292757AbSBUUYA>; Thu, 21 Feb 2002 15:24:00 -0500
Received: from mgw-dax2.ext.nokia.com ([63.78.179.217]:53955 "EHLO
	mgw-dax2.ext.nokia.com") by vger.kernel.org with ESMTP
	id <S292751AbSBUUXq> convert rfc822-to-8bit; Thu, 21 Feb 2002 15:23:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: ide cd-recording not working in 2.4.18-rc2-ac1
Date: Thu, 21 Feb 2002 12:23:43 -0800
Message-ID: <4D7B558499107545BB45044C63822DDE3A201E@mvebe001.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ide cd-recording not working in 2.4.18-rc2-ac1
Thread-Index: AcG6ihw6QPgKAQiNSVK9TdnV9TXKUgAiJLiQ
From: <Tony.P.Lee@nokia.com>
To: <ed.sweetman@wmich.edu>, <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Feb 2002 20:23:44.0436 (UTC) FILETIME=[A8D58F40:01C1BB15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Wed, 2002-02-20 at 20:54, Alan Cox wrote:
> > > I get this on every cd I try and I've tried more than I'd 
> have liked to.
> > > 
> > > Performing OPC...
> > > 
> > /usr/bin/cdrecord: Input/output error. write_g1: scsi 
> sendcmd: no error
> > > CDB:  2A 00 00 00 00 1F 00 00 1F 00
> > > status: 0x2 (CHECK CONDITION)
> > > Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 21 00 00 00
> > > Sense Key: 0x5 Illegal Request, Segment 0
> > > Sense Code: 0x21 Qual 0x00 (logical block address out of 
> range) Fru 0x0
> > 
> > Thats saying that cdrecord sent the drive a bogus command.
> > 
> > > Now I know every cd isn't bad because they used to work in older
> > > 2.4.17ish kernels.  I have scsi-generic support compiled 
> as a module as
> > 
> > Does it still work with them ?
> > 
> > > SCSI subsystem driver Revision: 1.00
> > > scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> > 
> > Right same as I am using
> > 
> > > not sure what else I can get informationwize about what 
> the drive is
> > > doing.  
> > 
> > What type of IDE controller ?
> 
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
> 
> 
> If i retry over and over sometimes it will eventually work.  
> (same cd)  
> 
> 
> 

In my previous project (4 years ago), I worked on HP/Philips' CDR/W drive's 
(2600 IDE, SCSI 2x drive) firmware.  

OPC is Optical (P something) Calibration.  If the CDR program is designed
correctly (like Easy CD Creator), it issues the the calibrated command and record
the calibrated value and that CDR(W) disk ID in the PC.  So the drive
doesn't have to recalibrate again if the same CDR(W) is inserted back for 
packet writing or multi-session writing.  CDR disk has limited (10) "calibration
area" to perform the this calibration procedure.  When all 10 calibration areas are
used, you can't calibrate for that CDR anymore and you can not write to that
CDR disk neither.  If you do disk at once or just writing a few session this is not
an issue.   It is only an issue for packet writing or Track and once and you have to 
reject and reuse the same disk > 10 times.   CDRW disk can reuse the calibrate area.  
You can try that drive with CDRW disk.  But like Rogier Wolff said, it is very likely 
be the CDR drive issue instead of SCSI/IDE issue.

--
Tony Lee           Nokia Networks, Inc. 
