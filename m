Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270421AbUJUG0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270421AbUJUG0W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270410AbUJTT1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:27:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9392 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S270333AbUJTTXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:23:07 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] small load balance fix
Date: Wed, 20 Oct 2004 12:23:02 -0700
User-Agent: KMail/1.7
Cc: hawkes@sgi.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WsrdB4HDeUDnqyo"
Message-Id: <200410201223.02924.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_WsrdB4HDeUDnqyo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Small bug fix for domains that don't load balance (like those that only 
balance on exec for example).

Signed-off-by: John Hawkes <hawkes@sgi.com>
Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
Acked-by: Nick Piggin <nickpiggin@yahoo.com.au>

Thanks,
Jesse

--Boundary-00=_WsrdB4HDeUDnqyo
Content-Type: text/plain;
  charset="us-ascii";
  name="sched-load-balance-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sched-load-balance-fix.patch"

===== kernel/sched.c 1.367 vs edited =====
--- 1.367/kernel/sched.c	2004-10-18 22:26:52 -07:00
+++ edited/kernel/sched.c	2004-10-19 14:18:06 -07:00
@@ -4378,11 +4378,10 @@
 			printk("domain %d: ", level);
 
 			if (!(sd->flags & SD_LOAD_BALANCE)) {
-				printk("does not balance");
+				printk("does not load-balance");
 				if (sd->parent)
 					printk(" ERROR !SD_LOAD_BALANCE domain has parent");
 				printk("\n");
-				break;
 			}
 
 			printk("span %s\n", str);

--Boundary-00=_WsrdB4HDeUDnqyo--
