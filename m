Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVDEV3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVDEV3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVDEV1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:27:49 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:64942
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261996AbVDEU4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:56:20 -0400
Date: Tue, 5 Apr 2005 13:55:04 -0700
From: "David S. Miller" <davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] Fix linux/atalk.h header
Message-Id: <20050405135504.6fe8e76e.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This recently got changed to include a lot of kernel internal
stuff in the non-__KERNEL__ area of the header, which isn't
so kosher and breaks libc builds.

The fix is pretty simple.

Signed-off-by: David S. Miller <davem@davemloft.net>

===== include/linux/atalk.h 1.12 vs edited =====
--- 1.12/include/linux/atalk.h	2005-03-07 09:33:17 -08:00
+++ edited/include/linux/atalk.h	2005-04-02 13:20:13 -08:00
@@ -1,8 +1,6 @@
 #ifndef __LINUX_ATALK_H__
 #define __LINUX_ATALK_H__
 
-#include <net/sock.h>
-
 /*
  * AppleTalk networking structures
  *
@@ -39,6 +37,10 @@
 	__u16	nr_lastnet;
 };
 
+#ifdef __KERNEL__
+
+#include <net/sock.h>
+
 struct atalk_route {
 	struct net_device  *dev;
 	struct atalk_addr  target;
@@ -80,8 +82,6 @@
 {
 	return (struct atalk_sock *)sk;
 }
-
-#ifdef __KERNEL__
 
 #include <asm/byteorder.h>
 
