Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTIRXqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbTIRXqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:46:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:9439 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262198AbTIRXqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:46:02 -0400
Date: Thu, 18 Sep 2003 16:46:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, torvalds@osdl.org
Subject: [PATCH 13/13] use cpu_relax() in busy loop
Message-ID: <20030918164601.Q16499@osdlab.pdx.osdl.net>
References: <20030918162930.G16499@osdlab.pdx.osdl.net> <20030918163156.H16499@osdlab.pdx.osdl.net> <20030918163311.I16499@osdlab.pdx.osdl.net> <20030918163408.J16499@osdlab.pdx.osdl.net> <20030918163523.K16499@osdlab.pdx.osdl.net> <20030918163645.L16499@osdlab.pdx.osdl.net> <20030918163757.M16499@osdlab.pdx.osdl.net> <20030918164006.N16499@osdlab.pdx.osdl.net> <20030918164145.O16499@osdlab.pdx.osdl.net> <20030918164317.P16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918164317.P16499@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 18, 2003 at 04:43:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace busy loop rep_nop() with cpu_relax().

This is bordering on a gratuitous change given the x86_64 def'n of
cpu_relax().  But I was fixing up other busy loops, and my grep found
this one.

===== arch/x86_64/kernel/smpboot.c 1.21 vs edited =====
--- 1.21/arch/x86_64/kernel/smpboot.c	Sat Aug 23 05:13:33 2003
+++ edited/arch/x86_64/kernel/smpboot.c	Thu Sep 18 10:26:41 2003
@@ -282,7 +282,7 @@
 		 */
 		if (cpu_isset(cpuid, cpu_callout_map))
 			break;
-		rep_nop();
+		cpu_relax();
 	}
 
 	if (!time_before(jiffies, timeout)) {
