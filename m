Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVABUAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVABUAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVABUAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:00:42 -0500
Received: from verein.lst.de ([213.95.11.210]:2181 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261310AbVABUAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:00:37 -0500
Date: Sun, 2 Jan 2005 21:00:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] disallow modular capabilities
Message-ID: <20050102200032.GA8623@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's been a bugtraq report about a root exploit with modular
capabilities LSM support out for more than a week.

This patch fixes it the hard way by disallowing to build the code
modular.  In fact I think allowing modular security policies is a 
really, really bad idea because loading it after boot loses far
too much state.  Would you take a patch killing the exports in
security/ ?


--- 1.10/security/Kconfig	2004-10-20 10:37:08 +02:00
+++ edited/security/Kconfig	2005-01-02 20:50:35 +01:00
@@ -54,7 +54,7 @@
 	  If you are unsure how to answer this question, answer N.
 
 config SECURITY_CAPABILITIES
-	tristate "Default Linux Capabilities"
+	bool "Default Linux Capabilities"
 	depends on SECURITY
 	help
 	  This enables the "default" Linux capabilities functionality.
