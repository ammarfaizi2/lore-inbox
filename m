Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbTEWH6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 03:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTEWH6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 03:58:22 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:5883 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S263914AbTEWH6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 03:58:20 -0400
User-Agent: Microsoft-Entourage/10.1.1.2418
Date: Fri, 23 May 2003 01:11:24 -0700
Subject: Re: [CHECKER] 12 potential leaks in kernel 2.5.69
From: Ted Kremenek <kremenek@cs.stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <BAF325BC.8EEC%kremenek@cs.stanford.edu>
In-Reply-To: <20030522173453.GA9303@bougret.hpl.hp.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks everyone for looking at these errors.

Regards,

Ted

> From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
> Reply-To: jt@hpl.hp.com
> Date: Thu, 22 May 2003 10:34:53 -0700
> To: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Ted Kremenek
> <kremenek@cs.stanford.edu>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Subject: Re: [CHECKER] 12 potential leaks in kernel 2.5.69
> 
> Ted Kremenek wrote :
>> 
>> linux-2.5.69/net/irda/af_irda.c (lines 868-911)
>> [BUG/LEAK, kfree_skb not called on error path]
> 
> Fixed in the mega "memory-leak" patch that I sent to Jeff a
> few days ago :
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105286497718003&w=2
> 
>> linux-2.5.69/drivers/net/wireless/wavelan.c (lines 3012-3041)
>> [BUG/LEAK: skb_padto may return new address.  Note certain what
>>            the exact semantics are, but skb_padto returns possibly
>>            a new skb.  It also may free the skb pointer passed to
>>            it, meaning the calling function may have a dangling reference.]
>> 
>>     printk(KERN_DEBUG "%s: ->wavelan_packet_xmit(0x%X)\n", dev->name,
>>            (unsigned) skb);
>> #endif
>> 
>>     if (skb->len < ETH_ZLEN) {
>> Start --->
>>         skb = skb_padto(skb, ETH_ZLEN);
>> 
>>     ... DELETED 23 lines ...
>> 
>>         printk(KERN_INFO "skb has next\n");
>> #endif
>> 
>>     /* Write packet on the card */
>>     if(wv_packet_write(dev, skb->data, skb->len))
>> Error --->
>>         return 1;    /* We failed */
>> 
>>     dev_kfree_skb(skb);
> 
> This is very yucky. The memory leak is easy to fix, but the
> dandling reference is *very* serious. And I don't see how to fix that
> without either changing the behaviour of skb_padto or the semantic of
> the xmit API.
> Alan, would you mind thinking 2sec about this one ?
> Thanks...
> 
> Jean
> 

