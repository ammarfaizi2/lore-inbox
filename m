Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSHAWmE>; Thu, 1 Aug 2002 18:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSHAWmE>; Thu, 1 Aug 2002 18:42:04 -0400
Received: from flrtn-5-m1-95.vnnyca.adelphia.net ([24.55.70.95]:24449 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S317141AbSHAWmD>;
	Thu, 1 Aug 2002 18:42:03 -0400
Message-ID: <3D49BA06.1040606@tmsusa.com>
Date: Thu, 01 Aug 2002 15:45:26 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] es1371 synchronize_irq()
References: <20020801223827.GA11949@vana.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many of us use es1371/OSS - but are on 2.4 for now...

Joe

Petr Vandrovec wrote:

>Hello Linus,
>   nobody else is apparently using OSS's es1371...
>
>Patch below converts synchronize_irq() calls in es1371 to the new
>format.
>					Petr Vandrovec
>					vandrove@vc.cvut.cz
>
>diff -urdN linux/sound/oss/es1371.c linux/sound/oss/es1371.c
>--- linux/sound/oss/es1371.c	2002-07-31 10:48:09.000000000 +0000
>+++ linux/sound/oss/es1371.c	2002-07-31 10:54:57.000000000 +0000
>@@ -1597,12 +1597,12 @@
>         case SNDCTL_DSP_RESET:
> 		if (file->f_mode & FMODE_WRITE) {
> 			stop_dac2(s);
>-			synchronize_irq();
>+			synchronize_irq(s->irq);
> 			s->dma_dac2.swptr = s->dma_dac2.hwptr = s->dma_dac2.count = s->dma_dac2.total_bytes = 0;
> 		}
> 		if (file->f_mode & FMODE_READ) {
> 			stop_adc(s);
>-			synchronize_irq();
>+			synchronize_irq(s->irq);
> 			s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
> 		}
> 		return 0;
>@@ -2162,7 +2162,7 @@
> 		
>         case SNDCTL_DSP_RESET:
> 		stop_dac1(s);
>-		synchronize_irq();
>+		synchronize_irq(s->irq);
> 		s->dma_dac1.swptr = s->dma_dac1.hwptr = s->dma_dac1.count = s->dma_dac1.total_bytes = 0;
> 		return 0;
> 
>@@ -3001,7 +3001,7 @@
> #endif /* ES1371_DEBUG */
> 	outl(0, s->io+ES1371_REG_CONTROL); /* switch everything off */
> 	outl(0, s->io+ES1371_REG_SERIAL_CONTROL); /* clear serial interrupts */
>-	synchronize_irq();
>+	synchronize_irq(s->irq);
> 	free_irq(s->irq, s);
> 	if (s->gameport.io) {
> 		gameport_unregister_port(&s->gameport);
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

