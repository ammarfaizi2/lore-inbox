Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266079AbRGESAQ>; Thu, 5 Jul 2001 14:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266083AbRGESAG>; Thu, 5 Jul 2001 14:00:06 -0400
Received: from gadolinium.btinternet.com ([194.73.73.111]:24572 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S266079AbRGER7w>; Thu, 5 Jul 2001 13:59:52 -0400
Reply-To: <grant@aerodeck.prestel.co.uk>
From: "Grant Fribbens" <Grant.Fribbens@btinternet.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] RE: 2.4.5-ac14 through to 2.4.6-ac1 fdomain.c initialisation for shared IRQ
Date: Thu, 5 Jul 2001 18:57:23 +0100
Message-ID: <000201c1057b$f8ff4600$0101a8c0@heron1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently had a problem with the fdomain driver initialisation and
have found the problem to be the way in which it requests the irq. Here is
my patch that has so far work ok.

--- linux/drivers/scsi/fdomain.c	Thu Jul  5 13:35:41 2001
+++ fdomain.c	Thu Jun 28 08:08:03 2001
@@ -981,8 +981,8 @@
    } else {
       /* Register the IRQ with the kernel */

-      retcode = request_irq( interrupt_level,
-			     do_fdomain_16x0_intr, 0, "fdomain", NULL);
+      retcode = request_irq( shpnt->irq,
+			     do_fdomain_16x0_intr, SA_SHIRQ, "fdomain", shpnt);

       if (retcode < 0) {
 	 if (retcode == -EINVAL) {

Hope this is correct.

Regards

Grant Fribbens

