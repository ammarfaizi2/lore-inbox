Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVDLSJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVDLSJO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVDLKcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:32:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:60359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262111AbVDLKbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:01 -0400
Message-Id: <200504121030.j3CAUvS3005191@shell0.pdx.osdl.net>
Subject: [patch 020/198] Fix linux/atalk.h header
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, davem@davemloft.net
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "David S. Miller" <davem@davemloft.net>

This recently got changed to include a lot of kernel internal stuff in the
non-__KERNEL__ area of the header, which isn't so kosher and breaks libc
builds.

The fix is pretty simple.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/atalk.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN include/linux/atalk.h~fix-linux-atalkh-header include/linux/atalk.h
--- 25/include/linux/atalk.h~fix-linux-atalkh-header	2005-04-12 03:21:08.121902184 -0700
+++ 25-akpm/include/linux/atalk.h	2005-04-12 03:21:08.124901728 -0700
@@ -1,8 +1,6 @@
 #ifndef __LINUX_ATALK_H__
 #define __LINUX_ATALK_H__
 
-#include <net/sock.h>
-
 /*
  * AppleTalk networking structures
  *
@@ -39,6 +37,10 @@ struct atalk_netrange {
 	__u16	nr_lastnet;
 };
 
+#ifdef __KERNEL__
+
+#include <net/sock.h>
+
 struct atalk_route {
 	struct net_device  *dev;
 	struct atalk_addr  target;
@@ -81,8 +83,6 @@ static inline struct atalk_sock *at_sk(s
 	return (struct atalk_sock *)sk;
 }
 
-#ifdef __KERNEL__
-
 #include <asm/byteorder.h>
 
 struct ddpehdr {
_
