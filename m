Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSLIJA6>; Mon, 9 Dec 2002 04:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264733AbSLIJA1>; Mon, 9 Dec 2002 04:00:27 -0500
Received: from redrock.inria.fr ([138.96.248.51]:51916 "HELO redrock.inria.fr")
	by vger.kernel.org with SMTP id <S264990AbSLII7c>;
	Mon, 9 Dec 2002 03:59:32 -0500
Date: Mon, 9 Dec 2002 09:55:04 +0100
From: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Manuel.Serrano@sophia.inria.fr
Subject: Re: Fw: Troubles with Sony PCG-C1MHP (crusoe based and ALIM 1533 drivers)
Message-Id: <20021209095504.0c5e1062.Manuel.Serrano@sophia.inria.fr>
References: <20021120094121.7b6c7d34.Manuel.Serrano@sophia.inria.fr>
	<1037800851.3241.10.camel@irongate.swansea.linux.org.uk>
Organization: Inria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

I have tried linux-2.4.20-ac1 on my Sony Vaoi (PCG-C1MHP, a computer equipped
with a Crusoe and an ALIM 1533 ide driver). Your patches are not sufficient
enough to make the machine booting with the non-generic IDE drivers. I have
had to apply a patch sent by Ogawa Hirofumi (I don't know exactly who's
the author of this patch). Please find it enclosed at the end of this mail. 
With this setting the machine boot up correctly and the DMA are enabled.

Sincerely,

-- 
Manuel

*** ide-probe-2.4.20-ac1.c Mon Dec  9 09:52:12 2002
--- ide-probe-2.4.20-ac1-ms.c      Mon Dec  9 09:55:35 2002
***************
*** 635,638 ****
--- 635,643 ----
         * we'll install our IRQ driver much later...
         */
+       /* OGAWA Hirofumi --> */
+       if (hwif->irq == 255)
+               hwif->irq = 0;
+       irqd = hwif->irq;
+       /* OGAWA Hirofumi <-- */
        irqd = hwif->irq;
        if (irqd)
