Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUHHSSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUHHSSi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 14:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUHHSSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 14:18:38 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:29162 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266069AbUHHSSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 14:18:36 -0400
Date: Sun, 8 Aug 2004 14:22:21 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH][2.6] fix i386 idle routine selection
Message-ID: <Pine.LNX.4.58.0408081403460.19619@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was broken when the mwait stuff went in since it executes after the
initial idle_setup() has already selected an idle routine and overrides it
with default_idle.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8-rc3-mm1-amd64/arch/i386/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/arch/i386/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.8-rc3-mm1-amd64/arch/i386/kernel/process.c	5 Aug 2004 16:37:39 -0000	1.1.1.1
+++ linux-2.6.8-rc3-mm1-amd64/arch/i386/kernel/process.c	8 Aug 2004 18:14:32 -0000
@@ -226,10 +226,7 @@ void __init select_idle_routine(const st
 			printk("using mwait in idle threads.\n");
 			pm_idle = mwait_idle;
 		}
-		return;
 	}
-	pm_idle = default_idle;
-	return;
 }

 static int __init idle_setup (char *str)
Index: linux-2.6.8-rc3-mm1-amd64/arch/x86_64/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/arch/x86_64/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.8-rc3-mm1-amd64/arch/x86_64/kernel/process.c	5 Aug 2004 16:37:48 -0000	1.1.1.1
+++ linux-2.6.8-rc3-mm1-amd64/arch/x86_64/kernel/process.c	8 Aug 2004 18:12:22 -0000
@@ -180,10 +180,7 @@ void __init select_idle_routine(const st
 			}
 			pm_idle = mwait_idle;
 		}
-		return;
 	}
-	pm_idle = default_idle;
-	return;
 }

 static int __init idle_setup (char *str)
