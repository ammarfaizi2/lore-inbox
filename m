Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290746AbSA3Xxp>; Wed, 30 Jan 2002 18:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290752AbSA3Xxc>; Wed, 30 Jan 2002 18:53:32 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:65464 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S290746AbSA3XxV>; Wed, 30 Jan 2002 18:53:21 -0500
Message-ID: <3C5887BB.9C57C72C@oracle.com>
Date: Thu, 31 Jan 2002 00:54:35 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix 2.5.3 link for modular PPP and UFS (BKL removal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alongside with moving zconf.h and zutil.h to include/linux, I
 needed to export one more symbol to build modular ppp_deflate.o
 and add linux/smp_lock.h to fs/ufs/file.c as follows:

diff -u --recursive --new-file linux/fs/ufs/file.c linux-as/fs/ufs/file.c
--- linux/fs/ufs/file.c Wed Jan 30 22:56:02 2002
+++ linux-as/fs/ufs/file.c  Thu Jan 31 00:01:03 2002
@@ -35,6 +35,7 @@
 #include <linux/locks.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/smp_lock.h>
 
 /*
  * Make sure the offset never goes beyond the 32-bit mark..
diff -u --recursive --new-file linux/lib/zlib_inflate/inflate_syms.c linux-as/lib/zlib_inflate/inflate_syms.c
--- linux/lib/zlib_inflate/inflate_syms.c   Wed Jan 30 22:56:02 2002
+++ linux-as/lib/zlib_inflate/inflate_syms.c    Thu Jan 31 00:00:40 2002
@@ -12,6 +12,7 @@
 
 EXPORT_SYMBOL(zlib_inflate_workspacesize);
 EXPORT_SYMBOL(zlib_inflate);
+EXPORT_SYMBOL(zlib_inflateIncomp);
 EXPORT_SYMBOL(zlib_inflateInit_);
 EXPORT_SYMBOL(zlib_inflateInit2_);
 EXPORT_SYMBOL(zlib_inflateEnd);
 
--alessandro

 "this machine will, will not communicate
   these thoughts and the strain I am under
  be a world child, form a circle before we all go under"
                         (Radiohead, "Street Spirit [fade out]")
