Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267868AbTBVKGT>; Sat, 22 Feb 2003 05:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267871AbTBVKGS>; Sat, 22 Feb 2003 05:06:18 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:1077 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S267868AbTBVKGS>; Sat, 22 Feb 2003 05:06:18 -0500
Date: Sat, 22 Feb 2003 10:17:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] elapsed times wrap
Message-ID: <Pine.LNX.4.44.0302221016080.1848-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace shows huge elapsed time across jiffies wrap: with USER_HZ
less then HZ, sys_times needs jiffies_64 to calculate its retval.

--- 2.5.62/kernel/sys.c	Sat Feb 15 08:30:12 2003
+++ linux/kernel/sys.c	Fri Feb 21 20:41:52 2003
@@ -870,7 +870,7 @@
 		if (copy_to_user(tbuf, &tmp, sizeof(struct tms)))
 			return -EFAULT;
 	}
-	return jiffies_to_clock_t(jiffies);
+	return (long) jiffies_64_to_clock_t(get_jiffies_64());
 }
 
 /*

