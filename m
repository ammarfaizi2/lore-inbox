Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTEEQTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTEEQTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:19:39 -0400
Received: from franka.aracnet.com ([216.99.193.44]:5047 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262490AbTEEQSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:18:37 -0400
Date: Mon, 05 May 2003 09:30:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 645] New: Not enough ptys
Message-ID: <9410000.1052152234@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=645

           Summary: Not enough ptys
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: shawk@gmx.net


Distribution: Gentoo
Hardware Environment: AMD 2700+, ECS K7VTA3 Rev5.0
Software Environment: kernel 2.5.68, noapic passed to kernel, gcc 3.2.2,
glibc 2.3.1, using /dev filesystem

Problem Description: 

Using the kernel 2.5.68 I am unable to open any terminals or consoles when
working with X, however no error message is given. They simply woun't load.
Using the command "startx" results in "not enough ptys" and refuses to load.
I checked the net and mailing lists, but none of the older topics like not
having /dev/ptyd* /dev/ptys* or /dev/pts do apply. I found them all on my
system. 

I tested Kernels 2.5.63 and 2.5.67 and both work flawlessy there. I compiled
both 2.5.68 and 2.5.67 with the same options, and only 2.5.68 showed this
behavior.

Kernel Settings concerning PTY :
CONFIG_DEVPTS_FS=y (tried without this option, no change in behavior)
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256


Diffing drivers/char/pty.c on both kernels results in the following output:

# diff /usr/src/linux-2.4.67/drivers/char/pty.c
/usr/src/linux-2.5.68/drivers/char/pty.c
308d307
< extern void tty_register_devfs (struct tty_driver *driver, unsigned int
flags, unsigned minor);
336,342d334
<
<       /*  Register a slave for the master  */
<       if (tty->driver.major == PTY_MASTER_MAJOR)
<               tty_register_devfs(&tty->link->driver,
<                                  DEVFS_FL_CURRENT_OWNER | DEVFS_FL_WAIT,
<                                  tty->link->driver.minor_start +
<
minor(tty->device)-tty->driver.minor_start);

Maybe its related to this?
Simply copying the file from .67 into the .68 kernel will result in a break
when trying to compile.

If you need any more information please let me know.

Steps to reproduce: simply compile 2.5.68 kernel on my PC


