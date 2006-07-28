Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752026AbWG1QHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbWG1QHQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbWG1QGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:06:46 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:30392 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1752031AbWG1QGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:06:44 -0400
Subject: [patch 5/5] Add the -fstack-protector option to the CFLAGS
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1154102546.6416.9.camel@laptopd505.fenrus.org>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 18:05:35 +0200
Message-Id: <1154102736.6416.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch 5/5] Add the -fstack-protector option to the CFLAGS
From: Arjan van de Ven <arjan@linux.intel.com>

Add the actual compiler options to the CFLAGS, but only for gcc 4.2
and later. Based on feedback from Sam Ravnborg.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
CC: Sam Ravnborg <sam@ravnborg.org>
CC: Andi Kleen <ak@suse.de>
--
Index: linux-2.6.18-rc2-git5-stackprot/Makefile
===================================================================
--- linux-2.6.18-rc2-git5-stackprot.orig/Makefile
+++ linux-2.6.18-rc2-git5-stackprot/Makefile
@@ -487,6 +487,18 @@ ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif
 
+ifdef CONFIG_CC_STACKPROTECTOR
+CFLAGS += $(call cc-ifversion, -lt, 0402, -fno-stack-protector)
+CFLAGS += $(call cc-ifversion, -ge, 0402, -fstack-protector)
+else
+CFLAGS += -fno-stack-protector
+endif
+
+ifdef CONFIG_CC_STACKPROTECTOR_ALL
+CFLAGS += $(call cc-ifversion, -ge, 0402, -fstack-protector-all)
+endif
+
+
 include $(srctree)/arch/$(ARCH)/Makefile
 
 # arch Makefile may override CC so keep this after arch Makefile is included

