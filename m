Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293222AbSCFE5f>; Tue, 5 Mar 2002 23:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293223AbSCFE5Y>; Tue, 5 Mar 2002 23:57:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30736 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293222AbSCFE5J>;
	Tue, 5 Mar 2002 23:57:09 -0500
Message-ID: <3C85A1BA.512E0324@mandrakesoft.com>
Date: Tue, 05 Mar 2002 23:57:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre2]
In-Reply-To: <20020305163840.B1525@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need the silly spinlock wrappers in 2.4 either.....

> 
> + * Wrapper for disabling interrupts.
> + * (note : inline, so optimised away)
> + */
> +static inline void
> +wv_splhi(net_local *           lp,
> +        unsigned long *        pflags)
> +{
> +  spin_lock_irqsave(&lp->spinlock, *pflags);
> +  /* Note : above does the cli(); itself */
> +}
> +
> +/*------------------------------------------------------------------*/
> +/*
> + * Wrapper for re-enabling interrupts.
> + */
> +static inline void
> +wv_splx(net_local *            lp,
> +       unsigned long *         pflags)
> +{
> +  spin_unlock_irqrestore(&lp->spinlock, *pflags);
> +
> +  /* Note : enabling interrupts on the hardware is done in wv_ru_start()
> +   * via : outb(OP1_INT_ENABLE, LCCR(base));
> +   */
> +}
> +

-- 
Jeff Garzik      | Usenet Rule #2 (John Gilmore): "The Net interprets
Building 1024    | censorship as damage and routes around it."
MandrakeSoft     |
