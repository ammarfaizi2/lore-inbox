Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVBZKun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVBZKun (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 05:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVBZKuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 05:50:37 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:26052 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261159AbVBZKuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 05:50:12 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: [patch 2.6.11-rc5] Add target debug_kallsyms
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 26 Feb 2005 21:50:02 +1100
Message-ID: <19472.1109415002@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make it easier to generate maps for debugging kallsyms problems.
debug_kallsyms is only a debugging target so no help or silent mode.

Signed-off-by: Keith Owens <kaos@ocs.com.au>


Index: linux/Makefile
===================================================================
--- linux.orig/Makefile	2005-02-25 16:21:44.000000000 +1100
+++ linux/Makefile	2005-02-26 21:30:54.000000000 +1100
@@ -722,6 +722,16 @@ quiet_cmd_kallsyms = KSYM    $@
 # Needs to visit scripts/ before $(KALLSYMS) can be used.
 $(KALLSYMS): scripts ;
 
+# Generate some data for debugging strange kallsyms problems
+debug_kallsyms: .tmp_map$(last_kallsyms)
+
+.tmp_map%: .tmp_vmlinux% FORCE
+	($(OBJDUMP) -h $< | awk '/^ +[0-9]/{print $$4 " 0 " $$2}'; $(NM) $<) | sort > $@
+
+.tmp_map3: .tmp_map2
+
+.tmp_map2: .tmp_map1
+
 endif # ifdef CONFIG_KALLSYMS
 
 # vmlinux image - including updated kernel symbols

