Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277502AbRJOXGH>; Mon, 15 Oct 2001 19:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277497AbRJOXF4>; Mon, 15 Oct 2001 19:05:56 -0400
Received: from byterapers.com ([195.156.109.210]:48876 "EHLO byterapers.com")
	by vger.kernel.org with ESMTP id <S277502AbRJOXFi>;
	Mon, 15 Oct 2001 19:05:38 -0400
Date: Tue, 16 Oct 2001 02:06:09 +0300 (EEST)
From: <jhakala@byterapers.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] w6692.c/h do not hang up after IRQ LOOP
Message-ID: <Pine.LNX.4.21.0110160155190.10513-100000@byterapers.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have had constant problems with Telewell's ISDN card hanging the
connection and telling about "IRQ LOOP". The only fix for that was
reloading of the hisax-module. Some surfing showed that this seems to be
quite common, but not with W6692-based cards from other manufacturers.

So, this patch does some resetting for card after the Irq loop. For me it
works, but I don't know if this causes some new problems for non-Telewell
cards or for other combinations of hardware or on whatever other cases.


diff -uNr linux-2.4.12.orig/drivers/isdn/hisax/w6692.c
linux-2.4.12/drivers/isdn/hisax/w6692.c
--- linux-2.4.12.orig/drivers/isdn/hisax/w6692.c        Sun Sep 30
22:26:06 2001
+++ linux-2.4.12/drivers/isdn/hisax/w6692.c     Tue Oct 16 01:36:57 2001
@@ -555,7 +555,7 @@
        }
        if (!icnt) {
                printk(KERN_WARNING "W6692 IRQ LOOP\n");
-               cs->writeW6692(cs, W_IMASK, 0xff);
+               initW6692(cs, 2);
        }
 }
 
diff -uNr linux-2.4.12.orig/drivers/isdn/hisax/w6692.h
linux-2.4.12/drivers/isdn/hisax/w6692.h
--- linux-2.4.12.orig/drivers/isdn/hisax/w6692.h        Sun Sep 30
22:26:06 2001
+++ linux-2.4.12/drivers/isdn/hisax/w6692.h     Tue Oct 16 01:36:02 2001
@@ -182,3 +182,6 @@
 /* FIFO thresholds */
 #define W_D_FIFO_THRESH        64
 #define W_B_FIFO_THRESH        64
+
+void __init initW6692(struct IsdnCardState *cs, int part);
+


My first posting, sorry if the patch-format is malformatted in some way
or if it causes your harddrive to crash and your dog to bite you ;)

Jarkko Hakala

