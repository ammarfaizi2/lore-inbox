Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUE2U6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUE2U6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 16:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUE2U6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 16:58:23 -0400
Received: from d64-180-152-77.bchsia.telus.net ([64.180.152.77]:53256 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S264389AbUE2U6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 16:58:21 -0400
Date: Sat, 29 May 2004 13:51:09 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: makefile fix
Message-ID: <20040529205109.GA27792@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every time I build on the Ultra, I get a file called "64" in the top-level
directory.  Here's a small patch to make it do the right thing(tm).

Note, I'm using ash as my /bin/sh.  Works for me, at least, with bash and
ash.

-- DN
Daniel

===== Makefile 1.487 vs edited =====
--- 1.487/Makefile	2004-05-19 09:02:53 -07:00
+++ edited/Makefile	2004-05-29 13:54:29 -07:00
@@ -680,7 +680,7 @@
 uts_len := 64
 
 define filechk_version.h
-	if ((`echo -n "$(KERNELRELEASE)" | wc -c ` > $(uts_len))); then \
+	if [ `echo -n "$(KERNELRELEASE)" | wc -c ` -gt $(uts_len) ]; then \
 	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2; \
 	  exit 1; \
 	fi; \
