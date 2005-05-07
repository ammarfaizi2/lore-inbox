Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVEGIiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVEGIiL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVEGI0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:26:00 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:39331 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S262797AbVEGIOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:14:03 -0400
Date: Sat, 07 May 2005 17:12:21 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 2/4] nommu - nommu patch for fs/namei.c
To: Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400CRB1JBSY@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3H4FHbppJ1VqRtqIWt34B9xdNw==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu patch against 2.6.12-rc3-mm3, fs/namei.c, do_getname() :
to test the segment if it is KERNEL_DS or not is valid for nommu
architecture. need to skip it if it is nommu.

Signed-off-by : Hyok S. Choi <hyok.choi@samsung.com>

Index: linux-2.6.12-rc3-mm3/fs/namei.c
================================================================
--- linux-2.6.12-rc3-mm3/fs/namei.c	2005-05-06 09:58:39.000000000 +0900
+++ linux-2.6.12-rc3-mm3-hsc0/fs/namei.c	2005-05-06
17:45:01.000000000 +0900
@@ -116,12 +116,14 @@
 	int retval;
 	unsigned long len = PATH_MAX;
 
+#ifdef CONFIG_MMU
 	if (!segment_eq(get_fs(), KERNEL_DS)) {
 		if ((unsigned long) filename >= TASK_SIZE)
 			return -EFAULT;
 		if (TASK_SIZE - (unsigned long) filename < PATH_MAX)
 			len = TASK_SIZE - (unsigned long) filename;
 	}
+#endif
 
 	retval = strncpy_from_user(page, filename, len);
 	if (retval > 0) {

