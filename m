Return-Path: <linux-kernel-owner+w=401wt.eu-S964994AbXABW3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbXABW3z (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbXABW3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:29:54 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:21113 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964994AbXABW3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:29:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mime-version:content-type:from;
        b=J7/Hi86YJzC8q01EPGbowly8TvQu64Z8t9Cad9Mz8K+QOIxnraE5pJeHj5cA0b9z5SK9wSXk6lJ/d/VkpOfYQ83h5q1GcpCK/1tANFvWZReE682MpN9kimHgR4ZoWbRbjl7Ejg6FseIaZlKM+iGeJ5pEg9DOLRUaJ6uAWp+QLGw=
Date: Tue, 2 Jan 2007 14:33:08 -0800 (PST)
To: fengguang.wu@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mingo@elte.hu, johnstul@us.ibm.com
Subject: Re: [BUG 2.6.20-rc2-mm1] init segfaults whenCONFIG_PROFILE_LIKELY=y
Message-ID: <Pine.LNX.4.64.0701021421290.2074@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Hua Zhong <hzhong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am wondering if we should define __likely/__unlikely macros no matter whether
CONFIG_LIKELY_PROFILE is defined, like the following. This way people can always
use the raw macros in case the debugging version causes problems.

Signed-off-by: Hua Zhong <hzhong@gmail.com>

--- linux-2.6/include/linux/compiler.h.orig	2007-01-02 13:51:32.000000000 -0800
+++ linux-2.6/include/linux/compiler.h	2007-01-02 14:18:33.000000000 -0800
@@ -53,6 +53,9 @@
 # include <linux/compiler-intel.h>
 #endif
 
+#define __likely(x)	__builtin_expect(!!(x), 1)
+#define __unlikely(x)	__builtin_expect(!!(x), 0)
+
 #if defined(CONFIG_PROFILE_LIKELY) && !(defined(CONFIG_MODULE_UNLOAD) && defined(MODULE))
 struct likeliness {
 	const char *func;
@@ -93,8 +96,8 @@
  * specific implementations come from the above header files
  */
 
-#define likely(x)	__builtin_expect(!!(x), 1)
-#define unlikely(x)	__builtin_expect(!!(x), 0)
+#define likely(x)	__likely(x)
+#define unlikely(x)	__unlikely(x)
 #endif
 
 /* Optimization barrier */
