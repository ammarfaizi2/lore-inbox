Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWJBPh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWJBPh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWJBPh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:37:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10640 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964805AbWJBPh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:37:26 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] FRV: Permit large kmalloc allocations
Date: Mon, 02 Oct 2006 16:37:08 +0100
To: akpm@osdl.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20061002153708.22649.96337.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Permit kmalloc() to make allocations of up to 32MB if so configured.  This may
be useful under NOMMU conditions where vmalloc() can't do this.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/Kconfig |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index f7b171b..69f9846 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -86,6 +86,14 @@ config HIGHPTE
 	  with a lot of RAM, this can be wasteful of precious low memory.
 	  Setting this option will put user-space page tables in high memory.
 
+config LARGE_ALLOCS
+	bool "Allow allocating large blocks (> 1MB) of memory"
+	help
+	  Allow the slab memory allocator to keep chains for very large memory
+	  sizes - upto 32MB. You may need this if your system has a lot of RAM,
+	  and you need to able to allocate very large contiguous chunks. If
+	  unsure, say N.
+
 source "mm/Kconfig"
 
 choice
