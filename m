Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTIRXZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTIRXZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:25:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:51922 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262196AbTIRXZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:25:24 -0400
Date: Thu, 18 Sep 2003 16:25:22 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk, torvalds@osdl.org
Subject: [PATCH 1/13] use cpu_relax() in busy loop
Message-ID: <20030918162522.E16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace busy loop barrier() with cpu_relax().

This is bordering on a gratuitous change given the arm def'n of
cpu_relax().  But I was fixing up other busy loops, and my grep found
this one.

===== drivers/scsi/arm/acornscsi.c 1.35 vs edited =====
--- 1.35/drivers/scsi/arm/acornscsi.c	Mon Aug 25 06:37:34 2003
+++ edited/drivers/scsi/arm/acornscsi.c	Thu Sep 18 11:48:26 2003
@@ -319,7 +319,7 @@
     local_save_flags(flags);
     local_irq_enable();
 
-    while (time_before(jiffies, target_jiffies)) barrier();
+    while (time_before(jiffies, target_jiffies)) cpu_relax();
 
     local_irq_restore(flags);
 }

