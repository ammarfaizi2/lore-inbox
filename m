Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267133AbSLaDjd>; Mon, 30 Dec 2002 22:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbSLaDjd>; Mon, 30 Dec 2002 22:39:33 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:65030 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267133AbSLaDjb>;
	Mon, 30 Dec 2002 22:39:31 -0500
Message-Id: <200212310341.WAA04722@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make UML kernel stack size configurable
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Dec 2002 22:41:41 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull either
	http://uml.bkbits.net/stack-2.5
or	http://jdike.stearns.org:5000/stack-2.5

This patch makes the kernel stack size order configurable and fixes all code
that knows about the stack size to use the configured value.

				Jeff
 arch/um/Kconfig                          |    8 ++
 arch/um/drivers/chan_kern.c              |   36 +++++------
 arch/um/drivers/chan_user.c              |    6 -
 arch/um/drivers/daemon_kern.c            |   42 ++++++-------
 arch/um/drivers/daemon_user.c            |   16 ++---
 arch/um/drivers/fd.c                     |   24 +++----
 arch/um/drivers/harddog_kern.c           |   16 ++---
 arch/um/drivers/hostaudio_kern.c         |   28 ++++-----
 arch/um/drivers/line.c                   |   10 +--
 arch/um/drivers/mcast_kern.c             |   38 ++++++------
 arch/um/drivers/mcast_user.c             |   16 ++---
 arch/um/drivers/mconsole_kern.c          |   10 +--
 arch/um/drivers/mmapper_kern.c           |   14 ++--
 arch/um/drivers/net_kern.c               |   47 +++++++--------
 arch/um/drivers/null.c                   |   20 +++---
 arch/um/drivers/pcap_kern.c              |   42 ++++++-------
 arch/um/drivers/pcap_user.c              |   20 +++---
 arch/um/drivers/port_kern.c              |   44 +++++++-------
 arch/um/drivers/pty.c                    |   46 +++++++--------
 arch/um/drivers/slip_kern.c              |   42 ++++++-------
 arch/um/drivers/slip_user.c              |   16 ++---
 arch/um/drivers/slirp_kern.c             |   38 ++++++------
 arch/um/drivers/slirp_user.c             |   16 ++---
 arch/um/drivers/ssl.c                    |   74 ++++++++++++------------
 arch/um/drivers/stdio_console.c          |   94 +++++++++++++++----------------
 arch/um/drivers/tty.c                    |   24 +++----
 arch/um/drivers/ubd_kern.c               |    6 -
 arch/um/drivers/xterm.c                  |   34 +++++------
 arch/um/drivers/xterm_kern.c             |   14 ++--
 arch/um/kernel/init_task.c               |   16 ++---
 arch/um/kernel/irq_user.c                |   28 ++++-----
 arch/um/kernel/mem.c                     |   40 ++++++-------
 arch/um/kernel/process.c                 |    7 +-
 arch/um/kernel/process_kern.c            |    6 +
 arch/um/kernel/sigio_user.c              |   32 +++++-----
 arch/um/kernel/tt/gdb.c                  |   10 +--
 arch/um/kernel/tt/process_kern.c         |    9 ++
 arch/um/kernel/tt/ptproxy/proxy.c        |   16 ++---
 arch/um/kernel/um_arch.c                 |   14 ++--
 arch/um/kernel/user_util.c               |    8 +-
 arch/um/os-Linux/drivers/ethertap_kern.c |   34 +++++------
 arch/um/os-Linux/drivers/ethertap_user.c |   16 ++---
 arch/um/os-Linux/drivers/tuntap_kern.c   |   36 +++++------
 arch/um/os-Linux/drivers/tuntap_user.c   |   16 ++---
 arch/um/os-Linux/file.c                  |    4 -
 include/asm-um/current.h                 |    3 
 include/asm-um/processor-generic.h       |   26 ++++----
 include/asm-um/processor-i386.h          |    4 -
 48 files changed, 595 insertions(+), 571 deletions(-)


ChangeSet@1.988, 2002-12-29 21:43:18-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/stack-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/stack-2.5-linus

ChangeSet@1.951.10.3, 2002-12-29 12:12:46-05:00, jdike@uml.karaya.com
  task_protections needed adjusting for configurable stack sizes.

ChangeSet@1.951.9.5, 2002-12-28 21:27:46-05:00, jdike@uml.karaya.com
  Missed an initializer in the ethertap backend.

ChangeSet@1.951.9.4, 2002-12-28 21:20:41-05:00, jdike@uml.karaya.com
  Converted a bunch of inititializers in the drivers that I missed.

ChangeSet@1.951.10.2, 2002-12-28 21:06:05-05:00, jdike@uml.karaya.com
  Fixed a couple of problems with the configurable stack size changes.

ChangeSet@1.951.10.1, 2002-12-28 20:05:20-05:00, jdike@uml.karaya.com
  Merged the configurable kernel stack size changes from 2.4.  This
  paramerizes the kernel stack size and adds a config option to set
  the order.

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

