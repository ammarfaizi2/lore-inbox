Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285395AbRLGDbC>; Thu, 6 Dec 2001 22:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285393AbRLGDaw>; Thu, 6 Dec 2001 22:30:52 -0500
Received: from zok.sgi.com ([204.94.215.101]:157 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285389AbRLGDan>;
	Thu, 6 Dec 2001 22:30:43 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] 2.4.17-pre5 oops on floppy type 6
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Dec 2001 14:30:30 +1100
Message-ID: <23771.1007695830@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IBM Thinkpads i1200/1300 with USB floppy (type 6) oops in
drivers/block/floppy.c register_devfs_entries().  Off by one bug when
comparing an index with the array size.

Index: 17-pre5.1/drivers/block/floppy.c
--- 17-pre5.1/drivers/block/floppy.c Fri, 07 Dec 2001 09:35:49 +1100 kaos (linux-2.4/c/c/40_floppy.c 1.2.1.1.1.5 644)
+++ 17-pre5.1(w)/drivers/block/floppy.c Fri, 07 Dec 2001 14:27:37 +1100 kaos (linux-2.4/c/c/40_floppy.c 1.2.1.1.1.5 644)
@@ -3917,7 +3917,7 @@ static void __init register_devfs_entrie
     {NULL, t360, t1200, t3in+5+8, t3in+5, t3in, t3in};
 
     base_minor = (drive < 4) ? drive : (124 + drive);
-    if (UDP->cmos <= NUMBER(default_drive_params)) {
+    if (UDP->cmos < NUMBER(default_drive_params)) {
 	i = 0;
 	do {
 	    char name[16];

