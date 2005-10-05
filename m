Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbVJEMnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbVJEMnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVJEMm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:42:59 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:36491 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S965154AbVJEMm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:42:59 -0400
Message-ID: <4343CA4F.8030003@cosmosbay.com>
Date: Wed, 05 Oct 2005 14:42:55 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: devesh sharma <devesh28@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [NUMA x86_64] problem accessing global Node List pgdat_list
References: <309a667c0510042240y1dcc75c4l83abc7fe430e4f05@mail.gmail.com>
In-Reply-To: <309a667c0510042240y1dcc75c4l83abc7fe430e4f05@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 05 Oct 2005 14:42:56 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Devesh

devesh sharma a écrit :
> Hi all,
> On an dual opteron machine and 2.6.9 kernel, I am accessing the global
> node list pgdat_list but I am not getting the desired results
> 
> #include<linux/module.h>
> #include<linux/config.h>
> #include<linux/kernel.h>
> #include<linux/mmzone.h>
> 
> struct pglist_data *pgdat_list ;

What are you doing here ? You declare a local variable on this module.
You should instead write :

extern struct pglist_data *pgdat_list ;
(But it seems already declared in mmzone.h)

But pgdat_list is an exported symbol of linux kernel : a module cannot access it.

So I suspect you will have to add in mm/page_alloc.c  (and recompile your kernel)

EXPORT_SYMBOL(pgdat_list);


And please use a recent kernel (2.6.13 at least) or few people will answer you.


> 
> int init_module( void )
> {
> 
>   pg_data_t *pg_dat ;
> 
>   printk ("<1>****Module initialized to retrive the information of
> pgdat_list list in the Kernel****\n" ) ;
> 
> 
>   for_each_pgdat(pg_dat)
>   {
>     printk ("<1>The number of zones on this node are %x\n", pg_dat ->
> nr_zones ) ;
> 
>     printk ("<1>The Node Id of this node is %d\n", pg_dat -> node_id ) ;
> 
>   }
> 
>   return 0 ;
> }
> 
> void cleanup_module ( void )
> {
>     printk ("<1>********Module Exiting***********\n" ) ;
> }
> 
> MODULE_LICENSE("GPL") ;
> 
> How I can access this list any body tell me the solution.

Eric


