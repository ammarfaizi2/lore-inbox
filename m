Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSGNNP5>; Sun, 14 Jul 2002 09:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316567AbSGNNP4>; Sun, 14 Jul 2002 09:15:56 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:34301 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316542AbSGNNP4>; Sun, 14 Jul 2002 09:15:56 -0400
Date: Sun, 14 Jul 2002 15:17:14 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141317.g6EDHEaK019069@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

Please stop calling ATAPI as SCSI over IDE, it is not. It is Packet
Interface over ATA (IDE). Some ATAPI/SCSI devices are functionally
equivalent because they support the same command set (i.e. MMC).

Did you ever looks at the ATAPI specs?

ATAPI _is_ SCSI over IDE with a few "bugs"/deviations:

-	The inquiry format uses wrong protocol version numbers.
	
	This mainly gives provblems with creating Mode sense / mode select
	commands. If you know (e.g. from MMC-3) that the transport is
	IDE, then you just bump the version to 2 and it works.

-	6-byte SCSI commands in general are not supported. This is not
	a real problem for a well designed high level driver.

-	Commands that take a long time are allowed to behave as if
	the high level code did set the IMMED bit in the CDB.

	This can be handled if the high level code handles the
	resulting error codes for the following commands to 
	introduce a wait loop.

-	There is no disconnect/reconnect.

	This is nothing that high level code should be aware of.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
