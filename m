Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264992AbUFRFLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbUFRFLp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 01:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbUFRFLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 01:11:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:28084 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264992AbUFRFLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 01:11:41 -0400
Date: Thu, 17 Jun 2004 22:06:51 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] save kernel version in .config file
Message-Id: <20040617220651.0ceafa91.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is this interesting to anyone besides me?



Save kernel version info when writing .config file.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 scripts/kconfig/confdata.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -Naurp ./scripts/kconfig/confdata.c~config_version ./scripts/kconfig/confdata.c
--- ./scripts/kconfig/confdata.c~config_version	2004-06-15 22:20:21.000000000 -0700
+++ ./scripts/kconfig/confdata.c	2004-06-17 22:00:22.000000000 -0700
@@ -301,14 +301,19 @@ int conf_write(const char *name)
 		if (!out_h)
 			return 1;
 	}
+	sym = sym_lookup("KERNELRELEASE", 0);
 	fprintf(out, "#\n"
 		     "# Automatically generated make config: don't edit\n"
-		     "#\n");
+		     "# for Linux kernel version: %s\n"
+		     "#\n",
+		     (char *)sym->curr.val);
 	if (out_h)
 		fprintf(out_h, "/*\n"
 			       " * Automatically generated C config: don't edit\n"
+			       " * for Linux kernel version: %s\n"
 			       " */\n"
-			       "#define AUTOCONF_INCLUDED\n");
+			       "#define AUTOCONF_INCLUDED\n",
+			       (char *)sym->curr.val);
 
 	if (!sym_change_count)
 		sym_clear_all_valid();

