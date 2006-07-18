Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWGRW4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWGRW4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWGRW4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:56:22 -0400
Received: from gw.goop.org ([64.81.55.164]:61623 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932407AbWGRW4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:56:15 -0400
Message-ID: <44BD4B2E.2010805@goop.org>
Date: Tue, 18 Jul 2006 13:57:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 33/33] Add Xen virtual block device driver.
References: <20060718091807.467468000@sous-sol.org>	 <20060718091958.657332000@sous-sol.org> <1153218847.3038.52.camel@laptopd505.fenrus.org>
In-Reply-To: <1153218847.3038.52.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> as first general comment, I think that some of the memory allocation
> GFP_ flags are possibly incorrect; I would expect several places to use
> GFP_NOIO rather than GFP_KERNEL, to avoid recursion/deadlocks
>
>   
>> +static void blkif_recover(struct blkfront_info *info)
>>
>> +	/* Stage 1: Make a safe copy of the shadow state. */
>> +	copy = kmalloc(sizeof(info->shadow), GFP_KERNEL | __GFP_NOFAIL);
>>     
>
> like here..
>
>   
> and __GFP_NOFAIL is usually horrid; is this because error recovery was
> an afterthought, or because it's physically impossible? In addition
> __GFP_NOFAIL in a block device driver is... an interesting way to add
> OOM deadlocks... have the VM guys looked into this yet?
>   

In this particular case, it's only used on the resume path, which I'm 
guessing would not lead to IO recursion.  There doesn't seem to be any 
particular reason for this to be NOFAIL though (but I haven't really 
analyzed it).

There don't appear to be any memory allocations on the IO path; they're 
all in setup code.

    J

