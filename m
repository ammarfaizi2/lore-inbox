Return-Path: <linux-kernel-owner+w=401wt.eu-S1751347AbWL2Lca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWL2Lca (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 06:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbWL2Lca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 06:32:30 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:47880 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbWL2Lc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 06:32:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=WNyvOXbgGYQS8+cmOpR2Lxk7m6PRDlbwjMDK+O6QsP7ZMcXK9zvhLfepNQFUfkNKXrx0hN44xgw05Gthkae3XEGBW6HG+CSHeZugxG6u/AIzW4YlaG49tv0Q3pnNCxVL/bhYCaOSqQ4xVVGGhJcBzLk+IVJygihJpQqiChJttaE=
Date: Fri, 29 Dec 2006 03:32:02 -0800
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.20-rc2] fs/jffs2/scan.c: Fix error-path leak
Message-Id: <20061229033202.5f008efc.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Fix error-path leak in function jffs2_scan_medium(), in file fs/jffs2/scan.c

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index e241346..cd9ed6e 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -130,6 +130,8 @@ #endif
 	if (jffs2_sum_active()) {
 		s = kmalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
 		if (!s) {
+			free(flashbuf);
+			flashbuf = NULL;
 			JFFS2_WARNING("Can't allocate memory for summary\n");
 			return -ENOMEM;
 		}
