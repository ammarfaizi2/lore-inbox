Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264694AbSJOUdr>; Tue, 15 Oct 2002 16:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264742AbSJOUdr>; Tue, 15 Oct 2002 16:33:47 -0400
Received: from jdike.solana.com ([198.99.130.100]:10113 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S264694AbSJOUdp>;
	Tue, 15 Oct 2002 16:33:45 -0400
Message-Id: <200210152042.g9FKgP615722@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Assorted UML fixes and cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Oct 2002 16:42:25 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fixes-2.5

A number of crashes caused by UML being brought down by a signal are gone
A bunch of unused and redundant variables were removed
The tempfile code was moved into its own file
Removed a number of declarations of functions which no longer exist
More code calls into the OS interface when necessary

				Jeff
	

 arch/um/Makefile                |    5 --
 arch/um/Makefile-i386           |    2 
 arch/um/drivers/line.c          |    3 -
 arch/um/drivers/net_kern.c      |    2 
 arch/um/drivers/port_kern.c     |    1 
 arch/um/drivers/ssl.c           |   47 ++++++++++++-----------
 arch/um/drivers/stdio_console.c |   21 +++++-----
 arch/um/drivers/ubd_kern.c      |   27 ++++---------
 arch/um/include/line.h          |    5 --
 arch/um/include/tempfile.h      |   21 ++++++++++
 arch/um/include/user_util.h     |   18 --------
 arch/um/kernel/Makefile         |   13 +++---
 arch/um/kernel/ksyms.c          |    1 
 arch/um/kernel/process_kern.c   |    4 -
 arch/um/kernel/signal_user.c    |    2 
 arch/um/kernel/tempfile.c       |   79 +++++++++++++++++++++++++++++++++++++++
 arch/um/kernel/time_kern.c      |    1 
 arch/um/kernel/trap_user.c      |   13 +++---
 arch/um/kernel/tty_log.c        |    2 
 arch/um/kernel/um_arch.c        |    7 +--
 arch/um/kernel/user_util.c      |   81 ----------------------------------------
 arch/um/ptproxy/proxy.c         |    1 
 22 files changed, 178 insertions(+), 178 deletions(-)

ChangeSet@1.786, 2002-10-15 11:09:15-04:00, jdike@uml.karaya.com
  Fixed a bug caused by moving the location of the include of the
  arch and os Makefiles.

ChangeSet@1.785, 2002-10-14 12:00:06-04:00, jdike@uml.karaya.com
  Made a small fix to arch/um/kernel/Makefile.

ChangeSet@1.784, 2002-10-14 11:33:59-04:00, jdike@uml.karaya.com
  Added some code to arch/um/kernel/tempfile.c.

ChangeSet@1.783, 2002-10-13 23:41:50-04:00, jdike@uml.karaya.com
  Cleaned up a bunch of things noticed while merging the SMP support.
  The tempfile code is in its own file.
  A bunch of unused stuff is now gone.
  A bunch of code that could be called from the tracing thread was
  made safe for that to happen.

