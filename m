Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVI0THk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVI0THk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 15:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbVI0THk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 15:07:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31733 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965038AbVI0THj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 15:07:39 -0400
Subject: [PATCH] RT: Add __HAVE_ARCH_DIV_LL_X_L_REM
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 27 Sep 2005 12:07:29 -0700
Message-Id: <1127848052.4004.36.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Create __HAVE_ARCH_DIV_LL_X_L_REM instead of using div_ll_x_l_rem directly.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/include/asm-arm/div64.h
===================================================================
--- linux-2.6.13.orig/include/asm-arm/div64.h
+++ linux-2.6.13/include/asm-arm/div64.h
@@ -53,6 +53,7 @@
  */
 #define div_long_long_rem(a,b,c) div_ll_X_l_rem(a,b,c)
 
+#define __HAVE_ARCH_DIV_LL_X_L_REM
 /* x = divs / div; *rem = divs % div; */
 static inline unsigned long div_ll_X_l_rem(unsigned long long divs,
 					   unsigned long div,
Index: linux-2.6.13/include/linux/sc_math.h
===================================================================
--- linux-2.6.13.orig/include/linux/sc_math.h
+++ linux-2.6.13/include/linux/sc_math.h
@@ -141,7 +141,7 @@ static inline long mpy_sc32(long a, long
 })
 #endif
 
-#if !defined(div_ll_X_l_rem) && !defined(CONFIG_X86)
+#if !defined(__HAVE_ARCH_DIV_LL_X_L_REM) && !defined(CONFIG_X86)
 /* x = divs / div; *rem = divs % div; */
 static inline unsigned long div_ll_X_l_rem(unsigned long long divs,
 					   unsigned long div,


