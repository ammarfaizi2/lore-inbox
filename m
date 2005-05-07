Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVEGIch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVEGIch (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVEGI1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:27:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:9637 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262782AbVEGIOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:14:30 -0400
Date: Sat, 07 May 2005 17:12:48 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: drivers/block/rd.c rd_size reference problem of ARM
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>
Message-id: <0IG400GKZ1K24Y@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3I46hf2I3g0zSMyGjqW7/qoafw==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the variable "rd_size" of drivers/block/rd.c is changed to be "static" in
2.6.12-rc3-mm3.
it causes compilation error to ARM architecture because of the reference of
that.
 
I blocked the reference as below, for compilation, but need to refine.
 
==================
diff -Naur linux-2.6.12-rc3-mm3/arch/arm/kernel/setup.c
linux-2.6.12-rc3-mm3-hsc0/arch/arm/kernel/setup.c
--- linux-2.6.12-rc3-mm3/arch/arm/kernel/setup.c 2005-05-06
09:53:10.000000000 +0900
+++ linux-2.6.12-rc3-mm3-hsc0/arch/arm/kernel/setup.c 2005-05-06
20:25:46.000000000 +0900
@@ -429,9 +465,13 @@
  rd_prompt = prompt;
  rd_doload = doload;
 
+ /* FIXME: rd_size became 'static'. (drivers/block/rd.c) */
+#if 0
  if (rd_sz)
   rd_size = rd_sz;
 #endif
+
+#endif
 }
 
 static void __init

---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

