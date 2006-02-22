Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWBVM2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWBVM2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWBVM2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:28:39 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:8649 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S1751230AbWBVM2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:28:38 -0500
From: Jan Beulich <jbeulich@novell.com>
To: sam@ravnborg.org
Subject: [PATCH] version.h should depend on .kernelrelease
Date: Wed, 22 Feb 2006 13:29:04 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221329.04547.jbeulich@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rebuilding a previously built tree while using make's -j options from time to
time results in the version.h check running at the same time as the updating
of .kernelrelease, resulting in UTS_RELEASE remaining an empty string (and as
a side effect causing the entire kernel to be rebuilt).

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/Makefile 2.6.16-rc4-version.h-depends-on-kernelrelease/Makefile
--- /home/jbeulich/tmp/linux-2.6.16-rc4/Makefile	2006-02-20 09:12:27.000000000 +0100
+++ 2.6.16-rc4-version.h-depends-on-kernelrelease/Makefile	2006-02-20 09:59:29.000000000 +0100
@@ -905,7 +905,7 @@ define filechk_version.h
 	)
 endef
 
-include/linux/version.h: $(srctree)/Makefile .config FORCE
+include/linux/version.h: $(srctree)/Makefile .config .kernelrelease FORCE
 	$(call filechk,version.h)
 
 # ---------------------------------------------------------------------------

