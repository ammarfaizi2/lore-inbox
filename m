Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbTEEVVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbTEEVVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:21:14 -0400
Received: from [12.47.58.20] ([12.47.58.20]:36822 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261383AbTEEVVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:21:12 -0400
Date: Mon, 5 May 2003 14:30:06 -0700
From: Andrew Morton <akpm@digeo.com>
To: Shane Shrybman <shrybman@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mmX: Drowning in irq 7: nobody cared!
Message-Id: <20030505143006.29c0301a.akpm@digeo.com>
In-Reply-To: <1052141029.2527.27.camel@mars.goatskin.org>
References: <1052141029.2527.27.camel@mars.goatskin.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2003 21:33:38.0710 (UTC) FILETIME=[FDBF7B60:01C3134D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Shrybman <shrybman@sympatico.ca> wrote:
>
> Hi,
> 
> I am getting a lot of these in the logs. This is with the ALSA emu10k1
> driver for a SB live card. This is a x86, UP, KT133 system with preempt
> enabled. The system seems to be running fine.
> 
> handlers:
> [<d8986540>] (gcc2_compiled.+0x0/0x390 [snd_emu10k1])
> irq 7: nobody cared!

Beats me.  Does this fix it up?

diff -puN sound/pci/emu10k1/irq.c~sound-irq-hack sound/pci/emu10k1/irq.c
--- 25/sound/pci/emu10k1/irq.c~sound-irq-hack	Mon May  5 14:28:58 2003
+++ 25-akpm/sound/pci/emu10k1/irq.c	Mon May  5 14:29:17 2003
@@ -147,5 +147,5 @@ irqreturn_t snd_emu10k1_interrupt(int ir
 			outl(IPR_FXDSP, emu->port + IPR);
 		}
 	}
-	return IRQ_RETVAL(handled);
+	return IRQ_HANDLED;
 }

_

