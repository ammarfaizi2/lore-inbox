Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVB1Mzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVB1Mzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 07:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVB1Mzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 07:55:50 -0500
Received: from imag.imag.fr ([129.88.30.1]:42953 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261580AbVB1Mzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 07:55:32 -0500
Message-ID: <1109595328.422314c031b5f@webmail.imag.fr>
Date: Mon, 28 Feb 2005 13:55:28 +0100
From: colbuse@ensisun.imag.fr
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: [patch 2/2] drivers/chat/vt.c: remove unnecessary code
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 193.49.124.107
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 28 Feb 2005 13:55:30 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid changing the state of the console two times in some cases.


Signed-off-by: Emmanuel Colbus <emmanuel.colbus@ensimag.imag.fr>


--- old/drivers/char/vt.c       2004-12-24 22:35:25.000000000 +0100
+++ new/drivers/char/vt.c       2005-02-28 12:56:46.154311486 +0100
@@ -1571,7 +1571,6 @@
        }
        switch(vc_state) {
        case ESesc:
-               vc_state = ESnormal;
                switch (c) {
                case '[':
                        vc_state = ESsquare;
@@ -1585,25 +1584,25 @@
                case 'E':
                        cr(currcons);
                        lf(currcons);
-                       return;
+                       break;
                case 'M':
                        ri(currcons);
-                       return;
+                       break;
                case 'D':
                        lf(currcons);
-                       return;
+                       break;
                case 'H':
                        tab_stop[x >> 5] |= (1 << (x & 31));
-                       return;
+                       break;
                case 'Z':
                        respond_ID(tty);
-                       return;
+                       break;
                case '7':
                        save_cur(currcons);
-                       return;
+                       break;
                case '8':
                        restore_cur(currcons);
-                       return;
+                       break;
                case '(':
                        vc_state = ESsetG0;
                        return;
@@ -1615,14 +1614,15 @@
                        return;
                case 'c':
                        reset_terminal(currcons,1);
-                       return;
+                       break;
                case '>':  /* Numeric keypad */
                        clr_kbd(kbdapplic);
-                       return;
+                       break;
                case '=':  /* Appl. keypad */
                        set_kbd(kbdapplic);
-                       return;
+                       /* Here, we don't need any break; */
                }
+               vc_state = ESnormal;
                return;
        case ESnonstd:
                if (c=='P') {   /* palette escape sequence */



--
Emmanuel Colbus
Club GNU/Linux
ENSIMAG - departement telecoms


-------------------------------------------------
envoyé via Webmail/IMAG !

