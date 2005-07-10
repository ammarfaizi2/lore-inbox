Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVGJTCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVGJTCx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVGJTCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:02:53 -0400
Received: from isilmar.linta.de ([213.239.214.66]:12471 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261157AbVGJTCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:02:39 -0400
Date: Sun, 10 Jul 2005 21:01:28 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-pcmcia@lists.infradead.org
Subject: PCMCIA stack reduction patch [Was: Re: Realtime Preemption, 2.6.12, Beginners Guide?]
Message-ID: <20050710190128.GI8758@dominikbrodowski.de>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjanv@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-pcmcia@lists.infradead.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu> <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709124105.GB4665@elte.hu> <20050709132657.GA6088@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709132657.GA6088@elte.hu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 09, 2005 at 03:26:57PM +0200, Ingo Molnar wrote:
> 
> > (gdb) ####################################
> > (gdb) # c02a0a26, stack size:  416 bytes #
> > (gdb) ####################################
> > (gdb) 0xc02a0a26 is in pcmcia_device_query (drivers/pcmcia/ds.c:436).
> 
> ----
> this patch reduces the stack footprint of pcmcia_device_query() from 416 
> bytes to 36 bytes. (patch only build-tested)

Applied and tested, but without the final hunk.

> @@ -856,7 +868,9 @@ static int bind_request(struct pcmcia_bu
>  rescan:
>  	p_dev->cardmgr = p_drv;
>  
> -	pcmcia_device_query(p_dev);
> +	ret = pcmcia_device_query(p_dev);
> +	if (ret)
> +		goto err_put_module;
>  
>  	/*
>  	 * Prevent this racing with a card insertion.


We don't check the return value here for a reason.

Thanks,

	Dominik
