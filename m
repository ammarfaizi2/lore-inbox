Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264701AbSJOQWb>; Tue, 15 Oct 2002 12:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264703AbSJOQWa>; Tue, 15 Oct 2002 12:22:30 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:34286 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264701AbSJOQW0>; Tue, 15 Oct 2002 12:22:26 -0400
Date: Tue, 15 Oct 2002 11:27:31 -0500 (CDT)
From: Kent Yoder <key@austin.ibm.com>
To: acme@conectiva.com.br
cc: p.norton@computer.org, <linux-kernel@vger.kernel.org>
Subject: LLC fix (was 2.5 token ring build fails)
Message-ID: <Pine.LNX.4.44.0210151104530.1086-100000@ennui.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  When building in TR support, LLC must also be included in the kernel, not
as a module. LLC only builds correctly as a module however, due to
llc_proc_exit (__exit code) being called from llc_init in llc_main.c.  The
following patch fixes this.

Please apply...

Thanks,
Kent 

diff -urN linux-2.5.export/net/llc/llc_proc.c 
linux-2.5.key/net/llc/llc_proc.c
--- linux-2.5.export/net/llc/llc_proc.c 2002-10-14 14:40:30.000000000 -0500
+++ linux-2.5.key/net/llc/llc_proc.c    2002-10-15 10:56:37.000000000 -0500
@@ -258,7 +258,7 @@
        goto out;
 }

-void __exit llc_proc_exit(void)
+void llc_proc_exit(void)
 {
        remove_proc_entry("socket", llc_proc_dir);
        remove_proc_entry("core", llc_proc_dir);
@@ -270,7 +270,7 @@
        return 0;
 }

-void __exit llc_proc_exit(void)
+void llc_proc_exit(void)
 {
 }
 #endif /* CONFIG_PROC_FS */


