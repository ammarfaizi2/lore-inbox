Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUDEGlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 02:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbUDEGlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 02:41:20 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:3718 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S263147AbUDEGlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 02:41:18 -0400
Subject: Re: 2.6.5-mm1 [PATCH]
From: Ray Lee <ray-lk@madrabbit.org>
To: akpm@osdl.org
Cc: mpm@selenic.com, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1081147276.1374.13.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 04 Apr 2004 23:41:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Probably the least important email you'll receive all day, but...

> no-quota-inode-shrinkage.patch 
>  shrink inode when quota is disabled

Could I suggest an alternate version, below? It limits the knowledge of
the CONFIG_QUOTA option to the quota header file, and still shrinks the
inode by two pointers. The only functional difference between this and
Matt Mackall's version is the below will still leave in a call to
memset, but with a zero length. On the plus side, it keeps fs/inode.c
free of preprocessor noise, which seems worth the trade-off.

 quota.h |    4 ++++
 1 files changed, 4 insertions(+)

diff -NurX ../dontdiff linus-2.6/include/linux/quota.h linus-2.6-inode-shrinkage/include/linux/quota.h
--- linus-2.6/include/linux/quota.h	2004-04-03 08:46:35.000000000 -0800
+++ linus-2.6-inode-shrinkage/include/linux/quota.h	2004-04-03 08:45:19.000000000 -0800
@@ -57,7 +57,11 @@
 #define kb2qb(x) ((x) >> (QUOTABLOCK_BITS-10))
 #define toqb(x) (((x) + QUOTABLOCK_SIZE - 1) >> QUOTABLOCK_BITS)
 
+#ifdef CONFIG_QUOTA
 #define MAXQUOTAS 2
+#else
+#define MAXQUOTAS 0
+#endif
 
 #define USRQUOTA  0		/* element used for user quotas */
 #define GRPQUOTA  1		/* element used for group quotas */


--
Ray Lee

