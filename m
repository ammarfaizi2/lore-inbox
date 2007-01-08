Return-Path: <linux-kernel-owner+w=401wt.eu-S1751538AbXAHNhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbXAHNhw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbXAHNhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:37:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44805 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbXAHNhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:37:51 -0500
Date: Mon, 8 Jan 2007 13:37:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: akpm@osdl.org, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: kobject.c changes in -mm
Message-ID: <20070108133747.GA19692@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
	gregkh@suse.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.20-rc3/lib/kobject.c      2007-01-01 23:04:49.000000000 -0800
+++ devel/lib/kobject.c 2007-01-04 21:13:21.000000000 -0800
@@ -15,6 +15,8 @@
 #include <linux/module.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
+#include <linux/kallsyms.h>
+#include <asm-generic/sections.h>

+#ifdef CONFIG_X86_32
+static int ptr_in_range(void *ptr, void *start, void *end)
+{
+       /*
+        * This should hopefully get rid of causing warnings
+        * if the architecture did not set one of the section
+        * variables up.
+        */ 
+       if (start >= end)
+               return 0;
+
+       if ((ptr >= start) && (ptr < end))
+               return 1;
+       return 0;
+}      


Can anyone explain WTF is going on here?  Including asm-generic headers
in core code definitly is not okay.  As are random CONFIG_X86_32 ifdefs
in said code.
