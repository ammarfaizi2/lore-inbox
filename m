Return-Path: <linux-kernel-owner+w=401wt.eu-S932538AbWLMDpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWLMDpv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 22:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWLMDpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 22:45:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:24149 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932538AbWLMDpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 22:45:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=gI/Tlhr6lArSA168Uj6H+Us6L/gfC64mJsXcQAxRJ0M/H5VNrSbjWq2XF9iiZIKYMsVR029lDjgnj2Li2LMPTNI1gMWy8qfS3jxnzKDLvdEGXhDnU7iZspiwmiECeN1y7EZW6tbUfrGUrcR3vDdPihTuSSqCHIwOf8C2ilykpPc=
Date: Wed, 13 Dec 2006 09:15:38 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
To: Jay.Estabrook@hp.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Alpha increase PERCPU_ENOUGH_ROOM
Message-ID: <20061213034538.GA6434@kvaneesh-laptop.asiapacific.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sending it again marking Jay Estabrook

-aneesh 

Module loading on Alpha was failing with error
"Could not allocate 8 bytes percpu data".

Looking at dmesg we have the below error
"No per-cpu room for modules."

Increase the PERCPU_ENOUGH_ROOM in a similar way as x86_64

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 include/asm-alpha/percpu.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/include/asm-alpha/percpu.h b/include/asm-alpha/percpu.h
index 48348fe..651ebb1 100644
--- a/include/asm-alpha/percpu.h
+++ b/include/asm-alpha/percpu.h
@@ -1,6 +1,20 @@
 #ifndef __ALPHA_PERCPU_H
 #define __ALPHA_PERCPU_H
 
+/*
+ * Increase the per cpu area for Alpha so that
+ * modules using percpu area can load.
+ */
+#ifdef CONFIG_MODULES
+# define PERCPU_MODULE_RESERVE 8192
+#else
+# define PERCPU_MODULE_RESERVE 0
+#endif
+
+#define PERCPU_ENOUGH_ROOM \
+	(ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES) + \
+	 PERCPU_MODULE_RESERVE)
+
 #include <asm-generic/percpu.h>
 
 #endif /* __ALPHA_PERCPU_H */
-- 
1.4.4.2.gdb98-dirty

