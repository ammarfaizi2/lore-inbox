Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVFFDxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVFFDxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 23:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVFFDxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 23:53:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9159 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261169AbVFFDxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 23:53:22 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org
Subject: [patch 2.6.12-rc5] Stop arch/i386/kernel/vsyscall-note.o being rebuilt every time
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Jun 2005 13:53:04 +1000
Message-ID: <615.1118029984@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/vsyscall-note.o is not listed as a target so its .cmd
file is neither considered as a target nor is it read on the next
build.  This causes vsyscall-note.o to be rebuilt every time that you
run make, which causes vmlinux to be rebuilt every time.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: linux/arch/i386/kernel/Makefile
===================================================================
--- linux.orig/arch/i386/kernel/Makefile	2005-06-05 19:36:29.093065944 +1000
+++ linux/arch/i386/kernel/Makefile	2005-06-06 13:44:31.727643119 +1000
@@ -43,7 +43,7 @@ obj-$(CONFIG_SCx200)		+= scx200.o
 # Note: kbuild does not track this dependency due to usage of .incbin
 $(obj)/vsyscall.o: $(obj)/vsyscall-int80.so $(obj)/vsyscall-sysenter.so
 targets += $(foreach F,int80 sysenter,vsyscall-$F.o vsyscall-$F.so)
-targets += vsyscall.lds
+targets += vsyscall-note.o vsyscall.lds
 
 # The DSO images are built using a special linker script.
 quiet_cmd_syscall = SYSCALL $@

