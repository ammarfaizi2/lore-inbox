Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTEGV6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTEGV6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:58:06 -0400
Received: from tomts14-srv.bellnexxia.net ([209.226.175.35]:64742 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264300AbTEGV6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:58:04 -0400
Subject: Re: 2.5.68-mmX: Drowning in irq 7: nobody cared!
From: Shane Shrybman <shrybman@sympatico.ca>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030505143006.29c0301a.akpm@digeo.com>
References: <1052141029.2527.27.camel@mars.goatskin.org>
	 <20030505143006.29c0301a.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052345437.8259.6.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 May 2003 18:10:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew & Alan,

Sorry for the delay but the one liner below does seem to have cleared up
the issue. I have been running it for about eight hours, with some sound
on all the time, and haven't seen any 'nobody cared' messages.

BTW: I hand applied this to 2.5.69-mm1. So I am confident that this one
liner did fix it.

On Mon, 2003-05-05 at 17:30, Andrew Morton wrote:
> Shane Shrybman <shrybman@sympatico.ca> wrote:
> >
> > Hi,
> > 
> > I am getting a lot of these in the logs. This is with the ALSA emu10k1
> > driver for a SB live card. This is a x86, UP, KT133 system with preempt
> > enabled. The system seems to be running fine.
> > 
> > handlers:
> > [<d8986540>] (gcc2_compiled.+0x0/0x390 [snd_emu10k1])
> > irq 7: nobody cared!
> 
> Beats me.  Does this fix it up?
> 
> diff -puN sound/pci/emu10k1/irq.c~sound-irq-hack sound/pci/emu10k1/irq.c
> --- 25/sound/pci/emu10k1/irq.c~sound-irq-hack	Mon May  5 14:28:58 2003
> +++ 25-akpm/sound/pci/emu10k1/irq.c	Mon May  5 14:29:17 2003
> @@ -147,5 +147,5 @@ irqreturn_t snd_emu10k1_interrupt(int ir
>  			outl(IPR_FXDSP, emu->port + IPR);
>  		}
>  	}
> -	return IRQ_RETVAL(handled);
> +	return IRQ_HANDLED;
>  }

Regards,

Shane


