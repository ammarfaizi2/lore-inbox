Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVLGNjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVLGNjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 08:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVLGNjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 08:39:14 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:15303 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751011AbVLGNjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 08:39:13 -0500
Date: Wed, 7 Dec 2005 15:39:02 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Blaisorblade <blaisorblade@yahoo.it>
cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jdike@karaya.com
Subject: Re: [uml-devel] [PATCH] um: fix compile error for tt
In-Reply-To: <200512071038.04958.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.58.0512071538230.22525@sbz-30.cs.Helsinki.FI>
References: <1133900650.3279.9.camel@localhost> <200512071038.04958.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Dec 2005, Blaisorblade wrote:
> Ok, fine, just a note - the header inclusion should be added to 
> 
> arch/um/include/um_uaccess.h
> 
> where it is effectively used (the offending macros, using FIXADDR_USER_*, are 
> __access_ok_vsyscall.
> 
> For the rest it's ok.

Here's an updated patch.

[PATCH] um: fix compile error for tt

Without the included patch, I get the following compile error for um:

arch/um/kernel/tt/uaccess.c: In function `copy_from_user_tt':
arch/um/kernel/tt/uaccess.c:11: error: `FIXADDR_USER_START' undeclared (first use in this function)
arch/um/kernel/tt/uaccess.c:11: error: (Each undeclared identifier is reported only once
arch/um/kernel/tt/uaccess.c:11: error: for each function it appears in.)

I get the compile error when I disable CONFIG_MODE_SKAS.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/um_uaccess.h               |    2 ++
 kernel/skas/include/uaccess-skas.h |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: 2.6/arch/um/include/um_uaccess.h
===================================================================
--- 2.6.orig/arch/um/include/um_uaccess.h
+++ 2.6/arch/um/include/um_uaccess.h
@@ -17,6 +17,8 @@
 #include "uaccess-skas.h"
 #endif
 
+#include "asm/fixmap.h"
+
 #define __under_task_size(addr, size) \
 	(((unsigned long) (addr) < TASK_SIZE) && \
          (((unsigned long) (addr) + (size)) < TASK_SIZE))
Index: 2.6/arch/um/kernel/skas/include/uaccess-skas.h
===================================================================
--- 2.6.orig/arch/um/kernel/skas/include/uaccess-skas.h
+++ 2.6/arch/um/kernel/skas/include/uaccess-skas.h
@@ -7,7 +7,6 @@
 #define __SKAS_UACCESS_H
 
 #include "asm/errno.h"
-#include "asm/fixmap.h"
 
 /* No SKAS-specific checking. */
 #define access_ok_skas(type, addr, size) 0
