Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316355AbSGATtu>; Mon, 1 Jul 2002 15:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSGATts>; Mon, 1 Jul 2002 15:49:48 -0400
Received: from www.transvirtual.com ([206.14.214.140]:7699 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316355AbSGATtk>; Mon, 1 Jul 2002 15:49:40 -0400
Date: Mon, 1 Jul 2002 12:52:00 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] New Console system BK
Message-ID: <Pine.LNX.4.44.0207011232450.27788-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since 2.5.1 I have placed into the kernel part of the new console system
code into the DJ tree. So it has been well tested. I was hoping to have
all the keyboard devices ported over to the input api and the fbdev
drivers over to the new api. Unfortunely due to time restraints this will
not be the case. So here goes the first installment of the new console
system. Please test it yourselves and I will push it to Linus soon.

The goal is to create a system we can use keyboards without the console
system and the same true for framebuffer devices. This is most helpful on
embedded devices. The other goals to make the VT console system more
modular and lighter weight. The other goal is to make the VT tty system
multi-desktop.

Here are the changes so far:

I) Removal of struct kbd_struct from the sysrq handler. Why drag itr along
   when only two sysrq functions actually use it.

II) Massive rewrite and cleanup of keybaord.c.

III) Place struct tty_struct into struct vc_data. This sets up a one to
     one relationship. Avoids the nasty tricks of playing with fields from
     console_driver.

IV) Cleanup of VT tty/console initialization. A vty_init function to make
    it cleaner.

diffstat:

 arch/i386/kernel/apm.c         |    2
 arch/ppc/xmon/start.c          |    2
 arch/ppc64/xmon/start.c        |    2
 drivers/acpi/system.c          |    2
 drivers/char/console.c         |   82 ++--
 drivers/char/keyboard.c        |  779 +++++++++++++++++++++--------------------
 drivers/char/sysrq.c           |   46 +-
 drivers/char/tty_io.c          |   15
 include/linux/console_struct.h |    1
 include/linux/sysrq.h          |   13
 11 files changed, 485 insertions(+), 459 deletions(-)


The BK patch is at:

 http://linuxconsole.bkbits.net/dev

diff:

 http://www.transvirtual.com/~jsimmons/console.diff.gz

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/


