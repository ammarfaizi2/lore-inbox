Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSFJUiP>; Mon, 10 Jun 2002 16:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSFJUgs>; Mon, 10 Jun 2002 16:36:48 -0400
Received: from psmtp1.dnsg.net ([193.168.128.41]:31402 "HELO psmtp1.dnsg.net")
	by vger.kernel.org with SMTP id <S316194AbSFJUgg>;
	Mon, 10 Jun 2002 16:36:36 -0400
Subject: 2.5.21 - autofs_wqt_t.
To: linux-kernel@vger.kernel.org
Date: Tue, 11 Jun 2002 00:30:51 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17HXgZ-0000Yy-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
s390x needs to be added to the autofs_wqt_t type #if since it is one of
the architectures that can execute 32- and 64-bit binaries. Because s390
can live with autofs_wqt_t as int as well we use __s390__ in the #if.
That leads to the question if the whole #if can be removed. Or is there
a 32 bit architecture with a bits per int != bits per long ?

blue skies,
  Martin.

diff -urN linux-2.5.21/include/linux/auto_fs.h linux-2.5.21-s390/include/linux/auto_fs.h
--- linux-2.5.21/include/linux/auto_fs.h	Sun Jun  9 07:26:22 2002
+++ linux-2.5.21-s390/include/linux/auto_fs.h	Tue Jun  4 09:52:06 2002
@@ -45,7 +45,8 @@
  * If so, 32-bit user-space code should be backwards compatible.
  */
 
-#if defined(__sparc__) || defined(__mips__) || defined(__x86_64__) || defined(__powerpc__)
+#if defined(__sparc__) || defined(__mips__) || defined(__x86_64) \
+ || defined(__powerpc__) || defined(__s390__)
 typedef unsigned int autofs_wqt_t;
 #else
 typedef unsigned long autofs_wqt_t;
