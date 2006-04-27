Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWD0CNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWD0CNr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 22:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWD0CNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 22:13:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35552 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964873AbWD0CNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 22:13:46 -0400
Subject: Simple header cleanups
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 27 Apr 2006 03:13:42 +0100
Message-Id: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew (or preferably Linus since these are fairly simple and
unintrusive bug fixes), please pull from my tree at 
git://git.infradead.org/hdrcleanup-2.6.git

(Gitweb at http://git.infradead.org/?p=hdrcleanup-2.6.git;a=summary)

This tree contains a number of simple fixes for kernel headers which are
currently exposing things to userspace that should not be present
outside #ifdef __KERNEL__.

Since ifdefs are horrid, these patches tend not to add new ones --
mostly it's a case of moving things inside existing ifdefs, rather than
adding new ones.

Most of the patches are small and self-contained, except for the one
which removes #include <linux/config.h> from everything under include/

The individual commits are as follows:

      Remove user-visible references to PAGE_SIZE in include/asm-powerpc/elf.h
      Include <linux/jiffies.h> from linux/acct.h only in kernel-private part.
      Don't include agp_backend.h in user-visible part of agpgart.h
      Use __KERNEL__ to hide kernel-private bits of linux/gameport.h
      Export only the appropriate GS_xxx flags to userspace from generic_serial.h
      Include various private files only from within __KERNEL__ in genhd.h
      Sanitise linux/i2c-algo-ite.h for userspace consumption
      Sanitise linux/i2c.h for userspace consumption
      Don't include <linux/device.h> from user-visible part of linux/ipmi.h
      Remove gratuitous inclusion of <linux/pci.h> from linux/isdn/tpam.h
      Sanitise linux/mman.h for userspace consumption
      Don't include private files from user-visible part of linux/ncp_fs.h
      Don't include <linux/list.h> from user-visible part of linux/msg.h
      Don't include <linux/stringify> from user-visible part of linux/net.h
      Don't include private headers from user-visible parts of include/linux/nfs*.h
      Don't include private headers from user-visible parts of linux/quota.h
      Don't include <linux/list.h> from user-visible part of reiserfs_xattr.h
      Partially sanitise linux/sched.h for userspace consumption
      Don't include <asm/atomic.h> from user-visible part of linux/sem.h
      Don't include private headers from user-visible part of linux/signal.h
      Move comment in mtd-abi.h to stop confusing unifdef
      Don't include <linux/spinlock.h> from user-visible part of linux/wanrouter.h
      Don't export CONFIG_COMPAT stuff in linux/usbdevice_fs.h to userspace
      Sanitise linux/sunrpc/debug.h for userspace consumption
      Don't include private headers from user-visible part of linux/smb_fs.h
      Don't include private headers from user-visible part of linux/ext2_fs.h
      Don't include private headers from user-visible part of linux/ext3_fs.h
      Don't include <linux/config.h> and <linux/linkage.h> from linux/socket.h
      Don't include linux/config.h from anywhere else in include/
      Sanitise linux/audit.h for userspace consumption, split elf-em.h from elf.h
      Sanitise linux/sched.h for userspace consumption

Excluding the one-line files which have just <linux/config.h> removed,
the diffstat looks like this:

 asm-m32r/mmu_context.h                       |    2
 asm-powerpc/elf.h                            |    7 --
 asm-ppc/page.h                               |    2
 asm-sparc/system.h                           |    2
 linux/acct.h                                 |    3
 linux/agpgart.h                              |    3
 linux/audit.h                                |    4 -
 linux/elf-em.h                               |   44 +++++++++++++
 linux/elf.h                                  |   59 -----------------
 linux/ext2_fs.h                              |    2
 linux/ext3_fs.h                              |    7 --
 linux/gameport.h                             |    6 +
 linux/generic_serial.h                       |    6 +
 linux/genhd.h                                |   12 +--
 linux/i2c-algo-ite.h                         |    7 +-
 linux/i2c.h                                  |    9 +-
 linux/ipmi.h                                 |    2
 linux/mman.h                                 |   12 ++-
 linux/msg.h                                  |    2
 linux/ncp_fs.h                               |    5 -
 linux/net.h                                  |    3
 linux/nfs.h                                  |    8 +-
 linux/nfs4.h                                 |    6 -
 linux/nfs_fs.h                               |   39 +++++------
 linux/quota.h                                |    4 -
 linux/reiserfs_xattr.h                       |    3
 linux/sched.h                                |   90 +++++++++++++--------------
 linux/sem.h                                  |    2
 linux/signal.h                               |    4 -
 linux/smb_fs.h                               |    4 -
 linux/socket.h                               |    2
 linux/sunrpc/debug.h                         |   24 +++----
 linux/usbdevice_fs.h                         |    2
 linux/wanrouter.h                            |    4 -
 mtd/mtd-abi.h                                |    5 -
 864 files changed, 191 insertions(+), 1034 deletions(-)



-- 
dwmw2

