Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbTIRXdP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbTIRXdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:33:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:7126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262205AbTIRXdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:33:12 -0400
Date: Thu, 18 Sep 2003 16:33:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH 5/13] use cpu_relax() in busy loop
Message-ID: <20030918163311.I16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net> <20030918162930.G16499@osdlab.pdx.osdl.net> <20030918163156.H16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918163156.H16499@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 18, 2003 at 04:31:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace busy loop nop with cpu_relax().

===== drivers/char/isicom.c 1.25 vs edited =====
--- 1.25/drivers/char/isicom.c	Mon Aug 18 10:39:47 2003
+++ edited/drivers/char/isicom.c	Thu Sep 18 10:54:12 2003
@@ -153,12 +153,14 @@
 								
 			inw(base+0x8);
 			
-			for(i=jiffies+HZ/100;time_before(jiffies, i););
+			for(i=jiffies+HZ/100;time_before(jiffies, i);)
+				cpu_relax();
 				
 			outw(0,base+0x8); /* Reset */
 			
 			for(j=1;j<=3;j++) {
-				for(i=jiffies+HZ;time_before(jiffies, i););
+				for(i=jiffies+HZ;time_before(jiffies, i);)
+					cpu_relax();
 				printk(".");
 			}	
 			signature=(inw(base+0x4)) & 0xff;	

