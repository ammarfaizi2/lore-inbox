Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbULIXXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbULIXXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbULIXXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:23:14 -0500
Received: from blaster.systems.pipex.net ([62.241.163.7]:44244 "EHLO
	blaster.systems.pipex.net") by vger.kernel.org with ESMTP
	id S261667AbULIXXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:23:00 -0500
Date: Thu, 9 Dec 2004 23:24:05 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@ezer.homenet
To: linux-ia64@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch-2.6.x] fix for make clean and make mrproper
Message-ID: <Pine.LNX.4.61.0412092320460.6269@ezer.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On IA64 architecture the "make clean" does not correspond to its 
definition:

# make clean     Delete most generated files
#                Leave enough to build external modules

because it deletes include/asm-ia64/offsets.h file which can easily be 
included by a module, e.g. via this header path:

In file included from include/linux/thread_info.h:21,
                  from include/linux/spinlock.h:12,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from include/asm/uaccess.h:37,

So the fix is to remove this file from CLEAN_FILES and add it to 
MRPROPER_FILES, so that it is NOT removed by "make clean" and removed by 
"make mrproper". The patch is enclosed.

Kind regards
Tigran

--- arch/ia64/Makefile.0	2004-12-08 23:19:44.429993868 +0000
+++ arch/ia64/Makefile	2004-12-08 23:18:57.238588196 +0000
@@ -87,7 +87,9 @@
  archclean:
  	$(Q)$(MAKE) $(clean)=$(boot)

-CLEAN_FILES += include/asm-ia64/.offsets.h.stamp include/asm-ia64/offsets.h vmlinux.gz bootloader
+CLEAN_FILES += include/asm-ia64/.offsets.h.stamp vmlinux.gz bootloader
+
+MRPROPER_FILES += include/asm-ia64/offsets.h

  prepare: include/asm-ia64/offsets.h

