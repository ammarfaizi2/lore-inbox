Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756077AbWKVRsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbWKVRsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756080AbWKVRsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:48:41 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:22942 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1756077AbWKVRsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:48:40 -0500
Date: Wed, 22 Nov 2006 09:48:42 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: ak@suse.de, akpm <akpm@osdl.org>
Subject: [PATCH] X86_genericarch needs SMP?
Message-Id: <20061122094842.75f3d35b.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

With
CONFIG_SMP=n, CONFIG_X86_GENERICARCH=y
(and CONFIG_X86_SUMMIT=n), kernel build gets:

arch/i386/mach-generic/built-in.o: In function `apicid_to_node':
summit.c:(.text+0x54): undefined reference to `apicid_2_node'

so should X86_GENERICARCH depend on SMP?
or should there be more ifdefs in the source files?

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/i386/Kconfig |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2619-rc6g4.orig/arch/i386/Kconfig
+++ linux-2619-rc6g4/arch/i386/Kconfig
@@ -165,8 +165,9 @@ config X86_VISWS
 	  and vice versa. See <file:Documentation/sgi-visws.txt> for details.
 
 config X86_GENERICARCH
-       bool "Generic architecture (Summit, bigsmp, ES7000, default)"
-       help
+	bool "Generic architecture (Summit, bigsmp, ES7000, default)"
+	depends on SMP
+	help
           This option compiles in the Summit, bigsmp, ES7000, default subarchitectures.
 	  It is intended for a generic binary kernel.
 	  If you want a NUMA kernel, select ACPI.   We need SRAT for NUMA.


---
