Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbVIAWxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbVIAWxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbVIAWxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:53:31 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:37648 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030466AbVIAWxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:53:22 -0400
Message-Id: <200509012217.j81MHKE7011567@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH 10/12] UML - Allow host capability usage to be disabled
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 18:17:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Add new cmdline setups:
  - noprocmm
  - noptracefaultinfo
In case of testing, they can be used to switch off usage of
/proc/mm and PTRACE_FAULTINFO independently.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/os-Linux/start_up.c
===================================================================
--- test.orig/arch/um/os-Linux/start_up.c	2005-09-01 16:42:42.000000000 -0400
+++ test/arch/um/os-Linux/start_up.c	2005-09-01 16:51:23.000000000 -0400
@@ -275,6 +275,30 @@
 	check_ptrace();
 }
 
+static int __init noprocmm_cmd_param(char *str, int* add)
+{
+	proc_mm = 0;
+	return 0;
+}
+
+__uml_setup("noprocmm", noprocmm_cmd_param,
+"noprocmm\n"
+"    Turns off usage of /proc/mm, even if host supports it.\n"
+"    To support /proc/mm, the host needs to be patched using\n"
+"    the current skas3 patch.\n\n");
+
+static int __init noptracefaultinfo_cmd_param(char *str, int* add)
+{
+	ptrace_faultinfo = 0;
+	return 0;
+}
+
+__uml_setup("noptracefaultinfo", noptracefaultinfo_cmd_param,
+"noptracefaultinfo\n"
+"    Turns off usage of PTRACE_FAULTINFO, even if host supports\n"
+"    it. To support PTRACE_FAULTINFO, the host needs to be patched\n"
+"    using the current skas3 patch.\n\n");
+
 #ifdef UML_CONFIG_MODE_SKAS
 static inline void check_skas3_ptrace_support(void)
 {

