Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSHXVTj>; Sat, 24 Aug 2002 17:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSHXVTj>; Sat, 24 Aug 2002 17:19:39 -0400
Received: from ppp-62-10-61-205.dialup.tiscali.it ([62.10.61.205]:39040 "EHLO
	luca.lugbs.linux.it") by vger.kernel.org with ESMTP
	id <S316695AbSHXVTi>; Sat, 24 Aug 2002 17:19:38 -0400
Date: Sat, 24 Aug 2002 23:33:11 +0200
From: Luca Giuzzi <giuzzi@dmf.unicatt.it>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi (or ide-via?) with 2.4.20-pre*-ac*
Message-ID: <20020824233311.A6181@dmf.unicatt.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some weird problems when trying to write
a CD under a 2.4.20-pre*-ac* kernel [everything
works fine on the same computer with a
2.4.19-rc-ac1]. The CD writer is an LG-8080B
connected as slave to the secondary channel of a VIA
vt82c586b (rev. 47) controller.

Cdrecord, when I try to write an image at full speed
(that is, speed=8), aborts after the first 4 Mb with
the following error:

cdrecord: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 08 99 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x24 Qual 0x00 (invalid field in cdb) Fru 0x0
Sense flags: Blk 0 (not valid)

The weird thing is that, according to the "current writing
speed indication" (I have tried several versions of cdrecord
as well, and right now I'm doing my tests with 1.11a30 which
should print the actual transfer rate --- it was just the same
error with 1.10, though), the computer claims it
was recording at "20.3x" at the time of the failure: something
seems to be very wrong indeed. 
If I re-run cdrecord forcing the speed to be "4x", then it
succeeds, even if the actual reported (and timed) speed is
"7.5x".

Further information:
 dma is turned off for the drive and toggling unmask-irq
 does not seem to change anything. The host adapter emulation
 is seen as the second SCSI controller, the first being an
 aic7850.

Is there any further test I can do?

kind regards,
 lg


