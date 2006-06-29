Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932743AbWF2HtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbWF2HtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 03:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWF2HtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 03:49:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:63521 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932743AbWF2HtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 03:49:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=DLkmswvyyI6PaDuKqvG1r20wHGpUpgZMDhJHD1VZP0uhX1RDEziPQkNfTFUkOLSPe/szcoKbA4qcX238OshbOnn2K1BET4X9Vvh1JxRsY11KpQ+lfaGCet5R3w/jMSeDrM7ZxIlDXCp7On+SBKUFIq6RlYcHmaFF7N2btOPuQyU=
Message-ID: <44A3870C.20602@innova-card.com>
Date: Thu, 29 Jun 2006 09:53:48 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] bootmem: use pfn/page conversion macros
References: <449FDD02.2090307@innova-card.com>	 <1151344691.10877.44.camel@localhost.localdomain>	 <44A12A85.50303@innova-card.com> <1151436397.24103.27.camel@localhost.localdomain>
In-Reply-To: <1151436397.24103.27.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Tue, 2006-06-27 at 14:54 +0200, Franck Bui-Huu wrote:
>>  static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned
>> long addr,
>>                                      unsigned long size)
>>  {
>> +       unsigned long sidx, eidx;
>>         unsigned long i;
>> -       unsigned long start;
>> +
>>         /*
>>          * round down end of usable mem, partially free pages are
>>          * considered reserved.
>>          */
>> -       unsigned long sidx;
>> -       unsigned long eidx = (addr + size -
>> bdata->node_boot_start)/PAGE_SIZE;
>> -       unsigned long end = (addr + size)/PAGE_SIZE;
>> -
>>         BUG_ON(!size);
>> -       BUG_ON(end > bdata->node_low_pfn);
>> +       BUG_ON(PFN_DOWN(addr + size) > bdata->node_low_pfn);
> 
> In general, I like these kinds of conversions.  But, in this case, I
> think it makes the code harder to read.  Those intermediate variables
> are really nice and I think they make the code much more readable.  
> 
> Do you really prefer:
> 
>        BUG_ON(PFN_DOWN(addr + size) > bdata->node_low_pfn)
> 
> over
> 
>        BUG_ON(end > bdata->node_low_pfn);
> 

It depends of the context. Generally, I think you're right but in that
case I prefer the first case. Why ? because "addr + size" is not a
complex expression, it's quite easy to understand what it means. And
secondly the place where "end" is defined made me think that it was
used all along the function but its use was very punctual.

> Also, these do a bit more than just conversions to using the pfn/page
> macros.  With this much churn, it is more than possible that bugs can
> creep in.  How about a bit more restrictive conversion to the PFN_
> macros, first?
> 
> Oh, and if you're going to chew through it later, feel free to make
> things like sidx into decent variable names. ;)
> 
> Is everybody else OK with this code churn?  It doesn't appear that there
> is too much in -mm pending in this area.
> 

It seems that bootmem allocator doesn't get a lot of interest...
Should we stop this work ? 

		Franck
