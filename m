Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280923AbRKLTRO>; Mon, 12 Nov 2001 14:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280940AbRKLTRE>; Mon, 12 Nov 2001 14:17:04 -0500
Received: from [195.63.194.11] ([195.63.194.11]:43017 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280923AbRKLTQz>; Mon, 12 Nov 2001 14:16:55 -0500
Message-ID: <3BF02C8A.90EFE860@evision-ventures.com>
Date: Mon, 12 Nov 2001 21:09:46 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just scrolled one line firther down and
noticed the same problem for ep7211_ir_init
as for sa1100_irda_init. Citing form the corrover patch
between pre-patches you can easly see:

+++ linux/net/irda/irda_device.c	Fri Nov  9 14:22:17 2001
++++ linux/net/irda/irda_device.c	Sun Nov 11 10:20:21 2001
 @@ -10,6 +10,7 @@
   * Modified by:   Dag Brattli <dagb@cs.uit.no>
   * 
@@ -140040,27 +184071,33 @@
  
  static void __irda_task_delete(struct irda_task *task);
  
-@@ -124,6 +127,9 @@
+@@ -124,6 +127,12 @@
  #ifdef CONFIG_WINBOND_FIR
  	w83977af_init();
  #endif
 +#ifdef CONFIG_SA1100_FIR
 +	sa1100_irda_init();
 +#endif
++#ifdef CONFIG_SA1100_FIR
++	sa1100_irda_init();
++#endif
  #ifdef CONFIG_NSC_FIR
  	nsc_ircc_init();
  #endif
-@@ -151,6 +157,9 @@
+@@ -151,6 +160,12 @@
  #ifdef CONFIG_OLD_BELKIN
   	old_belkin_init();
  #endif
 +#ifdef CONFIG_EP7211_IR
 + 	ep7211_ir_init();
 +#endif
++#ifdef CONFIG_EP7211_IR
++ 	ep7211_ir_init();
++#endif
  	return 0;
  }
  
-@@ -181,7 +190,10 @@

Supposedly there is still room for -pre5 ;-).
