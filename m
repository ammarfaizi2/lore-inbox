Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbTIRXlw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTIRXlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:41:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:51931 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262234AbTIRXlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:41:47 -0400
Date: Thu, 18 Sep 2003 16:41:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: kai.germaschewski@gmx.de, mac@melware.de, torvalds@osdl.org
Subject: [PATCH 11/13] use cpu_relax() in busy loop
Message-ID: <20030918164145.O16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net> <20030918162930.G16499@osdlab.pdx.osdl.net> <20030918163156.H16499@osdlab.pdx.osdl.net> <20030918163311.I16499@osdlab.pdx.osdl.net> <20030918163408.J16499@osdlab.pdx.osdl.net> <20030918163523.K16499@osdlab.pdx.osdl.net> <20030918163645.L16499@osdlab.pdx.osdl.net> <20030918163757.M16499@osdlab.pdx.osdl.net> <20030918164006.N16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918164006.N16499@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 18, 2003 at 04:40:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 11/13] use cpu_relax() in busy loop

Replace busy loop nop with cpu_relax().

===== drivers/isdn/eicon/linio.c 1.8 vs edited =====
--- 1.8/drivers/isdn/eicon/linio.c	Mon Apr 21 03:58:37 2003
+++ edited/drivers/isdn/eicon/linio.c	Thu Sep 18 11:14:48 2003
@@ -38,7 +38,8 @@
 {
 	unsigned long timeout = jiffies + ((ms * HZ) / 1000);
 
-	while (time_before(jiffies, timeout));
+	while (time_before(jiffies, timeout))
+		cpu_relax();
 }
 
 int UxCardHandleGet(ux_diva_card_t **card, dia_card_t *cfg)

