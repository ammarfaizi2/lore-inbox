Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVB1Dml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVB1Dml (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 22:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVB1Dml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 22:42:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:10396 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261541AbVB1DmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 22:42:13 -0500
Date: Sun, 27 Feb 2005 19:30:53 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>, kkeil@suse.de
Subject: [PATCH] isdn: use __init for ICCVersion()
Message-Id: <20050227193053.565b5ab9.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ICCVersion() is only used by init code & can be marked __init;

Error: ./drivers/isdn/hisax/icc.o .text refers to 000000000000014a R_X86_64_32S      .init.data

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/isdn/hisax/icc.c |    2 +-
 drivers/isdn/hisax/icc.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./drivers/isdn/hisax/icc.h~hisax_icc_sections ./drivers/isdn/hisax/icc.h
--- ./drivers/isdn/hisax/icc.h~hisax_icc_sections	2004-12-24 13:35:24.000000000 -0800
+++ ./drivers/isdn/hisax/icc.h	2005-02-27 19:10:40.578113328 -0800
@@ -65,7 +65,7 @@
 #define ICC_IND_AIL    0xE
 #define ICC_IND_DC     0xF
 
-extern void ICCVersion(struct IsdnCardState *cs, char *s);
+extern void __init ICCVersion(struct IsdnCardState *cs, char *s);
 extern void initicc(struct IsdnCardState *cs);
 extern void icc_interrupt(struct IsdnCardState *cs, u_char val);
 extern void clear_pending_icc_ints(struct IsdnCardState *cs);
diff -Naurp ./drivers/isdn/hisax/icc.c~hisax_icc_sections ./drivers/isdn/hisax/icc.c
--- ./drivers/isdn/hisax/icc.c~hisax_icc_sections	2004-12-24 13:35:50.000000000 -0800
+++ ./drivers/isdn/hisax/icc.c	2005-02-27 19:10:33.756150424 -0800
@@ -27,7 +27,7 @@
 static char *ICCVer[] __initdata =
 {"2070 A1/A3", "2070 B1", "2070 B2/B3", "2070 V2.4"};
 
-void
+void __init
 ICCVersion(struct IsdnCardState *cs, char *s)
 {
 	int val;

---
