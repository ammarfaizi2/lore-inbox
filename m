Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWEaUgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWEaUgZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWEaUgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:36:25 -0400
Received: from fmr17.intel.com ([134.134.136.16]:7829 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964932AbWEaUgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:36:24 -0400
Message-ID: <447DFE29.6040508@linux.intel.com>
Date: Wed, 31 May 2006 22:35:53 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: pauldrynoff@gmail.com, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.17-rc5-mm1 - output of lock validator
References: <20060530195417.e870b305.pauldrynoff@gmail.com>	<20060530132540.a2c98244.akpm@osdl.org>	<20060531181926.51c4f4c5.pauldrynoff@gmail.com>	<1149085739.3114.34.camel@laptopd505.fenrus.org> <20060531102128.eb0020ad.akpm@osdl.org>
In-Reply-To: <20060531102128.eb0020ad.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 31 May 2006 16:28:59 +0200
> Arjan van de Ven <arjan@linux.intel.com> wrote:
> 
>> --- linux-2.6.17-rc5-mm1.5.orig/drivers/net/8390.c
>> +++ linux-2.6.17-rc5-mm1.5/drivers/net/8390.c
>> @@ -299,7 +299,7 @@ static int ei_start_xmit(struct sk_buff 
>>  	 
>>  	disable_irq_nosync(dev->irq);
>>  	
>> -	spin_lock(&ei_local->page_lock);
>> +	spin_lock_irqsave(&ei_local->page_lock, flags);
> 
> Again, notabug - we did disable_irq().

but does disable_irq() work in the light of that irqpoll stuff?

maybe the idiom is no longer really valid...
