Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264836AbUFVQjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264836AbUFVQjd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUFVP2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:28:03 -0400
Received: from holomorphy.com ([207.189.100.168]:43139 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264836AbUFVPR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:56 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [19/23] remove public decls of profile.c internal state
Message-ID: <0406220817.WaZaYaLb4aMb4a1aZa0a5a1a0aYaZa5aLbIb0a2a3aJb3aMbYaLb4aHb0aIbHbYa15250@holomorphy.com>
In-Reply-To: <0406220817.XaMb3a0aXaZa4a1a1aXaMbZaZaMbWaLbJbMbXaYaXaKbXaKb4a3a3a4a1aIbKb1a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Privatize prof_buffer, prof_len, and prof_shift.

Index: prof-2.6.7/include/linux/profile.h
===================================================================
--- prof-2.6.7.orig/include/linux/profile.h	2004-06-22 07:25:44.336423008 -0700
+++ prof-2.6.7/include/linux/profile.h	2004-06-22 07:25:59.265153496 -0700
@@ -17,12 +17,6 @@
 void profile_tick(unsigned long);
 int profiling_on(void);
 
-extern unsigned int * prof_buffer;
-extern unsigned long prof_len;
-extern unsigned long prof_shift;
-extern int prof_on;
-
-
 enum profile_type {
 	EXIT_TASK,
 	EXIT_MMAP,
Index: prof-2.6.7/kernel/profile.c
===================================================================
--- prof-2.6.7.orig/kernel/profile.c	2004-06-22 07:25:44.339422552 -0700
+++ prof-2.6.7/kernel/profile.c	2004-06-22 07:25:59.267153192 -0700
@@ -10,10 +10,9 @@
 #include <linux/mm.h>
 #include <asm/sections.h>
 
-unsigned int * prof_buffer;
-unsigned long prof_len;
-unsigned long prof_shift;
-int prof_on;
+static unsigned int *prof_buffer;
+static unsigned long prof_len, prof_shift;
+static int prof_on;
 
 int __init profile_setup(char * str)
 {
