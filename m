Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVDBFGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVDBFGk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 00:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVDBFGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 00:06:40 -0500
Received: from ozlabs.org ([203.10.76.45]:61077 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261691AbVDBFGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 00:06:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16974.8603.674172.998226@cargo.ozlabs.ibm.com>
Date: Sat, 2 Apr 2005 14:37:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc: eliminate gcc warning in prom.c
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch shuts up a couple of gcc "variable may be used
uninitialized" warnings.  The warnings are invalid - the code is such
that the variables are in fact initialized before being used - but gcc
isn't smart enough to see that.  This patch eliminates the warnings.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/syslib/prom.c pmac-2.5/arch/ppc/syslib/prom.c
--- linux-2.5/arch/ppc/syslib/prom.c	2005-01-22 09:25:41.000000000 +1100
+++ pmac-2.5/arch/ppc/syslib/prom.c	2005-01-30 18:54:26.000000000 +1100
@@ -308,7 +308,7 @@
 	struct device_node *p, *ipar;
 	unsigned int *imap, *imask, *ip;
 	int i, imaplen, match;
-	int newintrc, newaddrc;
+	int newintrc = 1, newaddrc = 1;
 	unsigned int *reg;
 	int naddrc;
 
