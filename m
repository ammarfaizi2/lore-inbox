Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbUJZN1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUJZN1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 09:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbUJZN1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 09:27:20 -0400
Received: from verein.lst.de ([213.95.11.210]:42978 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262259AbUJZN1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 09:27:17 -0400
Date: Tue, 26 Oct 2004 15:26:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix show_refcnt return value type
Message-ID: <20041026132656.GB25384@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

module_attribute.show is defined to return ssize_t


--- 1.123/kernel/module.c	2004-10-25 22:06:46 +02:00
+++ edited/kernel/module.c	2004-10-26 12:59:13 +02:00
@@ -649,7 +649,7 @@
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
-static int show_refcnt(struct module *mod, char *buffer)
+static ssize_t show_refcnt(struct module *mod, char *buffer)
 {
 	/* sysfs holds a reference */
 	return sprintf(buffer, "%u\n", module_refcount(mod)-1);
