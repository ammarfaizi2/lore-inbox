Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVEDU3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVEDU3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVEDU3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:29:09 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:49629
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261528AbVEDUXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:23:10 -0400
To: akpm@osdl.org
Subject: [2/6] generify memory present
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, apw@shadowen.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
Message-Id: <E1DTQOW-0002V4-TN@pinky.shadowen.org>
From: Andy Whitcroft <apw@shadowen.org>
Date: Wed, 04 May 2005 21:22:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow architectures to indicate that they will be providing hooks to
indice installed memory areas, memory_present().  Provide prototypes
for the i386 implementation.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Martin Bligh <mbligh@aracnet.com>
---
 arch/i386/Kconfig |    2 +-
 mm/Kconfig        |    4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/Kconfig current/arch/i386/Kconfig
--- reference/arch/i386/Kconfig	2005-05-04 20:54:26.000000000 +0100
+++ current/arch/i386/Kconfig	2005-05-04 20:54:26.000000000 +0100
@@ -777,7 +777,7 @@ config HAVE_ARCH_BOOTMEM_NODE
 	depends on NUMA
 	default y
 
-config HAVE_MEMORY_PRESENT
+config ARCH_HAVE_MEMORY_PRESENT
 	bool
 	depends on DISCONTIGMEM
 	default y
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/Kconfig current/mm/Kconfig
--- reference/mm/Kconfig	2005-05-04 20:54:24.000000000 +0100
+++ current/mm/Kconfig	2005-05-04 20:54:26.000000000 +0100
@@ -53,3 +53,7 @@ config FLATMEM
 config NEED_MULTIPLE_NODES
 	def_bool y
 	depends on DISCONTIGMEM || NUMA
+
+config HAVE_MEMORY_PRESENT
+	def_bool y
+	depends on ARCH_HAVE_MEMORY_PRESENT
