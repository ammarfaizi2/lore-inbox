Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267146AbSLaDtW>; Mon, 30 Dec 2002 22:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbSLaDtW>; Mon, 30 Dec 2002 22:49:22 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:3335 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267146AbSLaDtR>;
	Mon, 30 Dec 2002 22:49:17 -0500
Message-Id: <200212310351.WAA04762@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Dec 2002 22:51:55 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull either
	http://uml.bkbits.net/cleanup-2.5
or	http://jdike.stearns.org:5000/cleanup-2.5

This patch is code cleanup -
	C99 initializer conversion
	formatting changes
	dead code removal
	a few improved and fixed error messages 

				Jeff

 arch/um/drivers/chan_kern.c              |   36 ++++-----
 arch/um/drivers/chan_user.c              |    6 -
 arch/um/drivers/daemon_kern.c            |   42 +++++------
 arch/um/drivers/daemon_user.c            |   16 ++--
 arch/um/drivers/fd.c                     |   24 +++---
 arch/um/drivers/harddog_kern.c           |   16 ++--
 arch/um/drivers/hostaudio_kern.c         |   28 +++----
 arch/um/drivers/line.c                   |   12 +--
 arch/um/drivers/mcast_kern.c             |   38 +++++-----
 arch/um/drivers/mcast_user.c             |   16 ++--
 arch/um/drivers/mconsole_kern.c          |   10 +-
 arch/um/drivers/mmapper_kern.c           |   14 +--
 arch/um/drivers/net_kern.c               |   47 ++++++------
 arch/um/drivers/null.c                   |   20 ++---
 arch/um/drivers/pcap_kern.c              |   42 +++++------
 arch/um/drivers/pcap_user.c              |   20 ++---
 arch/um/drivers/port_kern.c              |  115 ++++++++++++++++---------------
 arch/um/drivers/port_user.c              |   65 +++++++++--------
 arch/um/drivers/pty.c                    |   67 ++++++------------
 arch/um/drivers/slip_kern.c              |   42 +++++------
 arch/um/drivers/slip_user.c              |   16 ++--
 arch/um/drivers/slirp_kern.c             |   38 +++++-----
 arch/um/drivers/slirp_user.c             |   16 ++--
 arch/um/drivers/ssl.c                    |   74 +++++++++----------
 arch/um/drivers/stdio_console.c          |   94 ++++++++++++-------------
 arch/um/drivers/tty.c                    |   24 +++---
 arch/um/drivers/ubd_kern.c               |    6 -
 arch/um/drivers/xterm.c                  |   34 ++++-----
 arch/um/drivers/xterm_kern.c             |   14 +--
 arch/um/include/signal_kern.h            |    6 -
 arch/um/include/umid.h                   |    5 +
 arch/um/kernel/frame.c                   |    3 
 arch/um/kernel/irq_user.c                |   28 +++----
 arch/um/kernel/ksyms.c                   |    5 +
 arch/um/kernel/mem.c                     |   40 +++++-----
 arch/um/kernel/sigio_user.c              |   35 ++++-----
 arch/um/kernel/signal_kern.c             |   12 ---
 arch/um/kernel/skas/include/uaccess.h    |    3 
 arch/um/kernel/skas/tlb.c                |    1 
 arch/um/kernel/time.c                    |    2 
 arch/um/kernel/trap_kern.c               |    3 
 arch/um/kernel/tt/gdb.c                  |   10 +-
 arch/um/kernel/tt/gdb_kern.c             |    6 -
 arch/um/kernel/tt/ptproxy/proxy.c        |   16 ++--
 arch/um/kernel/um_arch.c                 |   19 +++--
 arch/um/kernel/umid.c                    |    1 
 arch/um/os-Linux/drivers/ethertap_kern.c |   34 ++++-----
 arch/um/os-Linux/drivers/ethertap_user.c |   16 ++--
 arch/um/os-Linux/drivers/tuntap_kern.c   |   36 ++++-----
 arch/um/os-Linux/drivers/tuntap_user.c   |   16 ++--
 arch/um/os-Linux/file.c                  |    4 -
 arch/um/sys-i386/Makefile                |    3 
 include/asm-um/pgtable.h                 |    3 
 include/asm-um/processor-i386.h          |    4 -
 54 files changed, 652 insertions(+), 651 deletions(-)

ChangeSet@1.988, 2002-12-29 21:37:02-05:00, jdike@uml.karaya.com
  Merge

ChangeSet@1.951.9.6, 2002-12-29 18:46:34-05:00, jdike@uml.karaya.com
  Merged in the C99 initializer changes.

ChangeSet@1.951.10.1, 2002-12-29 18:31:34-05:00, jdike@uml.karaya.com
  Forward ported a bunch of cleanups from 2.4.  Improved error messages,
  slightly different formatting, removal of dead code, and some stray
  C99 initializer conversions.

ChangeSet@1.951.9.5, 2002-12-28 21:27:46-05:00, jdike@uml.karaya.com
  Missed an initializer in the ethertap backend.

ChangeSet@1.951.9.4, 2002-12-28 21:20:41-05:00, jdike@uml.karaya.com
  Converted a bunch of inititializers in the drivers that I missed.

ChangeSet@1.951.9.3, 2002-12-28 19:48:40-05:00, jdike@uml.karaya.com
  Converted a few more initializers I missed on the first pass.

ChangeSet@1.951.9.2, 2002-12-28 15:28:07-05:00, jdike@uml.karaya.com
  Converted all initializers over to C99 syntax.

ChangeSet@1.951.9.1, 2002-12-28 11:50:51-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/doc-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

ChangeSet@1.951.8.4, 2002-12-28 11:42:00-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

ChangeSet@1.951.8.3, 2002-12-28 11:32:32-05:00, jdike@uml.karaya.com
  Fixed a merge conflict in port_kern.c

ChangeSet@1.951.8.1, 2002-12-28 11:12:47-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/mconfig-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5


