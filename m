Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTIRXb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbTIRXb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:31:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:62933 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262202AbTIRXb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:31:57 -0400
Date: Thu, 18 Sep 2003 16:31:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH 4/13] use cpu_relax() in busy loop
Message-ID: <20030918163156.H16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net> <20030918162930.G16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918162930.G16499@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 18, 2003 at 04:29:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace busy loop nop with cpu_relax().

===== drivers/cdrom/sonycd535.c 1.39 vs edited =====
--- 1.39/drivers/cdrom/sonycd535.c	Tue Sep  9 07:41:30 2003
+++ edited/drivers/cdrom/sonycd535.c	Thu Sep 18 10:52:41 2003
@@ -1526,7 +1526,8 @@
 		enable_interrupts();
 		outb(0, read_status_reg);	/* does a reset? */
 		delay = jiffies + HZ/10;
-		while (time_before(jiffies, delay)) ;
+		while (time_before(jiffies, delay))
+			cpu_relax();
 
 		sony535_irq_used = probe_irq_off(irq_mask);
 		disable_interrupts();

