Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUIMGBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUIMGBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 02:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUIMGBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 02:01:11 -0400
Received: from [212.209.10.220] ([212.209.10.220]:57510 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S266116AbUIMGBJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 02:01:09 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Christoph Hellwig'" <hch@lst.de>,
       =?iso-8859-1?B?Qmr2cm4gV2Vz6W4=?= <bjorn.wesen@axis.com>
Cc: "dev-etrax" <dev-etrax@axis.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] superflous do_softirq invocation in cris do_IRQ()
Date: Mon, 13 Sep 2004 08:00:58 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F54F@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668015F651B@exmail1.se.axis.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great! That was a copy-paste from 2.4. Thanks for caring about CRIS!

/Mikael

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Christoph Hellwig
Sent: Sunday, September 12, 2004 1:20 PM
To: Björn Wesén
Cc: dev-etrax; linux-kernel@vger.kernel.org
Subject: [PATCH] superflous do_softirq invocation in cris do_IRQ()


irq_exit already does softirq processing, no need to do it a second
time.


--- 1.16/arch/cris/kernel/irq.c	2004-08-31 09:57:57 +02:00
+++ edited/arch/cris/kernel/irq.c	2004-09-11 21:21:15 +02:00
@@ -159,9 +159,6 @@
         }
         irq_exit();
 
-	if (softirq_pending(cpu))
-                do_softirq();
-
         /* unmasking and bottom half handling is done magically for us. */
 }
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

