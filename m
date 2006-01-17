Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWAQPYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWAQPYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWAQPYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:24:43 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:62439 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751281AbWAQPYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:24:42 -0500
Date: Tue, 17 Jan 2006 08:24:42 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] Fix building in a separate directory
Message-ID: <20060117152442.GH19769@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Without this,
make O=../b180 oldconfig ends:

CRC32c (Castagnoli, et al) Cyclic Redundancy-Check (LIBCRC32C)
[N/m/y/?] n
make -C /home/willy/linux-2.6 O=/home/willy/b180 .kernelrelease
Makefile:477: .config: No such file or directory

With it, make[2]: `/home/willy/linux-2.6/.kernelrelease' is up to date.
 is the end.

Index: Makefile
===================================================================
RCS file: /var/cvs/linux-2.6/Makefile,v
retrieving revision 1.437
diff -u -p -r1.437 Makefile
--- a/Makefile	17 Jan 2006 14:49:47 -0000	1.437
+++ b/Makefile	17 Jan 2006 15:20:55 -0000
@@ -474,7 +474,7 @@ ifeq ($(dot-config),1)
 # oldconfig if changes are detected.
 -include .kconfig.d
 
-include .config
+include $(KBUILD_OUTPUT)/.config
 
 # If .config needs to be updated, it will be done via the dependency
 # that autoconf has on .config.
