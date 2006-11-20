Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966641AbWKTULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966641AbWKTULd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966640AbWKTULc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:11:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:12458 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S966641AbWKTULb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:11:31 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
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
Date: Tue, 21 Nov 2006 07:11:33 +1100
Message-Id: <1164053493.8073.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Index: linux/kernel/irq/chip.c
> ===================================================================
> --- linux.orig/kernel/irq/chip.c
> +++ linux/kernel/irq/chip.c
> @@ -238,8 +238,10 @@ static inline void mask_ack_irq(struct i
>  	if (desc->chip->mask_ack)
>  		desc->chip->mask_ack(irq);
>  	else {
> -		desc->chip->mask(irq);
> -		desc->chip->ack(irq);
> +		if (desc->chip->mask)
> +			desc->chip->mask(irq);
> +		if (desc->chip->mask)
> +			desc->chip->ack(irq);

Looks like a typo to me :-)

Cheers,
Ben.


