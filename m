Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWCUNaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWCUNaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWCUNaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:30:07 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:25388 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751685AbWCUNaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:30:05 -0500
Subject: [patch] [trivial] remove needless check in fs/read_write.c
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM Deutschland Entwicklung
Date: Tue, 21 Mar 2006 14:30:27 +0100
Message-Id: <1142947827.6243.13.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nr_segs is unsigned long and thus cannot be negative. we checked against 0
few lines before.

signed-off-by: Carsten Otte <cotte@de.ibm.com>
--
diff -ruN linux-2.6.16/fs/read_write.c linux-2.6.16-fix/fs/read_write.c
--- linux-2.6.16/fs/read_write.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-fix/fs/read_write.c	2006-03-21 14:03:17.000000000 +0100
@@ -470,7 +470,7 @@
 	 * verify all the pointers
 	 */
 	ret = -EINVAL;
-	if ((nr_segs > UIO_MAXIOV) || (nr_segs <= 0))
+	if (nr_segs > UIO_MAXIOV)
 		goto out;
 	if (!file->f_op)
 		goto out;

