Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVFOO5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVFOO5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVFOO5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:57:23 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:13521 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261154AbVFOO5O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:57:14 -0400
Subject: [PATCH] 5 of 5 IMA: Makefile
From: Reiner Sailer <sailer@watson.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@mail.wirex.com>
Cc: Chris Wright <chrisw@osdl.org>, Greg KH <greg@kroah.com>,
       Emily Rattlif <emilyr@us.ibm.com>, Kylene Hall <kylene@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, Reiner Sailer <sailer@us.ibm.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 11:01:28 -0400
Message-Id: <1118847688.2269.25.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This (last) patch related to IMA applies against linux-2.6.12-rc6-mm1 
and provides a patch to the top-level kernel Makefile changing the compile 
order of the crypto and security directories. This patch ensures that 
the crypto API is initialized before IMA initializes. IMA needs 
crypto/SHA1 at initialization time.

Signed-off-by: Reiner Sailer <sailer@watson.ibm.com>
---

diff -uprN linux-2.6.12-rc6-mm1_orig/Makefile linux-2.6.12-rc6-mm1-ima/Makefile
--- linux-2.6.12-rc6-mm1_orig/Makefile	2005-06-14 11:34:27.000000000 -0400
+++ linux-2.6.12-rc6-mm1-ima/Makefile	2005-06-14 16:25:16.000000000 -0400
@@ -563,7 +563,7 @@ export MODLIB
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/
+core-y		+= kernel/ mm/ fs/ ipc/ crypto/ security/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \


