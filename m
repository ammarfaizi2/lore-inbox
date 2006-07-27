Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751920AbWG0SQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWG0SQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWG0SQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:16:31 -0400
Received: from unn-206.superhosting.cz ([82.208.4.206]:65246 "EHLO
	mail.aiken.cz") by vger.kernel.org with ESMTP id S1751920AbWG0SQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:16:27 -0400
Message-ID: <44C902F8.7000109@kernel-api.org>
Date: Thu, 27 Jul 2006 20:16:24 +0200
From: Lukas Jelinek <info@kernel-api.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; cs-CZ; rv:1.7.12) Gecko/20050915
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: request_irq() return value
References: <200607271950.03370.m.kozlowski@tuxland.pl>
In-Reply-To: <200607271950.03370.m.kozlowski@tuxland.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Hello,
> 
> 	I'm looking at the source code of different drivers and wondering about 
> request_irq() return value. It is used mostly in 'open' routine of struct 
> net_device. If request_irq() fails some drivers return -EAGAIN, some -EBUSY 
> and some the return value of request_irq(). Is this intentional? Sample 
> drivers code:
> 

I think the most suitable value for this case is -EBUSY. The reason is
that this type of failure is usually permanent and unrecoverable. But
other people may have a different opinion and thus they prefer -EAGAIN
(which is intended for temporary failures) or something else.

Lukas


> 8139cp.c:
> static int cp_open (struct net_device *dev) {
>         ...
>         rc = request_irq(dev->irq, cp_interrupt, SA_SHIRQ, dev->name, dev);
>         if (rc)
>                 goto err_out_hw;
>         ...
> err_out_hw:
>         ...
>         return rc;
> }
> 
> 3c359.c:
> static int xl_open(struct net_device *dev){
>         ...
>         if(request_irq(dev->irq, &xl_interrupt, SA_SHIRQ , "3c359", dev)) {
>                 return -EAGAIN;
>         }
>         ...
> }
> 
> Besides request_irq() is arch dependent so depending on arch it has different 
> set of possible return values. So ... does the return value matter or I 
> misunderstood something here?
> 
> Regards,
> 
> 	Mariusz
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

