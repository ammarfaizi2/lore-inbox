Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbTIRXeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbTIRXeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:34:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:16598 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262183AbTIRXeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:34:09 -0400
Date: Thu, 18 Sep 2003 16:34:08 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH 6/13] use cpu_relax() in busy loop
Message-ID: <20030918163408.J16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net> <20030918162930.G16499@osdlab.pdx.osdl.net> <20030918163156.H16499@osdlab.pdx.osdl.net> <20030918163311.I16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918163311.I16499@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 18, 2003 at 04:33:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace busy loop nop with cpu_relax().

===== drivers/char/moxa.c 1.25 vs edited =====
--- 1.25/drivers/char/moxa.c	Mon Jun 23 18:43:58 2003
+++ edited/drivers/char/moxa.c	Thu Sep 18 10:56:00 2003
@@ -2758,7 +2758,8 @@
 
 	st = jiffies;
 	et = st + tick;
-	while (time_before(jiffies, et));
+	while (time_before(jiffies, et))
+		cpu_relax();
 }
 
 static void moxafunc(unsigned long ofsAddr, int cmd, ushort arg)

