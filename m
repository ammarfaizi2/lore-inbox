Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbUDBShE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 13:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUDBShE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 13:37:04 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:21661 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264141AbUDBShC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 13:37:02 -0500
Subject: [PATCH] fix the subarch build again after ACPI breakage
From: James Bottomley <James.Bottomley@steeleye.com>
To: len.brown@intel.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 02 Apr 2004 13:36:50 -0500
Message-Id: <1080931012.1804.149.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:


ChangeSet@1.1608.1.44, 2004-03-17 00:44:22-05:00, len.brown@intel.com
  [ACPI] check "maxcpus=N" early -- same as NR_CPUS check.
  http://bugzilla.kernel.org/show_bug.cgi?id=2317

Broke by putting maxcpus (a variable which is only exported by
mpparse.c) into parse_cmdline_early().

The fix is to make it depend on the correct CONFIG_ option.

In the subarchitectures:

CONFIG_X86_SMP is the one that means "I want standard x86 smp code" and
that's what this should depend on.

James

===== arch/i386/kernel/setup.c 1.114 vs edited =====
--- 1.114/arch/i386/kernel/setup.c	Mon Mar 22 15:03:22 2004
+++ edited/arch/i386/kernel/setup.c	Fri Apr  2 12:21:43 2004
@@ -560,7 +560,7 @@
 			}
 		}
 
-#ifdef  CONFIG_SMP
+#ifdef  CONFIG_X86_SMP
 		/*
 		 * If the BIOS enumerates physical processors before logical,
 		 * maxcpus=N at enumeration-time can be used to disable HT.

