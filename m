Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280857AbRKYNJ1>; Sun, 25 Nov 2001 08:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280872AbRKYNJS>; Sun, 25 Nov 2001 08:09:18 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:49927 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280857AbRKYNJH>;
	Sun, 25 Nov 2001 08:09:07 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: rgooch@atnf.csiro.au, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [patch] 2.4.15 drivers/block/floppy.c devfs out by one
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Nov 2001 00:08:50 +1100
Message-ID: <12713.1006693730@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No obvious floppy maintainer to send this to.  Out by one bug in
register_devfs_entries, on machines that return floppy type 7 (IBM
Thinkpad i1200/1300 Model 1161-43M), floppy.o gets an oops while
evaluating table[table_sup[UDP->cmos][i]].

BTW, this breaks RH 7.x and Mandrake 8.x installs on this laptop.

Index: 15.1/drivers/block/floppy.c
--- 15.1/drivers/block/floppy.c Sat, 24 Nov 2001 05:28:08 +1100 kaos (linux-2.5/Y/b/32_floppy.c 1.1 644)
+++ 15.1(w)/drivers/block/floppy.c Sun, 25 Nov 2001 23:58:32 +1100 kaos (linux-2.5/Y/b/32_floppy.c 1.1 644)
@@ -3917,7 +3917,7 @@ static void __init register_devfs_entrie
     {NULL, t360, t1200, t3in+5+8, t3in+5, t3in, t3in};
 
     base_minor = (drive < 4) ? drive : (124 + drive);
-    if (UDP->cmos <= NUMBER(default_drive_params)) {
+    if (UDP->cmos < NUMBER(default_drive_params)) {
 	i = 0;
 	do {
 	    char name[16];

