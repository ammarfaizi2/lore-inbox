Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312418AbSC3Jfi>; Sat, 30 Mar 2002 04:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312419AbSC3Jf2>; Sat, 30 Mar 2002 04:35:28 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:1409 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S312418AbSC3JfP>;
	Sat, 30 Mar 2002 04:35:15 -0500
Message-ID: <001d01c1d7ce$34f830c0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Andrew Morton" <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>,
        "Marcelo Tosatti" <marcelo@conectiva.com.br>
Subject: Re: [patch] block/IDE/interrupt lockup
Date: Sat, 30 Mar 2002 10:35:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	spin_unlock_irq(&io_request_lock);
> +	spin_unlock_irqrestore(&io_request_lock, flags);
>  	rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);

Great patch.
kmem_cache_alloc with SLAB_KERNEL can sleep, i.e. you've just converted
an obvious bug into a rare, difficult to find bug. What about trying to
fix it?

I agree that this won't happen during boot, but what about a hotplug PCI
ide controller?

--
    Manfred

