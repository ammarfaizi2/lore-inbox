Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWCINrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWCINrb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWCINrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:47:31 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:23922
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932153AbWCINra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:47:30 -0500
Message-Id: <44104012.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 09 Mar 2006 14:47:46 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix time ordering of writes to .kconfig.d and
	include/linux/autoconf.h
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since .kconfig.d is used as a make dependency of include/linux/autoconf.h, it
should be written earlier than the header file, to avoid a subsequent rebuild
to consider the header outdated.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc5/scripts/kconfig/confdata.c
2.6.16-rc5-kconfig_d-deps/scripts/kconfig/confdata.c
--- /home/jbeulich/tmp/linux-2.6.16-rc5/scripts/kconfig/confdata.c	2006-02-28 08:41:04.000000000 +0100
+++ 2.6.16-rc5-kconfig_d-deps/scripts/kconfig/confdata.c	2006-03-09 13:35:25.000000000 +0100
@@ -374,6 +374,7 @@ int conf_write(const char *name)
 		out_h = fopen(".tmpconfig.h", "w");
 		if (!out_h)
 			return 1;
+		file_write_dep(NULL);
 	}
 	sym = sym_lookup("KERNELVERSION", 0);
 	sym_calc_value(sym);
@@ -512,7 +513,6 @@ int conf_write(const char *name)
 	if (out_h) {
 		fclose(out_h);
 		rename(".tmpconfig.h", "include/linux/autoconf.h");
-		file_write_dep(NULL);
 	}
 	if (!name || basename != conf_def_filename) {
 		if (!name)

