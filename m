Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTIRX1v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbTIRX1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:27:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:211 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262190AbTIRX1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:27:50 -0400
Date: Thu, 18 Sep 2003 16:27:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: chas@cmf.nrl.navy.mil, torvalds@osdl.org
Subject: [PATCH 2/13] use cpu_relax() in busy loop
Message-ID: <20030918162748.F16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918162522.E16499@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 18, 2003 at 04:25:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2/13] use cpu_relax() in busy loop

Replace busy loop nop with cpu_relax().

===== drivers/atm/fore200e.c 1.19 vs edited =====
--- 1.19/drivers/atm/fore200e.c	Tue Sep  2 11:07:59 2003
+++ edited/drivers/atm/fore200e.c	Thu Sep 18 10:42:17 2003
@@ -248,7 +248,8 @@
 fore200e_spin(int msecs)
 {
     unsigned long timeout = jiffies + MSECS(msecs);
-    while (time_before(jiffies, timeout));
+    while (time_before(jiffies, timeout))
+    	cpu_relax();
 }
 
 
