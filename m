Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWJ0XBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWJ0XBa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWJ0XBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:01:30 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:3249 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750830AbWJ0XBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:01:30 -0400
Message-ID: <45428E8D.2030709@oracle.com>
Date: Fri, 27 Oct 2006 15:56:13 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Florin Malita <fmalita@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, proski@gnu.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cate@debian.org,
       gianluca@abinetworks.biz
Subject: Re: [PATCH ??] Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	<1161808227.7615.0.camel@localhost.localdomain>	<20061025205923.828c620d.akpm@osdl.org>	<20061026102630.ad191d21.randy.dunlap@oracle.com>	<1161959020.12281.1.camel@laptopd505.fenrus.org>	<20061027082741.8476024a.randy.dunlap@oracle.com> <20061027112601.dbd83c32.akpm@osdl.org> <45428EAD.6040005@gmail.com>
In-Reply-To: <45428EAD.6040005@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florin Malita wrote:
> Andrew Morton wrote:
>> On Fri, 27 Oct 2006 08:27:41 -0700
>> Randy Dunlap <randy.dunlap@oracle.com> wrote:
>>   
>>> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
>>> ---
>>>  kernel/module.c |    2 +-
>>>  1 files changed, 1 insertion(+), 1 deletion(-)
>>>
>>> --- linux-2619-rc3-pv.orig/kernel/module.c
>>> +++ linux-2619-rc3-pv/kernel/module.c
>>> @@ -1718,7 +1718,7 @@ static struct module *load_module(void _
>>>  	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
>>>  
>>>  	if (strcmp(mod->name, "ndiswrapper") == 0)
>>> -		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
>>> +		add_taint(TAINT_PROPRIETARY_MODULE);
>>>  	if (strcmp(mod->name, "driverloader") == 0)
>>>  		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
>>>  
>>>     
>> Could someone please test this for us?
>>   
> 
> Tested, works (ndiswrapper 1.27).

Thanks.

> Also, since driverloader is not GPL-compatible (MODULE_LICENSE("see
> LICENSE file; Copyright (c)2003-2004 Linuxant inc.")), that check is
> redundant. How about removing it (applies on top of Randy's patch)?

I agree.

> Signed-off-by: Florin Malita <fmalita@gmail.com>
> ---
> 
>  module.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 67009bd..293eb4c 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1719,8 +1719,6 @@ #endif
>  
>  	if (strcmp(mod->name, "ndiswrapper") == 0)
>  		add_taint(TAINT_PROPRIETARY_MODULE);
> -	if (strcmp(mod->name, "driverloader") == 0)
> -		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
>  
>  	/* Set up MODINFO_ATTR fields */
>  	setup_modinfo(mod, sechdrs, infoindex);
> 
> 


-- 
~Randy
