Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965994AbWKINgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965994AbWKINgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 08:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965995AbWKINgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 08:36:38 -0500
Received: from il.qumranet.com ([62.219.232.206]:49083 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S965994AbWKINgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 08:36:37 -0500
Message-ID: <45532EE3.4000104@qumranet.com>
Date: Thu, 09 Nov 2006 15:36:35 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
References: <20061109110852.A6B712500F7@cleopatra.q> <200611091429.42040.arnd@arndb.de>
In-Reply-To: <200611091429.42040.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Thursday 09 November 2006 12:08, Avi Kivity wrote:
>   
>> Index: linux-2.6/drivers/kvm/kvm_main.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/kvm/kvm_main.c
>> +++ linux-2.6/drivers/kvm/kvm_main.c
>> @@ -369,8 +369,8 @@ static void vmcs_clear(struct vmcs *vmcs
>>         u64 phys_addr = __pa(vmcs);
>>         u8 error;
>>  
>> -       asm volatile ("vmclear %1; setna %0"
>> -                      : "=m"(error) : "m"(phys_addr) : "cc", "memory" );
>> +       asm volatile (ASM_VMX_VMCLEAR_RAX "; setna %0"
>> +                      : "=g"(error) : "a"(&phys_addr) : "cc", "memory" );
>>         if (error)
>>                 printk(KERN_ERR "kvm: vmclear fail: %p/%llx\n",
>>                        vmcs, phys_addr);
>>     
>
> I'm not an expert on inline assembly, but don't you need an extra
> '"m" (phys_addr)' to make sure that gcc actually puts the variable
> on the stack instead of passing a NULL pointer as '"a"(&phys_addr)'?
>
>   

Taking a variable's address should force its contents into memory (like 
calling an uninlined function with &var).


-- 
error compiling committee.c: too many arguments to function

