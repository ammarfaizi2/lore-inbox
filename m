Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293380AbSCEB6v>; Mon, 4 Mar 2002 20:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293330AbSCEB6h>; Mon, 4 Mar 2002 20:58:37 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:8336 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S293299AbSCEB6X>; Mon, 4 Mar 2002 20:58:23 -0500
Message-ID: <3C842637.5350F969@didntduck.org>
Date: Mon, 04 Mar 2002 20:58:15 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Better kmalloc effeciency
Content-Type: multipart/mixed;
 boundary="------------395095FD17DE4FC2BB32946C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------395095FD17DE4FC2BB32946C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch adds two intermediate general cache sizes, 96 and 192 bytes. 
On my system this saves about 34k.

size-256              63    180    256    5   12    1
size-192              95    120    192    5    6    1
size-128             213    240    128    8    8    1
size-96             1080   1120     96   28   28    1

-- 

						Brian Gerst
--------------395095FD17DE4FC2BB32946C
Content-Type: text/plain; charset=us-ascii;
 name="kmalloc-sizes-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kmalloc-sizes-1"

diff -urN linux-2.5.6-pre2/mm/slab.c linux/mm/slab.c
--- linux-2.5.6-pre2/mm/slab.c	Mon Feb 11 10:21:49 2002
+++ linux/mm/slab.c	Sun Mar  3 13:59:25 2002
@@ -341,7 +341,9 @@
 	{    32,	NULL, NULL},
 #endif
 	{    64,	NULL, NULL},
+	{    96,	NULL, NULL},
 	{   128,	NULL, NULL},
+	{   192,	NULL, NULL},
 	{   256,	NULL, NULL},
 	{   512,	NULL, NULL},
 	{  1024,	NULL, NULL},
@@ -364,7 +366,9 @@
 	CN("size-32"),
 #endif
 	CN("size-64"),
+	CN("size-96"),
 	CN("size-128"),
+	CN("size-192"),
 	CN("size-256"),
 	CN("size-512"),
 	CN("size-1024"),

--------------395095FD17DE4FC2BB32946C--

