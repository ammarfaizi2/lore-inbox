Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283311AbRLILK7>; Sun, 9 Dec 2001 06:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283316AbRLILKs>; Sun, 9 Dec 2001 06:10:48 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:42002 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S283311AbRLILK2>; Sun, 9 Dec 2001 06:10:28 -0500
Date: Sun, 9 Dec 2001 00:04:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Cory Bell <cory.bell@usa.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
        Andrew Grover <andrew.grover@intel.com>,
        John Clemens <john@deater.net>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011209000451.A117@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0112070925280.851-100000@segfault.osdlab.org> <1007760235.10687.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007760235.10687.0.camel@localhost.localdomain>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

So I investigated a little more, and maestro3 soundcard is also hooked
at irq 11 -- with this *very* cruel hack it works for me (at least
playback).


--- clean/drivers/sound/maestro3.c	Thu Oct 11 18:43:30 2001
+++ linux/drivers/sound/maestro3.c	Sat Dec  8 23:39:28 2001
@@ -2685,7 +2683,7 @@
         }
     }
     
-    if(request_irq(card->irq, m3_interrupt, SA_SHIRQ, card_names[card->card_type], card)) {
+    if(request_irq(11 /* card->irq Gross hack */, m3_interrupt, SA_SHIRQ, card_names[card->card_type], card)) {
 
         printk(KERN_ERR PFX "unable to allocate irq %d,\n", card->irq);
 

								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
