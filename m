Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTEODTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTEODSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:34 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:3820 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263777AbTEODSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:15 -0400
Date: Thu, 15 May 2003 04:31:03 +0100
Message-Id: <200305150331.h4F3V38B000558@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: sx memleak.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/sx.c linux-2.5/drivers/char/sx.c
--- bk-linus/drivers/char/sx.c	2003-05-14 01:32:18.000000000 +0100
+++ linux-2.5/drivers/char/sx.c	2003-04-26 15:08:04.000000000 +0100
@@ -1739,8 +1739,10 @@ static int sx_fw_ioctl (struct inode *in
 				if (copy_from_user(tmp, (char *)data + i, 
 						   (i + SX_CHUNK_SIZE >
 						    nbytes) ? nbytes - i :
-						   	      SX_CHUNK_SIZE))
+						   	      SX_CHUNK_SIZE)) {
+					kfree (tmp);
 					return -EFAULT;
+				}
 				memcpy_toio    ((char *) (board->base2 + offset + i), tmp, 
 				                (i+SX_CHUNK_SIZE>nbytes)?nbytes-i:SX_CHUNK_SIZE);
 			}
