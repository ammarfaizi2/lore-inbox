Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVCVVzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVCVVzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVCVVyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:54:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54741 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262072AbVCVVxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:53:34 -0500
Message-ID: <424093C8.400@pobox.com>
Date: Tue, 22 Mar 2005 16:53:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pawe__ Sikora <pluto@pld-linux.org>, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>, Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH][alpha] "pm_power_off" [drivers/char/ipmi/ipmi_poweroff.ko]
 undefined!
References: <200503152335.48995.pluto@pld-linux.org> <20050322130657.7502418d.akpm@osdl.org>
In-Reply-To: <20050322130657.7502418d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Pawe__ Sikora <pluto@pld-linux.org> wrote:
> 
>>Fix for modpost warning:
>> "pm_power_off" [drivers/char/ipmi/ipmi_poweroff.ko] undefined!
>>
>> --- linux-2.6.11.3/arch/alpha/kernel/alpha_ksyms.c.orig	2005-03-13 07:44:05.000000000 +0100
>> +++ linux-2.6.11.3/arch/alpha/kernel/alpha_ksyms.c	2005-03-15 23:20:00.405832368 +0100
>> @@ -67,6 +67,9 @@
>>  EXPORT_SYMBOL(alpha_using_srm);
>>  #endif /* CONFIG_ALPHA_GENERIC */
>>  
>> +#include <linux/pm.h>
>> +EXPORT_SYMBOL(pm_power_off);
>> +
>>  /* platform dependent support */
>>  EXPORT_SYMBOL(strcat);
>>  EXPORT_SYMBOL(strcmp);
>> --- linux-2.6.11.3/arch/alpha/kernel/process.c.orig	2005-03-13 07:44:40.000000000 +0100
>> +++ linux-2.6.11.3/arch/alpha/kernel/process.c	2005-03-15 23:28:15.687538104 +0100
>> @@ -183,6 +183,8 @@
>>  
>>  EXPORT_SYMBOL(machine_power_off);
>>  
>> +void (*pm_power_off)(void) = machine_power_off;
>> +
>>  /* Used by sysrq-p, among others.  I don't believe r9-r15 are ever
>>     saved in the context it's used.  */
> 
> 
> There doesn't seem to be a lot of point in defining it and not using it.
> 
> Perhaps IPMI is making untoward assumptions about the architecture's power
> management?  Should we instead be disabling CONFIG_IPMI_POWEROFF on alpha
> (and others?)

Although I suppose its possible that some alpha machines have SMI 
hardware, I don't think I've ever seen ACPI or IPMI on any alpha.

	Jeff



