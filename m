Return-Path: <linux-kernel-owner+w=401wt.eu-S932177AbWLLJ35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWLLJ35 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWLLJ35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:29:57 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:31796 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932177AbWLLJ34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:29:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=agkEyJcPLpsiflx4XQMjbgMHFGyYC77Qqcgtc3p715OyNIF+LMyLUDb7DcYZs7lKWju5noPBIFKNhqb7VbSOhE6eFHfOCKPTgz/nah6PltUoMrtDTf3fnXvXRBh3SEgOS5ZKVEH0ZAPvcnD/H9hnZ04/TkY0IUfLsXF7cz96vwY=
Message-ID: <457E768F.6050606@gmail.com>
Date: Tue, 12 Dec 2006 14:59:51 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Alpha increase PERCPU_ENOUGH_ROOM
Content-Type: multipart/mixed;
 boundary="------------040307060102020004050000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040307060102020004050000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------040307060102020004050000
Content-Type: text/plain;
 name="0002-Alpha-increase-PERCPU_ENOUGH_ROOM.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-Alpha-increase-PERCPU_ENOUGH_ROOM.txt"


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


--------------040307060102020004050000--
