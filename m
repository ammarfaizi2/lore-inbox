Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTIRX3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTIRX3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:29:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:9427 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262193AbTIRX3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:29:31 -0400
Date: Thu, 18 Sep 2003 16:29:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH 3/13] use cpu_relax() in busy loop
Message-ID: <20030918162930.G16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918162748.F16499@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 18, 2003 at 04:27:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace busy loop nop with cpu_relax().

===== drivers/block/ps2esdi.c 1.69 vs edited =====
--- 1.69/drivers/block/ps2esdi.c	Wed Sep 10 18:18:39 2003
+++ edited/drivers/block/ps2esdi.c	Thu Sep 18 10:45:34 2003
@@ -550,7 +550,8 @@
 		printk("%s: hard reset...\n", DEVICE_NAME);
 		outb_p(CTRL_HARD_RESET, ESDI_CONTROL);
 		expire = jiffies + 2*HZ;
-		while (time_before(jiffies, expire));
+		while (time_before(jiffies, expire))
+			cpu_relax();
 		outb_p(1, ESDI_CONTROL);
 	}			/* hard reset */
 

