Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSECXK7>; Fri, 3 May 2002 19:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315745AbSECXK6>; Fri, 3 May 2002 19:10:58 -0400
Received: from precia.cinet.co.jp ([210.166.75.133]:21888 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S315746AbSECXK5>; Fri, 3 May 2002 19:10:57 -0400
Message-ID: <3CD31883.E41E0DFA@cinet.co.jp>
Date: Sat, 04 May 2002 08:08:51 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.79C-ja  [ja/Vine] (X11; U; Linux 2.5.13-pc98smp i686)
X-Accept-Language: ja, en-US, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.13 IDE PIO mode Fix
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this bug in 2.5.10 first. And caused ext2 FS corruption.
We are porting Linux to PC-9801 architecture (made by NEC Japan).
It has PIO ONLY IDE I/F. So please check PIO mode too.
# Our porting status - 2.2.x/2.4.x done and updating. 2.5.x partial.

diff -urN linux-2.5.10/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.10/drivers/ide/ide-taskfile.c    Wed Apr 24 16:15:19 2002
+++ linux/drivers/ide/ide-taskfile.c  Fri Apr 26 15:44:42 2002
@@ -202,7 +202,7 @@
                        ata_write_slow(drive, buffer, wcount);
                else
 #endif
-                       ata_write_16(drive, buffer, wcount<<1);
+                       ata_write_16(drive, buffer, wcount);
        }
 }
