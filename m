Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTJXI0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 04:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTJXI0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 04:26:19 -0400
Received: from srv1.mail.cv.net ([167.206.112.40]:35131 "EHLO srv1.mail.cv.net")
	by vger.kernel.org with ESMTP id S262068AbTJXI0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 04:26:17 -0400
Date: Fri, 24 Oct 2003 04:26:12 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
Subject: Copying .config to /lib/modules/`uname -r`/kernel
X-X-Sender: proski@portland.hansa.lan
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.58.0310240406230.17536@portland.hansa.lan>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Many drivers are developed outside the kernel tree.  Many drivers start
their existence as separate projects.  It's essential that they are tested
by the users of particular hardware, even if those users don't want to
recompile their kernels.

There should be a standard place for .config in kernel packages.
/proc/config.gz may or may not be popular with distributors.  Besides, it
only gives information for the currently running kernel, but not for e.g.
newly upgraded kernel before the reboot.

Cannot we just install .config to the same directory as modules?  If the
kernel doesn't support modules, then there is no point to compile any new
modules against it.  But if it does, then we can be sure that the modules
correspond to that configuration file, because the modules and .config
would be installed by the same command.

That's why I prefer the "kernel" subdirectory.  It's fully replaced by
"make modules_install", so that the old .config will go away for sure.

Patch against 2.6.0-test8
=====================
--- Makefile
+++ Makefile
@@ -690,6 +690,7 @@
 	@rm -rf $(MODLIB)/kernel
 	@rm -f $(MODLIB)/build
 	@mkdir -p $(MODLIB)/kernel
+	@cp -f .config $(MODLIB)/kernel
 	@ln -s $(TOPDIR) $(MODLIB)/build
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst

=====================

-- 
Regards,
Pavel Roskin
