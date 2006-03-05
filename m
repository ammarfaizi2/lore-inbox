Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWCEUoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWCEUoX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 15:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWCEUoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 15:44:23 -0500
Received: from host-84-9-200-126.bulldogdsl.com ([84.9.200.126]:136 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1750929AbWCEUoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 15:44:22 -0500
Date: Sun, 5 Mar 2006 20:44:18 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Cc: ben@fluff.org
Subject: [PATCH] define setup_arch() in header file
Message-ID: <20060305204418.GA7244@home.fluff.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When running sparse over an ARM build of 2.6.16-rc5, I came
across this error, which is due to setup_arch() being used
be init/main.c, but not being defined in any headers.

This patch adds setup_arch() definition to include/linux/init.h

The warning is:
  arch/arm/kernel/setup.c:730:13: warning: symbol 'setup_arch' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="setup-define-archcall.patch"

diff -urpN -X ../dontdiff linux-2.6.16-rc5/include/linux/init.h linux-2.6.16-rc5-fixes/include/linux/init.h
--- linux-2.6.16-rc5/include/linux/init.h	2006-02-28 09:05:02.000000000 +0000
+++ linux-2.6.16-rc5-fixes/include/linux/init.h	2006-03-05 20:39:21.000000000 +0000
@@ -69,6 +69,10 @@ extern initcall_t __security_initcall_st
 
 /* Defined in init/main.c */
 extern char saved_command_line[];
+
+/* used by init/main.c */
+extern void setup_arch(char **);
+
 #endif
   
 #ifndef MODULE

--3V7upXqbjpZ4EhLz--
