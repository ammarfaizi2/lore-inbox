Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSF2OxF>; Sat, 29 Jun 2002 10:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSF2OxE>; Sat, 29 Jun 2002 10:53:04 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:26872 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312681AbSF2OxE>; Sat, 29 Jun 2002 10:53:04 -0400
To: linux-kernel@vger.kernel.org
CC: Andrew Robert Mitchell <andrewm@cse.unsw.edu.au>,
       Alfred Ganz <alfred-ganz@agci.com>
Subject: Thinkpad 560 suspend/hibernate requires floppy 
Date: Sat, 29 Jun 2002 15:55:24 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E17OJdE-0000ne-00@coll.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sending again since I sent it to the wrong linux-kernel addr before.]

I almost always run into trouble suspending or hibernating my Thinkpad
560.  On some boots, it works once only.  On others it works many
times and then stops (it always stops working if I put in a Zoom modem
card).  I've tried many different kernels, all with the same problem.

Now I follow a mix of advice that I got when I mentioned this problem
before on linux-kernel, and I can now suspend/hibernate whenever I
want.  Why does the procedure below fix the problem?  Let me know if
there are diagnostics that I can run to help track down this problem.

First, the advice:

>From Alfred Ganz --

  In addition to the proper APM driver configuration, the critical
  element is that the Floppy Disk drive MUST BE configured as a module!

>From Andrew Mitchell --

  attach the floppy disk drive
  Remove any floppies from the floppy drive.
  mount /mnt/floppy
  (it gives an error)
  bingo, you can now suspend!

I have the floppy driver as a module.  I don't follow Andrew
Mitchell's advice exactly (since I just dug it out), but instead
insert a random DOS-formatted floppy into the drive and do "cat <
/dev/fd0 > /dev/null" and interrupt it soon.  Then I'm golden.

System: IBM Thinkpad 560, bios v1.11, kernel 2.4.18 (RH's 2.4.18-4
kernel without the unneeded modules).

Relevant .config lines:

CONFIG_BLK_DEV_FD=m

CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

-Sanjoy
