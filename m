Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbTBGRCn>; Fri, 7 Feb 2003 12:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTBGRCn>; Fri, 7 Feb 2003 12:02:43 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:30945 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266091AbTBGRCl>; Fri, 7 Feb 2003 12:02:41 -0500
Date: Fri, 7 Feb 2003 12:21:46 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : drivers/char/sx.c
Message-ID: <Pine.LNX.4.44.0302071219540.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 322, and removes a double 
logical issue. Please review for inclusion.

Regards,
Frank

--- linux/drivers/char/sx.c.old	2003-01-16 21:22:03.000000000 -0500
+++ linux/drivers/char/sx.c	2003-02-07 02:30:33.000000000 -0500
@@ -522,13 +522,13 @@
 
 	func_enter ();
 
-	for (i=0; i < TIMEOUT_1 > 0;i++) 
+	for (i=0; ((TIMEOUT_1 > 0) && (i < TIMEOUT_1));i++) 
 		if ((read_sx_byte (board, offset) & mask) == correctval) {
 			func_exit ();
 			return 1;
 		}
 
-	for (i=0; i < TIMEOUT_2 > 0;i++) {
+	for (i=0; ((TIMEOUT_2 > 0 ) && (i < TIMEOUT_2 > 0));i++) {
 		if ((read_sx_byte (board, offset) & mask) == correctval) {
 			func_exit ();
 			return 1;
@@ -548,13 +548,15 @@
 
 	func_enter ();
 
-	for (i=0; i < TIMEOUT_1 > 0;i++) 
+	for (i=0; ((TIMEOUT_1 > 0) && (i < TIMEOUT_1));i++) 
+		if ((read_sx_byte (board, offset) & mask) == correctval) {
 		if ((read_sx_byte (board, offset) & mask) != badval) {
 			func_exit ();
 			return 1;
 		}
 
-	for (i=0; i < TIMEOUT_2 > 0;i++) {
+	for (i=0; ((TIMEOUT_2 > 0 ) && (i < TIMEOUT_2 > 0));i++) {
+		if ((read_sx_byte (board, offset) & mask) == correctval) {
 		if ((read_sx_byte (board, offset) & mask) != badval) {
 			func_exit ();
 			return 1;

