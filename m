Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUEKXsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUEKXsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265072AbUEKXrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:47:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:26792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265062AbUEKXqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:46:42 -0400
Date: Tue, 11 May 2004 16:46:40 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] remove empty build of capability.o
Message-ID: <20040511164640.O21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The build includes capability.c when CONFIG_SECURITY=n, yet the whole file
is ifdef'd out.  Remove unnecessary build step as well as superfluous ifdefs.

--- linus-2.5/security/capability.c~ifdef	2004-05-11 14:55:19.000000000 -0700
+++ linus-2.5/security/capability.c	2004-05-11 15:00:28.000000000 -0700
@@ -23,9 +23,6 @@
 #include <linux/netlink.h>
 #include <linux/ptrace.h>
 
-#ifdef CONFIG_SECURITY
-
-
 static struct security_operations capability_ops = {
 	.ptrace =			cap_ptrace,
 	.capget =			cap_capget,
@@ -99,5 +96,3 @@
 
 MODULE_DESCRIPTION("Standard Linux Capabilities Security Module");
 MODULE_LICENSE("GPL");
-
-#endif	/* CONFIG_SECURITY */
--- linus-2.5/security/Makefile~ifdef	2004-05-11 14:58:06.000000000 -0700
+++ linus-2.5/security/Makefile	2004-05-11 14:58:16.000000000 -0700
@@ -6,7 +6,7 @@
 
 # if we don't select a security model, use the default capabilities
 ifneq ($(CONFIG_SECURITY),y)
-obj-y		+= commoncap.o capability.o
+obj-y		+= commoncap.o
 endif
 
 # Object file lists
