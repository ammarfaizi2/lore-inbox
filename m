Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVLCAlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVLCAlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 19:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVLCAlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 19:41:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22173 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751074AbVLCAlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 19:41:15 -0500
Date: Fri, 2 Dec 2005 19:41:02 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Add tainting for proprietary helper modules.
Message-ID: <20051203004102.GA2923@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernels that have had Windows drivers loaded into them are undebuggable.
I've wasted a number of hours chasing bugs filed in Fedora bugzilla
only to find out much later that the user had used such 'helpers',
and their problems were unreproducable without them loaded.

Acked-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/kernel/module.c~	2005-11-29 16:44:00.000000000 -0500
+++ linux-2.6.14/kernel/module.c	2005-11-29 17:03:55.000000000 -0500
@@ -1723,6 +1723,11 @@ static struct module *load_module(void _
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
 
+	if (strcmp(mod->name, "ndiswrapper") == 0)
+		add_taint(TAINT_PROPRIETARY_MODULE);
+	if (strcmp(mod->name, "driverloader") == 0)
+		add_taint(TAINT_PROPRIETARY_MODULE);
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* Set up MODINFO_ATTR fields */
 	setup_modinfo(mod, sechdrs, infoindex);
