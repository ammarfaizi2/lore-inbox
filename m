Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVAOHRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVAOHRw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 02:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVAOHRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 02:17:42 -0500
Received: from palrel11.hp.com ([156.153.255.246]:59614 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262230AbVAOHRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 02:17:40 -0500
Date: Fri, 14 Jan 2005 23:17:31 -0800
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200501150717.j0F7HVMw022426@napali.hpl.hp.com>
To: akpm@osdl.org
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: [patch] avoid sparse warning due to time-interpolator
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "addr" member in the time-interpolator is sometimes used as a
function-pointer and sometimes as an I/O-memory pointer.  The attached
patch tells sparse that this is OK.

Signed-off-by: David Mosberger-Tang <davidm@hpl.hp.com>

===== kernel/timer.c 1.109 vs edited =====
--- 1.109/kernel/timer.c	2005-01-11 16:42:35 -08:00
+++ edited/kernel/timer.c	2005-01-14 22:05:53 -08:00
@@ -1411,10 +1411,10 @@
 			return x();
 
 		case TIME_SOURCE_MMIO64	:
-			return readq(time_interpolator->addr);
+			return readq((void __iomem *) time_interpolator->addr);
 
 		case TIME_SOURCE_MMIO32	:
-			return readl(time_interpolator->addr);
+			return readl((void __iomem *) time_interpolator->addr);
 
 		default: return get_cycles();
 	}
