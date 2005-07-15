Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263307AbVGOO4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbVGOO4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 10:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbVGOO4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 10:56:38 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:20456 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S263307AbVGOO4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 10:56:37 -0400
Date: Fri, 15 Jul 2005 07:56:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, stable@kernel.org
Subject: [PATCH 2.6.13-rc3] kbuild: When checking depmod version, redirect stderr
Message-ID: <20050715145636.GU7741@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running depmod to check for the correct version number, extra
output we don't need to see, such as "depmod: QM_MODULES: Function not
implemented" may show up.  Redirect stderr to /dev/null as the version
information that we do care about comes to stdout.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -875,7 +875,7 @@ modules_install: _modinst_ _modinst_post
 
 .PHONY: _modinst_
 _modinst_:
-	@if [ -z "`$(DEPMOD) -V | grep module-init-tools`" ]; then \
+	@if [ -z "`$(DEPMOD) -V 2>/dev/null | grep module-init-tools`" ]; then \
 		echo "Warning: you may need to install module-init-tools"; \
 		echo "See http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt";\
 		sleep 1; \

-- 
Tom Rini
http://gate.crashing.org/~trini/
