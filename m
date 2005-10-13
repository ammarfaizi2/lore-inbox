Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbVJMViw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVJMViw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 17:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVJMViw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 17:38:52 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:43718 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750910AbVJMViw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 17:38:52 -0400
Subject: [PATCH] modules: fix sparse warning for every MODULE_PARM
From: Pavel Roskin <proski@gnu.org>
To: linux <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Oct 2005 17:38:44 -0400
Message-Id: <1129239524.21926.15.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains about every MODULE_PARM used in a module:
warning: symbol '__parm_foo' was not declared. Should it be static?

The fix is to split declaration and initialization.  While MODULE_PARM
is obsolete, it's not something sparse should report.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/include/linux/module.h b/include/linux/module.h
index f05372b..84d75f3 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -554,7 +554,9 @@ static inline void MODULE_PARM_(void) { 
 #ifdef MODULE
 /* DEPRECATED: Do not use. */
 #define MODULE_PARM(var,type)						    \
-struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
+extern struct obsolete_modparm __parm_##var \
+__attribute__((section("__obsparm"))); \
+struct obsolete_modparm __parm_##var = \
 { __stringify(var), type, &MODULE_PARM_ }; \
 __MODULE_PARM_TYPE(var, type);
 #else


-- 
Regards,
Pavel Roskin

