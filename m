Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUKQEzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUKQEzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbUKQEzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:55:06 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:29706 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262050AbUKQEzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:55:01 -0500
To: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Tue, 16 Nov 2004 20:54:54 -0800
Message-ID: <52fz39f529.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH] linux/mount.h: add atomic.h and spinlock.h #includes
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 17 Nov 2004 04:55:00.0069 (UTC) FILETIME=[979BF150:01C4CC61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure what the current policy is on include files being
self-sufficient, so feel free to drop this if we don't want to do this
sort of cleanup...

<linux/mount.h> uses atomic_t and spinlock_t, but doesn't include
either <asm/atomic.h> or <linux/spinlock.h>, which means that any
users of <linux/mount.h> have to include them.  This patch adds the
necessary #includes to avoid this.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/include/linux/mount.h
===================================================================
--- linux-bk.orig/include/linux/mount.h	2004-11-16 20:50:34.000000000 -0800
+++ linux-bk/include/linux/mount.h	2004-11-16 20:51:30.000000000 -0800
@@ -13,6 +13,8 @@
 #ifdef __KERNEL__
 
 #include <linux/list.h>
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
 
 #define MNT_NOSUID	1
 #define MNT_NODEV	2
