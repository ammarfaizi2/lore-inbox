Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbTC0Wmu>; Thu, 27 Mar 2003 17:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbTC0Wmu>; Thu, 27 Mar 2003 17:42:50 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:49736 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261474AbTC0Wmt>; Thu, 27 Mar 2003 17:42:49 -0500
Date: Thu, 27 Mar 2003 17:54:04 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_KALLSYMS on 64-bitters
Message-ID: <20030327175404.A4396@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

the kallsyms program aborts for me when trying to build s390x
kernel while running a 31-bit kernel. It takes the target
from the environment variable, which actually is relevant
to the build host, and not the target. So, what do you think
about the attached patchlet?

-- Pete

--- linux-2.4.20-2.1.24.z2/Makefile	2003-03-27 12:29:51.000000000 -0500
+++ linux-2.4.20-2.1.15.z.1/Makefile	2003-03-21 19:01:26.000000000 -0500
@@ -45,7 +46,7 @@
 MAKEFILES	= $(TOPDIR)/.config
 GENKSYMS	= /sbin/genksyms
 DEPMOD		= /sbin/depmod
-KALLSYMS	= /sbin/kallsyms
+KALLSYMS	= UNAME_MACHINE=$(ARCH) /sbin/kallsyms
 MODFLAGS	= -DMODULE
 CFLAGS_KERNEL	=
 CFLAGS_KGDB	=
