Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267150AbSLaDui>; Mon, 30 Dec 2002 22:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267152AbSLaDui>; Mon, 30 Dec 2002 22:50:38 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:5383 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267150AbSLaDuZ>;
	Mon, 30 Dec 2002 22:50:25 -0500
Message-Id: <200212310353.WAA04772@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML build changes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Dec 2002 22:53:01 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull either
	http://uml.bkbits.net/build-2.5
or	http://jdike.stearns.org:5000/build-2.5

This patch updates the UML build -
	if possible, UML is built as a normal, dynamic binary rather than
a statically linked one
	there is an option to force a static link when UML would otherwise have
been built shared
	the mode-specific build stuff has been separated out somewhat
	fixed a readonly string segfault caused by the linker script changes
	fixed a unresolved symbol problem

				Jeff

 arch/um/Kconfig                           |   43 ++++-
 arch/um/Makefile                          |   95 +++++++----
 arch/um/Makefile-skas                     |   20 ++
 arch/um/Makefile-tt                       |    7 
 arch/um/drivers/line.c                    |   12 +
 arch/um/drivers/port_kern.c               |   11 -
 arch/um/dyn.lds.S                         |  241 ++++++++++++++++++++++++++++++
 arch/um/dyn_link.ld.in                    |  214 ++++++++++++++++++++++++++
 arch/um/include/skas_ptrace.h             |   36 ++++
 arch/um/include/sysdep-i386/ptrace.h      |    7 
 arch/um/include/user_util.h               |    1 
 arch/um/kernel/Makefile                   |   11 -
 arch/um/kernel/ptrace.c                   |    2 
 arch/um/kernel/skas/include/mode_kern.h   |    2 
 arch/um/kernel/skas/include/skas_ptrace.h |   36 ----
 arch/um/kernel/skas/tlb.c                 |    8 
 arch/um/kernel/tlb.c                      |    6 
 arch/um/kernel/tt/Makefile                |   17 +-
 arch/um/kernel/tt/include/mode_kern.h     |    1 
 arch/um/kernel/tt/mem_user.c              |   50 ++++++
 arch/um/kernel/tt/tlb.c                   |    2 
 arch/um/kernel/tt/unmap.c                 |   34 ++++
 arch/um/kernel/unmap.c                    |   34 ----
 arch/um/kernel/user_util.c                |   25 ---
 arch/um/sys-i386/util/mk_thread_kern.c    |    3 
 arch/um/uml.lds.S                         |    8 
 26 files changed, 759 insertions(+), 167 deletions(-)

ChangeSet@1.988, 2002-12-29 21:28:59-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/build-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/build-2.5-linus

ChangeSet@1.951.9.7, 2002-12-29 15:27:19-05:00, jdike@uml.karaya.com
  Fixed the archmrproper rule to not delete linker script sources.

ChangeSet@1.951.9.6, 2002-12-29 15:21:40-05:00, jdike@uml.karaya.com
  Fixed handling of the linker script.

ChangeSet@1.951.9.5, 2002-12-29 15:05:58-05:00, jdike@uml.karaya.com
  Pulled in a number of other fixes which were needed to bring the
  build up to date.

ChangeSet@1.951.9.4, 2002-12-29 12:10:51-05:00, jdike@uml.karaya.com
  Moved the segment remapping code under arch/um/kernel/tt.

ChangeSet@1.951.9.3, 2002-12-28 22:35:25-05:00, jdike@uml.karaya.com
  Moved skas_ptrace.h.

ChangeSet@1.951.9.2, 2002-12-28 22:06:40-05:00, jdike@uml.karaya.com
  Merged the 2.4 build changes which split the mode-specific stuff
  into separate Makefiles and add the ability to build a dynamically
  loaded binary.

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

