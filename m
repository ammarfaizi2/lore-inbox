Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbUCCEoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbUCCEeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:34:31 -0500
Received: from mail.kroah.org ([65.200.24.183]:40322 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262371AbUCCEWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:22:05 -0500
Date: Tue, 2 Mar 2004 20:14:38 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core update for 2.6.4-rc1
Message-ID: <20040303041438.GA16958@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few driver core changes for 2.6.4-rc1.  There are a few
patches from Randy Dunlap that finish up his big sys_* cleanups, and the
ibm service processor driver has been added as well as some other minor
bugfixes.  All of these patches have been in the -mm tree for a while
now.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 arch/arm/kernel/time.c                   |    2 
 arch/arm/mach-integrator/integrator_ap.c |    2 
 arch/arm/mach-sa1100/irq.c               |    2 
 arch/i386/kernel/apic.c                  |    4 
 arch/i386/kernel/i8259.c                 |    4 
 arch/i386/kernel/nmi.c                   |    2 
 arch/i386/kernel/time.c                  |    2 
 arch/i386/oprofile/nmi_int.c             |    8 
 arch/mips/kernel/i8259.c                 |    4 
 arch/ppc/platforms/pmac_pic.c            |    2 
 arch/ppc/syslib/open_pic.c               |    2 
 arch/ppc/syslib/open_pic2.c              |    2 
 arch/x86_64/kernel/apic.c                |    4 
 arch/x86_64/kernel/i8259.c               |    4 
 arch/x86_64/kernel/mce.c                 |    4 
 arch/x86_64/kernel/nmi.c                 |    4 
 arch/x86_64/kernel/time.c                |    4 
 drivers/Kconfig                          |    2 
 drivers/base/Kconfig                     |   11 
 drivers/base/bus.c                       |    5 
 drivers/base/class.c                     |    5 
 drivers/base/class_simple.c              |    5 
 drivers/base/core.c                      |    5 
 drivers/base/cpu.c                       |    2 
 drivers/base/driver.c                    |    5 
 drivers/base/init.c                      |    4 
 drivers/base/node.c                      |    2 
 drivers/base/power/main.c                |    5 
 drivers/base/power/shutdown.c            |    7 
 drivers/base/sys.c                       |   19 
 drivers/char/misc.c                      |   24 -
 drivers/input/serio/i8042.c              |    4 
 drivers/misc/Kconfig                     |   17 
 drivers/misc/Makefile                    |    2 
 drivers/misc/ibmasm/Makefile             |   13 
 drivers/misc/ibmasm/command.c            |  175 +++++++
 drivers/misc/ibmasm/dot_command.c        |  146 ++++++
 drivers/misc/ibmasm/dot_command.h        |   78 +++
 drivers/misc/ibmasm/event.c              |  169 +++++++
 drivers/misc/ibmasm/heartbeat.c          |   91 +++
 drivers/misc/ibmasm/i2o.h                |   77 +++
 drivers/misc/ibmasm/ibmasm.h             |  224 +++++++++
 drivers/misc/ibmasm/ibmasmfs.c           |  717 +++++++++++++++++++++++++++++++
 drivers/misc/ibmasm/lowlevel.c           |   81 +++
 drivers/misc/ibmasm/lowlevel.h           |  137 +++++
 drivers/misc/ibmasm/module.c             |  210 +++++++++
 drivers/misc/ibmasm/r_heartbeat.c        |   98 ++++
 drivers/misc/ibmasm/remote.c             |  152 ++++++
 drivers/misc/ibmasm/remote.h             |  119 +++++
 drivers/misc/ibmasm/uart.c               |   72 +++
 drivers/s390/block/xpram.c               |   12 
 include/linux/sysdev.h                   |    4 
 lib/kobject.c                            |   11 
 53 files changed, 2695 insertions(+), 71 deletions(-)
-----

<masbock:us.ibm.com>:
  o Driver for IBM service processor - updated (2/2)
  o Driver for IBM service processor - updated (1/2)

Andrew Morton:
  o fix x86_64 build for sys_device_register rename

Greg Kroah-Hartman:
  o Driver core: add CONFIG_DEBUG_DRIVER to help track down driver core bugs easier
  o Make IBMASM driver depend on X86 as that is the only valid platform for it
  o kobject: clean up kobject_get() convoluted logic
  o kobject: fix kobject hotplug debug message to show more needed info

Randy Dunlap:
  o rename sys_bus_init()
  o sys_device_[un]register() are not syscalls

Stephen Hemminger:
  o propogate errors from misc_register to caller

