Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVARTiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVARTiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVARThA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:37:00 -0500
Received: from news.suse.de ([195.135.220.2]:1419 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261409AbVARTfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:35:36 -0500
Message-Id: <20050118192608.423265000.suse.de>
References: <20050118184123.729034000.suse.de>
Date: Tue, 18 Jan 2005 19:41:23 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [kbuild 2/5] Dont use the running kernels config file by default
Content-Disposition: inline; filename=default-configuration.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A user ran into the following problem: They grab a SuSE kernel-source
package that is more recent than their running kernel. The tree under
/usr/src/linux is unconfigured by default; there is no .config. User
does a ``make menuconfig'', which gets its default values from
/boot/config-$(uname -r). User tries to build the kernel, which doesn't
work.

I would like to get rid of using the running kernel's configuration
unless the user explicitly requests it. Instead, please add the
cloneconfig target to clone the running kernel's config file. See other
patch.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc1-bk6/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6.11-rc1-bk6.orig/scripts/kconfig/confdata.c
+++ linux-2.6.11-rc1-bk6/scripts/kconfig/confdata.c
@@ -20,9 +20,6 @@ const char conf_defname[] = "arch/$ARCH/
 
 const char *conf_confnames[] = {
 	".config",
-	"/lib/modules/$UNAME_RELEASE/.config",
-	"/etc/kernel-config",
-	"/boot/config-$UNAME_RELEASE",
 	conf_defname,
 	NULL,
 };

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

