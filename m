Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbULWCb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbULWCb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 21:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbULWCb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 21:31:27 -0500
Received: from legolas.drinsama.de ([62.91.17.164]:54162 "EHLO
	legolas.drinsama.de") by vger.kernel.org with ESMTP id S261154AbULWCbT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 21:31:19 -0500
Date: Thu, 23 Dec 2004 03:28:43 +0100
From: Erich Schubert <erich@debian.org>
To: linux-kernel@vger.kernel.org
Subject: sbp2/ieee1394 driver problems with drive spin down
Message-ID: <20041223022843.GB16681@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-GPG: 4B3A135C 6073 C874 8488 BCDA A6A9  B761 9ED0 78EF 4B3A 135C
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.6+20040907i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have an external ieee1394 drive using the sbp2 driver. It usually
works fine, except for two issues:
- After a SoftwareSuspend cycle the drive does not work (ieee1394
appears to detect the drive, but it won't work or appear in scsi emu)
- Sometime the drive powers spins down, then spins immediately up again.
even after detach, powerdown of the drive, reattach, it will not work
again, any file transfers are lost. I need to reboot the PC. Removing
the sbp2 or ieee1394 driver will lock up the system.

Any idea here? Someone suggested me fakephp. This might give me the
possibility to reattach the drive, but it will not help with the drive
just spinning down sometimes.

I transferred ~80 GB to the drive these days without problems. Now i was
editing a text file on the drive when it spun down... :-(

I do not think it is a power saving spindown. It happened once while I
was writing to a DVD from the drive.

Sorry - I cannot provide you with much details on the error. All I have
are the following messages:

ieee1394: sbp2: aborting sbp2 command
Write (10) 00 0c 84 02 47 00 00 08 00·
ieee1394: sbp2: aborting sbp2 command
Test Unit Ready 00 00 00 00 00·
ieee1394: sbp2: reset requested
ieee1394: sbp2: Generating sbp2 fetch agent reset
ieee1394: sbp2: aborting sbp2 command
Test Unit Ready 00 00 00 00 00·
ieee1394: sbp2: reset requested
ieee1394: sbp2: Generating sbp2 fetch agent reset
ieee1394: sbp2: aborting sbp2 command
Test Unit Ready 00 00 00 00 00·
ieee1394: sbp2: reset requested
ieee1394: sbp2: Generating sbp2 fetch agent reset
ieee1394: sbp2: aborting sbp2 command
Test Unit Ready 00 00 00 00 00·
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
SCSI error : <0 0 0 0> return code = 0x50000
end_request: I/O error, dev sda, sector 209977927



Update: For some tests (disabling power management or so using hdparm)
i had the drive attached to USB when the same happened:

usb 2-1: reset full speed USB device using uhci_hcd and address 3
usb 2-1: reset full speed USB device using uhci_hcd and address 3
hub 2-0:1.0: port 1 disabled by hub (EMI?), re-enabling...
usb 2-1: device not accepting address 3, error -22
usb 2-1: reset full speed USB device using uhci_hcd and address 3
usb 2-1: device descriptor read/64, error -19
usb 2-1: device descriptor read/64, error -19
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0

Looks a bit like a controller problem to me. Any hints on solving that?
But the sbp2/ieee1394 drivers should allow reattaching the drive after such a
failure.  The usb-storage driver does.

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
          There are only 10 types of people in the world:           //\
          Those who understand binary and those who don't           V_/_
   Jede Frau erwartet von einem Mann, dass er hält, was sie sich
                         von ihm verspricht.
