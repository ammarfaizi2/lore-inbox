Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWG3S0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWG3S0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWG3S0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:26:16 -0400
Received: from lilly.ping.de ([83.97.42.2]:62224 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id S932409AbWG3S0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:26:16 -0400
Date: Sun, 30 Jul 2006 20:10:19 +0200
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Question about "Not Ready" SCSI error
Message-ID: <20060730181014.GA13456@oscar.prima.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo everyone

Today one of my SCSI drives decided to shutdown for no obvious reason.
I suspect heat or a bad power supply. Syslog shows a repeating stream
of the following:

Jul 30 15:51:30 tony kernel: sd 0:0:0:0: Device not ready: <6>: Current: sense key=0x2
Jul 30 15:51:30 tony kernel: ASC=0x4 ASCQ=0x2
Jul 30 15:51:30 tony kernel: end_request: I/O error, dev sda, sector 617358

Google revealed[1] that the drive is waiting for a START UNIT command,
but it seems that the kernel is not attempting to spin up the drive
again. 

After a complete power-cycle the drive worked again. I just wanted to
know if this is a shortcoming in the SCSI error handling codepath.

Regards,
Patrick

Additional Info:

Kernel:		2.6.18-git (from 29-July-2006)

SCSI HW:	Adaptec 3960D Ultra160 SCSI adapter
		aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

Harddisk:	Vendor: IBM
		Model: IC35L036UCD210-0
		Rev: S5BA
		Type: Direct-Access
		ANSI SCSI revision: 03
		Tagged Queuing enabled.  Depth 64
		FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)

[1] http://en.wikipedia.org/wiki/KCQ
2     04      02      Not Ready - need initialise command (start unit)

