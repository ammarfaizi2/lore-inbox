Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUIXNIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUIXNIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 09:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268734AbUIXNIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 09:08:53 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:12556 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S268730AbUIXNIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 09:08:42 -0400
Date: Fri, 24 Sep 2004 16:07:38 +0300 (EAT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] remove spurious might_sleep in i386 usercopy
Message-ID: <Pine.LNX.4.53.0409240430260.19886@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seem to be multiple might_sleep() statements littered about in 
arch/i386/lib/usercopy.c as the primitives (__do_clear_user, 
__copy_to_user, __copy_from_user) already do the might_sleep() check.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc2-mm1/arch/i386/lib/usercopy.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc2-mm1/arch/i386/lib/usercopy.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 usercopy.c
--- linux-2.6.9-rc2-mm1/arch/i386/lib/usercopy.c	16 Sep 2004 13:41:16 -0000	1.1.1.1
+++ linux-2.6.9-rc2-mm1/arch/i386/lib/usercopy.c	24 Sep 2004 01:26:13 -0000
@@ -152,7 +152,6 @@ do {									\
 unsigned long
 clear_user(void __user *to, unsigned long n)
 {
-	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))
 		__do_clear_user(to, n);
 	return n;
@@ -596,7 +595,6 @@ __copy_from_user_ll(void *to, const void
 unsigned long
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))
 		n = __copy_to_user(to, from, n);
 	return n;
@@ -622,7 +620,6 @@ EXPORT_SYMBOL(copy_to_user);
 unsigned long
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	might_sleep();
 	if (access_ok(VERIFY_READ, from, n))
 		n = __copy_from_user(to, from, n);
 	else
