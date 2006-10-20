Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992425AbWJTCmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992425AbWJTCmz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992424AbWJTCmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:42:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23622 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2992425AbWJTCmx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:42:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=ID92R5wHOh4R6VkHd+FLr2jzKc8oaTIZ9y78P3eNDrhmcNidXz6YuMjQCWDOdXJJAQDYWugJaWjB/15BYL1pb8kc8RcPO1iT5xzacOlorqcnNwS+bxGYk0KyMg9qzqoisFQUyahZe/1/6bAGb5Pf5UclD0FH/vwynsCX4WW+O/I=
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: [PATCH] Converted jiffy comparisons to time_after calls (TAKE 3)
Date: Thu, 19 Oct 2006 19:42:26 -0700
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610191942.26865.karhudever@gmial.com>
From: David KOENIG <karhudever@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 9180d29946eced4c71845c9bbe847e98e01d1c31 Mon Sep 17 00:00:00 2001
From: David KOENIG <david@karhu.(none)>
Date: Thu, 19 Oct 2006 18:57:17 -0700
Subject: [PATCH] Converted jiffy comparisons to time_after calls
---
 drivers/net/tokenring/3c359.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tokenring/3c359.c b/drivers/net/tokenring/3c359.c
index 7580bde..8a2e0c1 100644
--- a/drivers/net/tokenring/3c359.c
+++ b/drivers/net/tokenring/3c359.c
@@ -48,6 +48,7 @@ #include <linux/errno.h>
 #include <linux/timer.h>
 #include <linux/in.h>
 #include <linux/ioport.h>
+#include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
 #include <linux/ptrace.h>
@@ -409,7 +410,7 @@ static int xl_hw_reset(struct net_device
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
 		schedule();		
-		if(jiffies-t > 40*HZ) {
+		if (time_after(jiffies, t + 40 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL  card not responding to global 
reset.\n", dev->name);
 			return -ENODEV;
 		}
@@ -520,7 +521,7 @@ #endif
 	t=jiffies;
 	while ( !(readw(xl_mmio + MMIO_INTSTATUS_AUTO) & INTSTAT_SRB) ) { 
 		schedule();		
-		if(jiffies-t > 15*HZ) {
+		if (time_after(jiffies, t + 15 * HZ)) {
 			printk(KERN_ERR "3COM 3C359 Velocity XL  card not responding.\n");
 			return -ENODEV; 
 		}
@@ -796,7 +797,7 @@ static int xl_open_hw(struct net_device 
 	t=jiffies;
 	while (! (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_SRB)) { 
 		schedule();		
-		if(jiffies-t > 40*HZ) {
+		if (time_after(jiffies, t + 40 * HZ)) {
 			printk(KERN_ERR "3COM 3C359 Velocity XL  card not responding.\n");
 			break ; 
 		}
@@ -1011,7 +1012,7 @@ static void xl_reset(struct net_device *
 
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
-		if(jiffies-t > 40*HZ) {
+		if (time_after(jiffies, t + 40 * HZ)) {
 			printk(KERN_ERR "3COM 3C359 Velocity XL  card not responding.\n");
 			break ; 
 		}
@@ -1283,7 +1284,7 @@ static int xl_close(struct net_device *d
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
 		schedule();		
-		if(jiffies-t > 10*HZ) {
+		if (time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-DNSTALL not responding.\n", 
dev->name);
 			break ; 
 		}
@@ -1292,7 +1293,7 @@ static int xl_close(struct net_device *d
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
 		schedule();		
-		if(jiffies-t > 10*HZ) {
+		if (time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-DNDISABLE not responding.\n", 
dev->name);
 			break ;
 		}
@@ -1301,7 +1302,7 @@ static int xl_close(struct net_device *d
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
 		schedule();		
-		if(jiffies-t > 10*HZ) {
+		if (time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-UPSTALL not responding.\n", 
dev->name);
 			break ; 
 		}
@@ -1318,7 +1319,7 @@ static int xl_close(struct net_device *d
 	t=jiffies;
 	while (!(readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_SRB)) { 
 		schedule();		
-		if (jiffies-t > 10*HZ) {
+		if(time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-CLOSENIC not responding.\n", 
dev->name);
 			break ; 
 		}
@@ -1347,7 +1348,7 @@ static int xl_close(struct net_device *d
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
 		schedule();		
-		if(jiffies-t > 10*HZ) {
+		if (time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-UPRESET not responding.\n", 
dev->name);
 			break ; 
 		}
@@ -1356,7 +1357,7 @@ static int xl_close(struct net_device *d
 	t=jiffies;
 	while (readw(xl_mmio + MMIO_INTSTATUS) & INTSTAT_CMD_IN_PROGRESS) { 
 		schedule();		
-		if(jiffies-t > 10*HZ) {
+		if (time_after(jiffies, t + 10 * HZ)) {
 			printk(KERN_ERR "%s: 3COM 3C359 Velocity XL-DNRESET not responding.\n", 
dev->name);
 			break ; 
 		}
-- 
1.4.1


-- 
<>< karhudever@gmail.com
