Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbTIRXi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbTIRXiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:38:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:63704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262214AbTIRXh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:37:59 -0400
Date: Thu, 18 Sep 2003 16:37:57 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com, torvalds@osdl.org
Subject: [PATCH 9/13] use cpu_relax() in busy loop
Message-ID: <20030918163757.M16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net> <20030918162930.G16499@osdlab.pdx.osdl.net> <20030918163156.H16499@osdlab.pdx.osdl.net> <20030918163311.I16499@osdlab.pdx.osdl.net> <20030918163408.J16499@osdlab.pdx.osdl.net> <20030918163523.K16499@osdlab.pdx.osdl.net> <20030918163645.L16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918163645.L16499@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 18, 2003 at 04:36:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace busy loop nop with cpu_relax().

===== net/ipv4/ipconfig.c 1.29 vs edited =====
--- 1.29/net/ipv4/ipconfig.c	Fri Aug 15 00:41:43 2003
+++ edited/net/ipv4/ipconfig.c	Thu Sep 18 11:57:00 2003
@@ -1153,7 +1153,7 @@
 	/* Give hardware a chance to settle */
 	jiff = jiffies + CONF_PRE_OPEN;
 	while (time_before(jiffies, jiff))
-		;
+		cpu_relax();
 
 	/* Setup all network devices */
 	if (ic_open_devs() < 0)
@@ -1162,7 +1162,7 @@
 	/* Give drivers a chance to settle */
 	jiff = jiffies + CONF_POST_OPEN;
 	while (time_before(jiffies, jiff))
-			;
+		cpu_relax();
 
 	/*
 	 * If the config information is insufficient (e.g., our IP address or
