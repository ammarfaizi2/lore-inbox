Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269475AbUI3U07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269475AbUI3U07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269491AbUI3U07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:26:59 -0400
Received: from ariel.xerox.com ([13.13.138.17]:40685 "EHLO
	ariel.useastgw.xerox.com") by vger.kernel.org with ESMTP
	id S269475AbUI3U04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:26:56 -0400
Message-Id: <200409302022.i8UKMeD02328@santa.eng.mc.xerox.com>
To: linux-kernel@vger.kernel.org
cc: leisner@rochester.rr.com
Subject: Problem initializing PCI boards where IRQ has to be guessed
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2308.1096575730.1@santa>
Date: Thu, 30 Sep 2004 16:22:40 -0400
From: "Marty Leisner" <mleisner@eng.mc.xerox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this problem in 2.4.27...the same code is in 2.6.8.1

If the bios doesn't assign an interrupt, the guessing algorithm is 
able to work only in a very special case (when the mask is one bit).

In 2.4.27 (I have lxr.linux.no for 2.4.26, its the same in
2.6.8.1)

933         if (!irq) {
934                 DBG(" ... failed\n");
935                 if (newirq && mask == (1 << newirq)) {
936                         msg = "Guessed";
937                         irq = newirq;
938                 } else
939                         return 0;

In 2.4.27 I have:
@@ -942,7 +939,8 @@
 
        if (!irq) {
                DBG(" ... failed\n");
- -               if (newirq && mask == (1 << newirq)) {
+               if (newirq && (mask & (1 << newirq))) {
+                       /* newirq is a routable interrupt */
                        msg = "Guessed";
                        irq = newirq;
                } else



marty    mleisner@eng.mc.xerox.com
Don't  confuse education with schooling.
	Milton Friedman to Yogi Berra


