Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWEaBvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWEaBvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWEaBvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:51:35 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:12153 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751509AbWEaBve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:51:34 -0400
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.17-rc5-git] fix SCSI compile-time divide-by-zero with HZ < 100
Date: Tue, 30 May 2006 18:51:32 -0700
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kaPfExT335wDysf"
Message-Id: <200605301851.32160.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_kaPfExT335wDysf
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is the quickie patch, but someone might care to make
the USER_HZ-coupled value scale for HZ=64 etc.

--Boundary-00=_kaPfExT335wDysf
Content-Type: text/x-diff;
  charset="us-ascii";
  name="scsi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scsi.patch"

This fixes a compiler-reported divide-by-zero when HZ < 100.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -63,7 +63,7 @@ static int scsi_get_bus(request_queue_t 
 
 static int sg_get_timeout(request_queue_t *q)
 {
-	return q->sg_timeout / (HZ / USER_HZ);
+	return q->sg_timeout / max(1,(HZ / USER_HZ));
 }
 
 static int sg_set_timeout(request_queue_t *q, int __user *p)

--Boundary-00=_kaPfExT335wDysf--
