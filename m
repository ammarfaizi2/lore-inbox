Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129562AbQK1RSb>; Tue, 28 Nov 2000 12:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129520AbQK1RSV>; Tue, 28 Nov 2000 12:18:21 -0500
Received: from www.dacome.co.kr ([210.182.20.2]:47877 "EHLO www.dacome.co.kr")
        by vger.kernel.org with ESMTP id <S129562AbQK1RSG>;
        Tue, 28 Nov 2000 12:18:06 -0500
Date: Wed, 29 Nov 2000 01:51:06 +0900
From: Young-Ho Cha <kernel@www.dacome.co.kr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] nls support in isofs
Message-ID: <20001129015106.A21407@www.dacome.co.kr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii

Hi. kernel hackers.


I found a problem that isofs nls did not work in kernel 2.4.0-test*.

so I compared with 2.2 series, and found that isofs default nls was written hard coding with iso8859.

plz apply follwing patch.

Regards,
--
Young-Ho, Cha <ganadist@chollian.net>

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="isofs.diff"

--- linux/fs/inode.c.orig	Tue Nov 28 13:22:25 2000
+++ linux/fs/inode.c	Tue Nov 28 13:22:45 2000
@@ -737,7 +737,7 @@
 
 #ifdef CONFIG_JOLIET
 	if (joliet_level && opt.utf8 == 0) {
-		char * p = opt.iocharset ? opt.iocharset : "iso8859-1";
+		char * p = opt.iocharset ? opt.iocharset : CONFIG_NLS_DEFAULT;
 		s->u.isofs_sb.s_nls_iocharset = load_nls(p);
 		if (! s->u.isofs_sb.s_nls_iocharset) {
 			/* Fail only if explicit charset specified */

--AqsLC8rIMeq19msA--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
