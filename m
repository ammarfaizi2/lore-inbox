Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbUKQIUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbUKQIUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 03:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbUKQITo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 03:19:44 -0500
Received: from mail.renesas.com ([202.234.163.13]:15808 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262230AbUKQITM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 03:19:12 -0500
Date: Wed, 17 Nov 2004 17:19:01 +0900 (JST)
Message-Id: <20041117.171901.635727949.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc2-bk1] m32r: Make zImage a default build target
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch to update arch/m32r/Makefile for m32r.
- Make zImage a default build target
- Add zImage to targets marked with [*].

-----
$ make ARCH=m32r help
Cleaning targets:
  clean           - remove most generated files but keep the config
  mrproper        - remove all generated files + config + various backup files

Configuration targets:
  oldconfig       - Update current config utilising a line-oriented program
  menuconfig      - Update current config utilising a menu based program
  xconfig         - Update current config utilising a QT based front-end
  gconfig         - Update current config utilising a GTK based front-end
  defconfig       - New config with default answer to all options
  allmodconfig    - New config selecting modules when possible
  allyesconfig    - New config where all options are accepted with yes
  allnoconfig     - New minimal config

Other generic targets:
  all             - Build all targets marked with [*]
* vmlinux         - Build the bare kernel
* modules         - Build all modules
  modules_install - Install all modules
  dir/            - Build all files in dir and below
  dir/file.[ois]  - Build specified target only
  rpm             - Build a kernel as an RPM package
  tags/TAGS       - Generate tags file for editors
  cscope          - Generate cscope index

Static analysers
  buildcheck      - List dangling references to vmlinux discarded sections
                    and init sections from non-init sections
  checkstack      - Generate a list of stack hogs
  namespacecheck  - Name space analysis on compiled kernel

Kernel packaging:
  rpm-pkg         - Build the kernel as an RPM package
  binrpm-pkg      - Build an rpm package containing the compiled kernel & modules
  deb-pkg         - Build the kernel as an deb package

Documentation targets:
  Linux kernel internal documentation in different formats:
  sgmldocs (SGML), psdocs (Postscript), pdfdocs (PDF)
  htmldocs (HTML), mandocs (man pages, use installmandocs to install)

Architecture specific targets (m32r):
* zImage          - Compressed kernel image (arch/m32r/boot/zImage)

  make V=0|1 [targets] 0 => quiet build (default), 1 => verbose build
  make O=dir [targets] Locate all output files in "dir", including .config
  make C=1   [targets] Check all c source with $CHECK (sparse)
  make C=2   [targets] Force check of all c source with $CHECK (sparse)

Execute "make" or "make all" to build all targets marked with [*] 
For further info see the ./README file
-----

Regards,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -ruNp a/arch/m32r/Makefile b/arch/m32r/Makefile
--- a/arch/m32r/Makefile	2004-11-15 12:16:46.000000000 +0900
+++ b/arch/m32r/Makefile	2004-11-17 15:02:53.000000000 +0900
@@ -41,6 +41,8 @@ boot := arch/m32r/boot
 
 .PHONY: zImage
 
+all: zImage
+
 zImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
@@ -50,5 +52,5 @@ archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
 define archhelp
-	@echo '  zImage			- Compressed kernel image (arch/m32r/boot/zImage)'
+	echo  '* zImage          - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
 endef
diff -ruNp a/drivers/media/video/arv.c b/drivers/media/video/arv.c

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
