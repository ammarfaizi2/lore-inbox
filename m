Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWCIXjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWCIXjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWCIXjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:39:18 -0500
Received: from smtp-out.google.com ([216.239.45.12]:27895 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932116AbWCIXjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:39:17 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type;
	b=EE9PJGUWQB0Ba2/eLJI6ufcI1ARj71m/SAr3wj3A87HToUaopob2FnRlD76ocGPIX
	QVOur2ha8NASpgw/cpo7Q==
Message-ID: <4410BC90.1070108@google.com>
Date: Thu, 09 Mar 2006 15:38:56 -0800
From: Markus Gutschke <markus@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Daniel Kegel <dkegel@google.com>, Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH 1/1]: arm: _syscallX() macros must mark "memory" as clobbered
Content-Type: multipart/mixed;
 boundary="------------050503030202010600070004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050503030202010600070004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

From: Markus Gutschke <markus@google.com>

While other platforms (including x86) have been fixed to mark memory as 
clobbered by _syscallX()'s, this bug has not yet been fixed for ARM. 
This patch adds the missing constraints and applies to version 2.6.15.6.

The bug can be tracked at http://bugzilla.kernel.org/show_bug.cgi?id=6205

Signed-off-by: Markus Gutschke <markus@google.com>

---

--------------050503030202010600070004
Content-Type: text/x-patch;
 name="arm-unistd.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm-unistd.h.diff"

--- include/asm-arm/unistd.h.orig	2006-03-05 11:07:54.000000000 -0800
+++ include/asm-arm/unistd.h	2006-03-09 15:10:22.000000000 -0800
@@ -415,7 +415,7 @@
   __syscall(name)							\
 	: "=r" (__res_r0)						\
 	: "r" (__r0)							\
-	: "lr");							\
+	: "lr", "memory");						\
   __res = __res_r0;							\
   __syscall_return(type,__res);						\
 }
@@ -430,7 +430,7 @@
   __syscall(name)							\
 	: "=r" (__res_r0)						\
 	: "r" (__r0),"r" (__r1) 					\
-	: "lr");							\
+	: "lr", "memory");						\
   __res = __res_r0;							\
   __syscall_return(type,__res);						\
 }
@@ -447,7 +447,7 @@
   __syscall(name)							\
 	: "=r" (__res_r0)						\
 	: "r" (__r0),"r" (__r1),"r" (__r2)				\
-	: "lr");							\
+	: "lr", "memory");						\
   __res = __res_r0;							\
   __syscall_return(type,__res);						\
 }
@@ -465,7 +465,7 @@
   __syscall(name)							\
 	: "=r" (__res_r0)						\
 	: "r" (__r0),"r" (__r1),"r" (__r2),"r" (__r3)			\
-	: "lr");							\
+	: "lr", "memory");						\
   __res = __res_r0;							\
   __syscall_return(type,__res);						\
 }
@@ -484,7 +484,7 @@
   __syscall(name)							\
 	: "=r" (__res_r0)						\
 	: "r" (__r0),"r" (__r1),"r" (__r2),"r" (__r3),"r" (__r4)	\
-	: "lr");							\
+	: "lr", "memory");						\
   __res = __res_r0;							\
   __syscall_return(type,__res);						\
 }
@@ -503,7 +503,7 @@
   __syscall(name)							\
 	: "=r" (__res_r0)						\
 	: "r" (__r0),"r" (__r1),"r" (__r2),"r" (__r3), "r" (__r4),"r" (__r5)		\
-	: "lr");							\
+	: "lr", "memory");						\
   __res = __res_r0;							\
   __syscall_return(type,__res);						\
 }

--------------050503030202010600070004--
