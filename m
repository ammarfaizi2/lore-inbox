Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTBSTr0>; Wed, 19 Feb 2003 14:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbTBSTrZ>; Wed, 19 Feb 2003 14:47:25 -0500
Received: from dhcp43.ists.dartmouth.edu ([129.170.249.143]:36993 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id <S264610AbTBSTrW>;
	Wed, 19 Feb 2003 14:47:22 -0500
Message-Id: <200302192000.h1JK0ZC16421@uml.karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Feb 2003 15:00:35 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fixes-2.5

This fixes some UML bugs, including
	some signal blocking bugs
	a 'tracing myself' bug
	a uaccess fencepost bug

Also, there were a number of code cleanups, particularly in the ubd driver.
That driver now locks the host files that it uses to prevent multiple UMLs
from booting on the same filesystem.

stdout is now flushed before entering the kernel to ensure that early messages
appear before printk output.

				Jeff

 arch/um/drivers/line.c                |    6 
 arch/um/drivers/ubd_kern.c            |  221 +++++++++++++++++++---------------
 arch/um/drivers/ubd_user.c            |   44 ++++--
 arch/um/include/os.h                  |    2 
 arch/um/kernel/mem.c                  |    2 
 arch/um/kernel/skas/include/uaccess.h |    2 
 arch/um/kernel/tt/process_kern.c      |   18 +-
 arch/um/kernel/um_arch.c              |    1 
 arch/um/os-Linux/file.c               |   31 ++++
 include/asm-um/common.lds.S           |   12 +
 10 files changed, 218 insertions(+), 121 deletions(-)

ChangeSet@1.1065, 2003-02-19 11:05:33-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5

ChangeSet@1.988.6.2, 2003-02-19 09:55:14-05:00, jdike@uml.karaya.com
  Fixed signal blocking and cleaned up the code a bit.

ChangeSet@1.925.56.32, 2003-02-07 13:48:13-05:00, jdike@uml.karaya.com
  Fixed a few compilation bugs in the ubd changes.

ChangeSet@1.925.56.31, 2003-02-07 12:52:23-05:00, jdike@uml.karaya.com
  Merged in changes from 2.4 up to 2.4.19-50.
  The ubd driver locks its files.
  Merged a bunch of ubd fixes from James McMechan.
  stdout is now flushed before entering the kernel.
  Fixed a uaccess fencepost bug.
  Fixed a 'tracing myself' bug.
  Various other cleanups and error message fixes.



