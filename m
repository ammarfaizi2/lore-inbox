Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266428AbRGFLok>; Fri, 6 Jul 2001 07:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266429AbRGFLoa>; Fri, 6 Jul 2001 07:44:30 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:55567 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S266428AbRGFLoY>;
	Fri, 6 Jul 2001 07:44:24 -0400
Date: Fri, 6 Jul 2001 13:44:21 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Juergen Wolf <JuWo@N-Club.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
Message-ID: <20010706134421.B20614@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.30.0107021014230.15054-100000@flash.datafoundation.com> <3B42DEC2.AAB1E65B@N-Club.de> <20010704145752.A29311@se1.cogenit.fr> <3B456D45.FBF10C1A@N-Club.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B456D45.FBF10C1A@N-Club.de>; from JuWo@N-Club.de on Fri, Jul 06, 2001 at 09:48:21AM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Wolf <JuWo@N-Club.de> ecrit :
[...]
> Luckily I got a very helpfull hint from Hans-Christian Armingeon in
> reply to my questions here on the list. The epic100.c from
> http://lrcwww.epfl.ch/~boch/sw/epic100.c.txt fixes the problem in all
> the affected kernel versions. 

Interesting.
-       /* Donald: If this is for Cardbus only then define it so. It *//*HB*/
-       /* breaks the SMC9432BTX Rev 09 boards *//*HB*/
-#ifdef CARDBUS /*HB*/
-       outl(0x12, ioaddr + MIICfg);
-#endif /*HB*/
+       outl(dev->if_port == 1 ? 0x13 : 0x12, ioaddr + MIICfg);

Could you try 2.4.6 with just this modification: ?

--- linux-2.4.6.orig/drivers/net/epic100.c	Wed Jul  4 14:42:13 2001
+++ linux-2.4.6/drivers/net/epic100.c	Fri Jul  6 13:34:17 2001
@@ -681,7 +681,9 @@
 	   required by the details of which bits are reset and the transceiver
 	   wiring on the Ositech CardBus card.
 	*/
+#ifdef 0
 	outl(dev->if_port == 1 ? 0x13 : 0x12, ioaddr + MIICfg);
+#endif
 	if (ep->chip_flags & MII_PWRDWN)
 		outl((inl(ioaddr + NVCTL) & ~0x003C) | 0x4800, ioaddr + NVCTL);
 

-- 
Ueimor
