Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268527AbUHXXr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268527AbUHXXr2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268506AbUHXXnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:43:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:37800 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268529AbUHXXnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:43:04 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: [PATCH] fix cc-version breakage
Date: Tue, 24 Aug 2004 16:42:21 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dJ9KBe95ttlHnRm"
Message-Id: <200408241642.21886.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dJ9KBe95ttlHnRm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Looks like someone forgot to use $(shell ...) on the cc-version function?

Jesse

--Boundary-00=_dJ9KBe95ttlHnRm
Content-Type: text/plain;
  charset="us-ascii";
  name="cc-version-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cc-version-fix.patch"

===== Makefile 1.522 vs edited =====
--- 1.522/Makefile	2004-08-23 23:59:52 -07:00
+++ edited/Makefile	2004-08-24 16:39:46 -07:00
@@ -279,8 +279,8 @@
 
 # cc-version
 # Usage gcc-ver := $(call cc-version $(CC))
-cc-version = $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
-              $(if $(1), $(1), $(CC))
+cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
+              $(if $(1), $(1), $(CC)))
 
 
 # Look for make include files relative to root of kernel src

--Boundary-00=_dJ9KBe95ttlHnRm--
