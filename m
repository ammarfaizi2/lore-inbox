Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbTDWPQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTDWPQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:16:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40136 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id S264073AbTDWPQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:16:55 -0400
Date: Wed, 23 Apr 2003 11:28:58 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH]  Undefined symbol sync_dquots_dev() in quota.c
To: linux-kernel@vger.kernel.org
Message-id: <3EA6B13A.4000408@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_njrsjQY3BZzzMJbm2U7uiA)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_njrsjQY3BZzzMJbm2U7uiA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Folks,

   the following patch fixes a compile error under 2.4.21-rc1-ac1. 
 sync_dev_dquots() is undefined if CONFIG_QUOTA is not set.

Stephane Ouellette.


--Boundary_(ID_njrsjQY3BZzzMJbm2U7uiA)
Content-type: text/plain; name=quota.c.patch; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=quota.c.patch

--- linux-2.4.21-rc1-ac1-orig/fs/quota.c	Wed Apr 23 11:22:49 2003
+++ linux-2.4.21-rc1-ac1-fixed/fs/quota.c	Wed Apr 23 11:22:12 2003
@@ -197,7 +197,9 @@
 		case Q_SYNC:
 			if (sb)
 				return sb->s_qcop->quota_sync(sb, type);
+#ifdef CONFIG_QUOTA
 			sync_dquots_dev(NODEV, type);
+#endif
 			return 0;
 
 		case Q_XQUOTAON:
@@ -525,7 +527,9 @@
 		case Q_COMP_SYNC:
 			if (sb)
 				return sb->s_qcop->quota_sync(sb, type);
+#ifdef CONFIG_QUOTA
 			sync_dquots_dev(NODEV, type);
+#endif
 			return 0;
 #ifdef CONFIG_QIFACE_V1
 		case Q_V1_RSQUASH: {

--Boundary_(ID_njrsjQY3BZzzMJbm2U7uiA)--
