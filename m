Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUFCPAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUFCPAo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUFCO5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:57:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33676 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264655AbUFCOzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:55:16 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DM: dm-ioctl.c: change an int* to a size_t*
Date: Thu, 3 Jun 2004 09:54:41 -0500
User-Agent: KMail/1.6
Cc: DevMapper <dm-devel@redhat.com>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030954.42045.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-ioctl.c: Use a size_t* instead of an int* in list_version_get_needed().
size_t and int are not the same size on all architectures.

--- diff/drivers/md/dm-ioctl.c	2004-06-03 09:46:39.000000000 -0500
+++ source/drivers/md/dm-ioctl.c	2004-06-03 09:48:40.000000000 -0500
@@ -417,9 +417,9 @@
 	return 0;
 }
 
-static void list_version_get_needed(struct target_type *tt, void *param)
+static void list_version_get_needed(struct target_type *tt, void *needed_param)
 {
-    int *needed = param;
+    size_t *needed = needed_param;
 
     *needed += strlen(tt->name);
     *needed += sizeof(tt->version);
