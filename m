Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbTLBWW2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 17:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbTLBWW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 17:22:28 -0500
Received: from pixy-gw.netlab.is.tsukuba.ac.jp ([130.158.83.98]:46342 "HELO
	pixy.netlab.is.tsukuba.ac.jp") by vger.kernel.org with SMTP
	id S264418AbTLBWW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 17:22:26 -0500
To: hirofumi@mail.parknet.co.jp
CC: linux-kernel@vger.kernel.org
Subject: FAT fs sanity check patch
X-Mailer: Mew version 1.94.2 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20031203072219F.yokota@netlab.is.tsukuba.ac.jp>
Date: Wed, 03 Dec 2003 07:22:19 +0900
From: Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,

 This patch is required for my 640MB Optical disk.
Because some MS windows based FAT filesystem disk formatter generetes
wrong super bloacks.

-------------------------------------------
--- linux-2.6.0-test10/fs/fat/inode.c.bak	2003-11-24 10:31:52.000000000 +0900
+++ linux-2.6.0-test10/fs/fat/inode.c	2003-11-30 01:12:37.000000000 +0900
@@ -968,6 +968,8 @@
 		/* all is as it should be */
 	} else if (media == 0xf8 && FAT_FIRST_ENT(sb, 0xfe) == first) {
 		/* bad, reported on pc9800 */
+	} else if (media == 0xf0 && FAT_FIRST_ENT(sb, 0xf8) == first) {
+		/* bad, reported with a MO disk */
 	} else if (first == 0) {
 		/* bad, reported with a SmartMedia card */
 	} else {
-------------------------------------------

PS:
 I don't subscribe linux-kernel ML. If you have any questions,
please send mail to my mail address.

---
YOKOTA Hiroshi
E-mail: yokota (at) netlab (dot) is (dot) tsukuba (dot) ac (dot) jp
