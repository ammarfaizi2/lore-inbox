Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTETQVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 12:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTETQVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 12:21:40 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:38148 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S263212AbTETQVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 12:21:39 -0400
Date: Tue, 20 May 2003 11:34:09 -0500 (CDT)
Message-Id: <200305201634.h4KGY9VJ049544@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Alex Riesen <alexander.riesen@synopsys.COM>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
In-Reply-To: <3ECA05FA.6090008@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't this just use active_mm?   Can somebody test?

by the way, I saw this with a 486 kernel compiled by
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)

on a Toshiba 2105 (aka 2100 +- sw) 486DX2/50, although I am not
at that computer presenlty to test.

milton

===== arch/i386/kernel/suspend.c 1.15 vs edited =====
--- 1.15/arch/i386/kernel/suspend.c	Sat May 10 09:24:02 2003
+++ edited/arch/i386/kernel/suspend.c	Tue May 20 11:26:18 2003
@@ -114,7 +114,7 @@
         cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 
 	load_TR_desc();				/* This does ltr */
-	load_LDT(&current->mm->context);	/* This does lldt */
+	load_LDT(&current->active_mm->context);	/* This does lldt */
 
 	/*
 	 * Now maybe reload the debug registers
