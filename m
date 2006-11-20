Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966334AbWKTSUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966334AbWKTSUc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966314AbWKTSUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:20:31 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:61799 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S966334AbWKTSUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:20:30 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061120175502.GA12733@elte.hu>
References: <1163966437.5826.99.camel@localhost.localdomain>
	 <20061119200650.GA22949@elte.hu>
	 <1163967590.5826.104.camel@localhost.localdomain>
	 <20061119202348.GA27649@elte.hu>
	 <1163985380.5826.139.camel@localhost.localdomain>
	 <20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com>
	 <20061120165621.GA1504@elte.hu> <4561DFE1.4020708@ru.mvista.com>
	 <20061120172642.GA8683@elte.hu>  <20061120175502.GA12733@elte.hu>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 10:20:18 -0800
Message-Id: <1164046818.3028.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 18:55 +0100, Ingo Molnar wrote:
> Index: linux/kernel/irq/chip.c
> ===================================================================
> --- linux.orig/kernel/irq/chip.c
> +++ linux/kernel/irq/chip.c
> @@ -238,8 +238,10 @@ static inline void mask_ack_irq(struct i
>         if (desc->chip->mask_ack)
>                 desc->chip->mask_ack(irq);
>         else {
> -               desc->chip->mask(irq);
> -               desc->chip->ack(irq);
> +               if (desc->chip->mask)
> +                       desc->chip->mask(irq);
> +               if (desc->chip->mask)
> +                       desc->chip->ack(irq);
>         }
>  } 


Did you mean to check ->mask both times here?

Daniel

