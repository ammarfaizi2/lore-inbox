Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTIRXol (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTIRXoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:44:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:18908 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262240AbTIRXnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:43:19 -0400
Date: Thu, 18 Sep 2003 16:43:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH 12/13] use cpu_relax() in busy loop
Message-ID: <20030918164317.P16499@osdlab.pdx.osdl.net>
References: <20030918162748.F16499@osdlab.pdx.osdl.net> <20030918162930.G16499@osdlab.pdx.osdl.net> <20030918163156.H16499@osdlab.pdx.osdl.net> <20030918163311.I16499@osdlab.pdx.osdl.net> <20030918163408.J16499@osdlab.pdx.osdl.net> <20030918163523.K16499@osdlab.pdx.osdl.net> <20030918163645.L16499@osdlab.pdx.osdl.net> <20030918163757.M16499@osdlab.pdx.osdl.net> <20030918164006.N16499@osdlab.pdx.osdl.net> <20030918164145.O16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918164145.O16499@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 18, 2003 at 04:41:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace busy loop nop with cpu_relax().

===== drivers/scsi/i91uscsi.c 1.6 vs edited =====
--- 1.6/drivers/scsi/i91uscsi.c	Fri May  2 12:34:33 2003
+++ edited/drivers/scsi/i91uscsi.c	Thu Sep 18 11:49:49 2003
@@ -212,7 +212,8 @@
 {				/* Pause for amount jiffies */
 	unsigned long the_time = jiffies + amount;
 
-	while (time_before_eq(jiffies, the_time));
+	while (time_before_eq(jiffies, the_time))
+		cpu_relax();
 }
 
 /*-- forward reference --*/

