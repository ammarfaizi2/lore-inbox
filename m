Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWE3XYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWE3XYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWE3XYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:24:33 -0400
Received: from www.osadl.org ([213.239.205.134]:45517 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964814AbWE3XYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:24:32 -0400
Subject: Re: RT_PREEMPT problem with cascaded irqchip
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Yann.LEPROVOST@wavecom.fr
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Sven-Thorsten Dietrich <sven@mvista.com>
In-Reply-To: <OF1D43115C.4017CA7A-ONC125717E.004F8944-C125717E.0051942C@wavecom.fr>
References: <OF1D43115C.4017CA7A-ONC125717E.004F8944-C125717E.0051942C@wavecom.fr>
Content-Type: text/plain
Date: Wed, 31 May 2006 01:25:17 +0200
Message-Id: <1149031517.20582.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yann,

Can you please use a sane mail client ? There is no point to have the
headers of the previous mail inserted in some fancy way. Also please
answer inline and not on top of the reply.

Thanks.

On Tue, 2006-05-30 at 16:44 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> Well, in fact the issue doesn't come neither from the mask/unmask procedure
> nor from the set_irq calls.
> Correct gpio mask/unmask are called before the gpio_irq_handler.
> 
> However, there is an issue in gpio_irq_handler (specific to generic_irq and
> AT91RM9200, i think) concerning desc->chip->chip_data.
> The following change has to be applied :
> 
>  --    pio = (void __force __iomem *) desc->chip->chip_data;
> ++   pio = (void __force __iomem *) desc->chip_data;

Hmm. Is that part of your code or is it related to code in mainline ?

> Moreover, I think that the call to redirect_hardirq have to be insered in
> gpio_irq_handler but I don't know how to do that.

Why should that be done. The gpio_irq_handler should be called from the
demultiplexing handler, via desc->handler(..). ARM has a conversion
macro - desc_handle_irq() for that.

Anyway, the ARM code in 2.6.16-rtXX is lacking some of the changes we
did in the genirq patchset. Sorry: - ENOTENOUGHINSTANCES

I'm in the progress to update that.
	
	tglx


