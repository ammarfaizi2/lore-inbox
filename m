Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWEBFe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWEBFe3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWEBFe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:34:28 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:12514 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932376AbWEBFe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:34:28 -0400
Date: Tue, 02 May 2006 14:33:40 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix compile error "undefined reference" for sparc64.
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060502142722.CF0C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Andrew-san.

This is to fix compile error against "undefined reference to 
`arch_add_memory'". This error occurred on sparc64.
This means that memory hotplug can be enable even if 
architecture doesn't have memory hotplug feature.

Sparsemem is useful even if it doesn't have memory hotplug.
So, this patch allows hotplug for only the architecture which have
memory hotplug feature (ia64, x86-32/64, ppc64 now).
Sparc64 can use sparsemem option by it.

This patch is for 2.6.17-rc3-mm1.

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 mm/Kconfig |    1 +
 1 files changed, 1 insertion(+)

Index: pgdat13/mm/Kconfig
===================================================================
--- pgdat13.orig/mm/Kconfig	2006-05-02 13:21:53.000000000 -0400
+++ pgdat13/mm/Kconfig	2006-05-02 13:50:07.000000000 -0400
@@ -116,6 +116,7 @@
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
 	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
+	depends on (IA64 || X86 || PPC64)
 
 comment "Memory hotplug is currently incompatible with Software Suspend"
 	depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND

-- 
Yasunori Goto 


