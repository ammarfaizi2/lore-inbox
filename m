Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVHNUKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVHNUKw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 16:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVHNUKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 16:10:52 -0400
Received: from mail.linicks.net ([217.204.244.146]:28423 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932220AbVHNUKv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 16:10:51 -0400
Content-Disposition: inline
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE CD problems in 2.6.13rc6
Date: Sun, 14 Aug 2005 21:10:49 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200508142110.49598.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just remember a path I took when resolving the issue further to my post 
below.

Here is what man hdparm says on -i and -I:

       -i     Display  the  identification info that was obtained from the 
drive at boot time,
              if available.  This is a feature of modern IDE drives, and may 
not be  supported
              by  older  devices.   The  data returned may or may not be 
current, depending on
              activity since booting the system.  However, the current  
multiple  sector  mode
              count is always shown.  For a more detailed interpretation of 
the identification
              info, refer to AT Attachment Interface for Disk Drives (ANSI ASC 
X3T9.2  working
              draft, revision 4a, April 19/93).

       -I     Request identification info directly from the drive, which is 
displayed in a new
              expanded format with considerably more detail  than  with  the  
older  -i  flag.
              There is a special "no seatbelts" variation on this option, 
-Istdin which cannot
              be combined with any other options, and which  accepts  a  drive  
identification
              block  as  standard  input instead of using a /dev/hd* 
parameter.  The format of
              this block must be exactly the same as that found in  
the  /proc/ide/*/hd*/iden­
              tify  "files".   This  variation  is  designed for use with 
"libraries" of drive
              identification information, and can also be used on ATAPI drives 
which may  give
              media errors with the standard mechanism.

Note the last sentence:

' This  variation  is  designed for use with "libraries" of drive 
identification information, and can also be used on ATAPI drives which may  
give  media errors with the standard mechanism.

Nick

Voluspa wrote:
> The "hdparm -I /dev/hdc"
>
> hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hdc: drive_cmd: error=0x04 { AbortedCommand }
> de: failed opcode was: 0xec
>
> Is present on all kernels that I have locally (oldest 2.6.11.11)
> so it is not related to the threadstarters problems, it seems.

Hi all,

Maybe teaching you all to suck eggs here, but I used to get this a lot on my
CD's - KDE ran some probe and as the CD[s] where empty logs filled up rapidly
with that error.  I thought the[a] drive was duff, so bought a new CD-RW.

Made no difference :-/  I then investigated further, and read that instead of
the SCSI emulation, it was superceded by IDE-CD.

kernel 2.6.12.3

Kernel command line: BOOT_IMAGE=Nicks ro root=303 hdc=ide-cd hdd=ide-cd

Fixed the issue for me.  But as I say, teaching to suck eggs, but I thought I
would mention it.

Nick
--
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

-------------------------------------------------------

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
