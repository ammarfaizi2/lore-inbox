Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLPVsV>; Sat, 16 Dec 2000 16:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLPVsK>; Sat, 16 Dec 2000 16:48:10 -0500
Received: from BAdial25.eurotel.sk ([194.154.226.88]:8708 "EHLO
	trillian.eunet.sk") by vger.kernel.org with ESMTP
	id <S129391AbQLPVsA>; Sat, 16 Dec 2000 16:48:00 -0500
From: Stanislav Meduna <stano@trillian.eunet.sk>
Message-Id: <200012162116.WAA02749@trillian.eunet.sk>
Subject: ntfs trivial patch
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2000 22:16:02 +0100 (CET)
Cc: torvalds@transmeta.com, aia21@cus.cam.ac.uk
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it is impossible to load a ntfs module in 2.4.0-test{11,12} -
the symbol ntdebug is not defined. The symbol is only defined
when building with DEBUG, but it is always declared as module
parameter. Following trivial patch fixes it.

Sorry if this was already posted - I don't read the whole
l-k, grep for ntfs|ntdebug in subjects returned nothing
and http://www.atnf.csiro.au/~rgooch/linux/docs/kernel-newsflash.html
seems to be a bit behind the actual kernels.

diff -uN fs/ntfs/fs.c.orig fs/ntfs/fs.c
--- fs/ntfs/fs.c.orig   Sat Dec 16 16:12:26 2000
+++ fs/ntfs/fs.c        Sat Dec 16 22:02:56 2000
@@ -963,8 +963,10 @@
 EXPORT_NO_SYMBOLS;
 MODULE_AUTHOR("Martin von Löwis");
 MODULE_DESCRIPTION("NTFS driver");
+#ifdef DEBUG
 MODULE_PARM(ntdebug, "i");
 MODULE_PARM_DESC(ntdebug, "Debug level");
+#endif
 
 module_init(init_ntfs_fs)
 module_exit(exit_ntfs_fs)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
