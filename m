Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270631AbTGNO5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270655AbTGNO5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:57:45 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:48051 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S270631AbTGNOzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:55:21 -0400
Date: Mon, 14 Jul 2003 11:10:59 -0400
From: Ben Collins <bcollins@debian.org>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org
Subject: Re: [PATCH] jffs2 super.o for 2.6.0-test1
Message-ID: <20030714151059.GL450@phunnypharm.org>
References: <1058194498.3333.100.camel@vimes.crl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058194498.3333.100.camel@vimes.crl.hpl.hp.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 10:54:58AM -0400, Jamey Hicks wrote:
> 
> Trivial patch to reenable jffs2 for 2.6.0-test1.

Seems this might be better, to keep it from being a re-occuring
problem.


Index: linux-2.6/fs/jffs2/Makefile
===================================================================
--- linux-2.6/fs/jffs2/Makefile	(revision 11779)
+++ linux-2.6/fs/jffs2/Makefile	(working copy)
@@ -11,10 +11,13 @@
 	read.o nodemgmt.o readinode.o write.o scan.o gc.o \
 	symlink.o build.o erase.o background.o fs.o writev.o
 
-LINUX_OBJS-24	:= super-v24.o crc32.o
-LINUX_OBJS-25	:= super.o
+ifeq ($(VERSION)$(PATCHLEVEL),2.4)
+LINUX_OBJS	:= super-v24.o crc32.o
+else
+LINUX_OBJS	:= super.o
+endif
 
 NAND_OBJS-$(CONFIG_JFFS2_FS_NAND)	:= wbuf.o
 
 jffs2-objs := $(COMPR_OBJS) $(JFFS2_OBJS) $(VERS_OBJS) $(NAND_OBJS-y) \
-	      $(LINUX_OBJS-$(VERSION)$(PATCHLEVEL))
+	      $(LINUX_OBJS)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
