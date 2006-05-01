Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWEAK2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWEAK2P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWEAK2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:28:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:2696 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751104AbWEAK2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:28:14 -0400
To: torvalds@osdl.org
Subject: [PATCHSET] audit fixes
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1FaVdV-00050X-EH@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:28:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull audit fixes from
git://git.kernel.org/pub/scm/linux/kernel/git/viro/audit-current.git/ audit.b10

This stuff had been sitting in -mm for weeks now and fixes a bunch of bugs -
both performance (killing serious unnecessary overhead) and outright leaks
and deadlocks.

Shortlog:

Al Viro:
      deal with deadlocks in audit_free()
      move call of audit_free() into do_exit()
      drop gfp_mask in audit_log_exit()
      drop task argument of audit_syscall_{entry,exit}
      no need to wank with task_lock() and pinning task down in audit_syscall_exit()

Darrel Goeddel:
      support for context based audit filtering
      support for context based audit filtering, part 2

Steve Grubb:
      sockaddr patch
      audit inode patch
      change lspp ipc auditing
      Reworked patch for labels on user space messages
      More user space subject labels
      Rework of IPC auditing
      Audit Filter Performance

Diffstat:
 arch/i386/kernel/ptrace.c      |    7 
 arch/i386/kernel/vm86.c        |    2 
 arch/ia64/kernel/ptrace.c      |    4 
 arch/mips/kernel/ptrace.c      |    4 
 arch/powerpc/kernel/ptrace.c   |    5 
 arch/s390/kernel/ptrace.c      |    5 
 arch/sparc64/kernel/ptrace.c   |    5 
 arch/um/kernel/ptrace.c        |    6 
 arch/x86_64/kernel/ptrace.c    |    6 
 include/linux/audit.h          |   22 ++-
 include/linux/netlink.h        |    1 
 include/linux/security.h       |   16 --
 include/linux/selinux.h        |  177 +++++++++++++++++++++++++
 ipc/msg.c                      |   11 +
 ipc/sem.c                      |   11 +
 ipc/shm.c                      |   19 ++
 ipc/util.c                     |    7 
 kernel/audit.c                 |  160 ++++++++++++++++++----
 kernel/audit.h                 |   10 -
 kernel/auditfilter.c           |  289 ++++++++++++++++++++++++++++++++++++-----
 kernel/auditsc.c               |  269 +++++++++++++++++++-------------------
 kernel/exit.c                  |    3 
 kernel/fork.c                  |    2 
 net/netlink/af_netlink.c       |    2 
 net/socket.c                   |    2 
 security/dummy.c               |    6 
 security/selinux/Makefile      |    2 
 security/selinux/avc.c         |   13 -
 security/selinux/exports.c     |   74 ++++++++++
 security/selinux/hooks.c       |    8 -
 security/selinux/ss/mls.c      |   30 ++++
 security/selinux/ss/mls.h      |    4 
 security/selinux/ss/services.c |  235 +++++++++++++++++++++++++++++++++
 33 files changed, 1142 insertions(+), 275 deletions(-)
