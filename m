Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269250AbRGaLBK>; Tue, 31 Jul 2001 07:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269251AbRGaLA7>; Tue, 31 Jul 2001 07:00:59 -0400
Received: from gandalf.drinsama.de ([212.72.64.1]:52487 "EHLO
	gandalf.drinsama.de") by vger.kernel.org with ESMTP
	id <S269250AbRGaLAz>; Tue, 31 Jul 2001 07:00:55 -0400
From: "Thomas Tanner" <tanner@ffii.org>
To: <linux-kernel@vger.kernel.org>
Subject: harddisk suddenly locked?!
Date: Tue, 31 Jul 2001 13:00:07 +0200
Message-ID: <MABBKEJEMCFLBEDCGCDNGEABCAAA.tanner@ffii.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Please help me! I'm desperate

 I can't access the data on my harddrive any longer ;-((

 The IBM Disk Fitness Test tool tells me:
   Model                   : IBM-DJNA-372200
   Microcode level         : J71OA30K
   ATA Compliance          : ATA-4
  ...
   Settings
  ...
     S.M.A.R.T. status     : Good
     Security feature      : Supported
       Password            : Set
       Password level      : High
       Security mode       : Locked

 However, I haven't set any password. I don't even know how to set it!!
 My system is (was) Linux 2.4.7 with PIIX support and "SCSI over IDE"
enabled,
 experimental IDE code disabled.
 After booting the system and leaving it one hour alone (idle, no internet
connection)
 I wanted to start XWindows (4.01). However, it switched the video mode and
suddenly
 locked up for ~10 sec. I pressed Ctrl-Alt-Backspace/Del several times to
reboot.
 After some seconds it responded and seemed to shut down as usual.
 Since then the hd is locked and I don't know why.

 According to the ATA-3 specification there are two passwords: a master and
a user password.
 The passwords are stored in the EPROM of the hd and are certainly very very
hard to remove.
 A locked drive rejects all media access commands.
 When a new master password is set, the drive won't be locked.
 Setting a new user password locks the drive the next time it is powered-on.
 A drive can be unlocked by one of the two passwords.
 IBM sets the master password to all ASCII blanks (0x20) during
 manufacturing.

 To unlock a drive one has to send the command SECURITY UNLOCK (0xBB)
 and transfer a single sector to the drive:
 Word
 0     Bit 0 Identifier: 0=compare user password, 0=compare master password
 1-16  Password (32 Bytes)
 17-255 reserved

 Word 128 of the Identify Drive command contains the Security status:
 Bit
 8 : Security level  0=High (can be unlocked), 1=Maximum (disk must be
erased)
 4 : 1=Security count expired (more than five failed unlock tries,
hard-reset necessary)
 3 : 1=Security frozen (all security commands aborted)
 2 : 1=Security locked (media access not allowed)
 1 : 1=Security enabled
 0 : 1=Security supported

 Something must have sent a lock command to my hd. Maybe a bug in the IDE
code?
 I hope to be able to unlock my drive using the default master password.
 My question is: how can I send the unlock command to the hd?
 Is there any program that can do it?
 AFAICS one can send only the command code using a HDIO_DRIVE_CMD ioctl.
 But how can I transfer the password?

 Any ideas?

 Thank you very much in advance!

PS: please CC to me

Thomas Tanner-------------------
tanner@(ffii.org|gnu.org|gmx.de)

