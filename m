Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbTFLPYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264865AbTFLPYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:24:48 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:21521 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S264862AbTFLPYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:24:47 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: CDEJECT for SCSI disks/ide-floppy in drivers/block/scsi_ioctl.c
Date: Thu, 12 Jun 2003 19:26:47 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306121919.05603.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least in 2.5.70 there is common drivers/block/scsi_ioctl.c that defines 
CDEJECT and is used by both SCSI and IDE ioctls. This fails for SCSI disks 
and should fail for ide-floppy as well (unverified for the lack of hardware). 
Both lock tray on open and that prevents media from being ejected (even if 
command appears to succeed).

This happens to sometimes work for CD-ROMs because they do not lock media when 
opened with O_NONBLOCK. It is not clear if this is a feature - device opened 
with O_NONBLOCK is still busy so it should be locked as well.

CDEJECT implementation should unlock tray first; is moving it into 
drivers/block/scsi_ioctl.c a long term goal? Would it make sense to add 
CDROM_LOCKDOOR ioctl to this file as well?

Hmm ... just realized it fails for ide-floppy that has specia case for Click! 
drive.  But then, it is impossible to add generic unlock command to 
scsi_iotcl.c as well. 

Thank you

-andrey
