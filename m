Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWEUAEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWEUAEH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 20:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWEUAEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 20:04:07 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:38381 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932231AbWEUAEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 20:04:06 -0400
Message-ID: <446FAEE3.6060003@cmu.edu>
Date: Sat, 20 May 2006 20:05:55 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: cannot load *any* modules with 2.4 kernel
References: <446F3F6A.9060004@cmu.edu> <20060520162529.GT11191@w.ods.org>
In-Reply-To: <20060520162529.GT11191@w.ods.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, so heres what I did.  I downloaded modutils version 2.4.27 and
extracted it to /usr/local/modutils

Then in my 2.4.32 kernel's Makefile, I changed the DEPMOD variable to
point to /usr/local/modutils/sbin/depmod

Then I build the kernel with:
make dep && make bzImage modules modules_install && make install

So then my initrd gets generated, I reboot to the 2.4.32 kernel, and
thats where i'm at now.

So then for instance I goto /lib/modules/2.4.32/net and do:
/usr/local/modutils/sbin/insmod 8390.o

and I see all those unresolved symbols

So maybe now that you have more info, we can figure something out.

Thanks!
George


Willy Tarreau wrote:
> Hi,
> 
> On Sat, May 20, 2006 at 12:10:18PM -0400, George Nychis wrote:
>> Hi,
>>
>> I boot two kernels, a 2.6.9 kernel and just recently built a 2.4.32 kernel
>>
>> In the 2.4.32 kernel I have =y for:
>> CONFIG_MODULES
>> CONFIG_MODVERSIONS
>> CONFIG_KMOD
>>
>> I then build my kernel, with some modules, install the modules, and boot
>> my 2.4.32 kernel successfully
>>
>> when i do lsmod, it is completely empty, no modules are loaded.  This
>> only happens for my 2.4.32 kernel though, modules load fine in 2.6.9
> 
> What's your modutils version ?  -> lsmod -V
> You must use modutils and not modules-utils under 2.4, and I suspect
> that if you jumped back from 2.6 to 2.4, you might not have the right
> package. Note that modules-utils contains a wrapper to call the right
> modutils when you are running 2.4, so you should really do lsmod -V
> when running 2.4.
> 
>> If i try to manually insert with insmod or modprobe, i get unresolved
>> external symbols for things that I am sure should be resolved... for
>> example, i get unresolved external symbol for printk
>>
>> I'll give some other common unresolved smybols and maybe someone can
>> point me in the right direction of what else i need to specify to you
>> guys so that you can help me out further.
>>
>> prinkt
>> add_timer
>> dev_mc_add
>> CardServices
>> kfree
>> cpu_raise_softirq
>> free_irq
>> kmalloc
>>
>> Thanks!
>> George
> 
> Regards,
> Willy
> 
> 
