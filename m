Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424119AbWKIQvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424119AbWKIQvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424117AbWKIQvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:51:55 -0500
Received: from il.qumranet.com ([62.219.232.206]:17111 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1424119AbWKIQvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:51:54 -0500
Message-ID: <45535CA6.4000206@qumranet.com>
Date: Thu, 09 Nov 2006 18:51:50 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
References: <20061109110852.A6B712500F7@cleopatra.q> <200611091542.31101.arnd@arndb.de> <455340B8.2080206@qumranet.com> <200611091737.48801.arnd@arndb.de>
In-Reply-To: <200611091737.48801.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Thursday 09 November 2006 15:52, Avi Kivity wrote:
>   
>> Wouldn't that make inline assembly useless?  Suppose the contents is 
>> itself a pointer.  What about the pointed-to contents?
>>
>> e.g.
>>
>>     int x = 3;
>>     int *y = &x;
>>     int z;
>>
>>     asm ("mov %1, %%rax; movl (%%rax), %0" : "=r"(z) : "g"(y) : "rax");
>>     assert(z == 3);
>>     
>
> Same here, you need to tell gcc what is really accessed, like 
>
> asm ("mov %1, %%rax; movl (%%rax), %0" : "=r"(z) : "g"(y), "m"(*y) : "rax");
>
> I know that the s390 kernel developers have hit that problem
> frequently with inline assemblies. It may be that it's harder
> to hit on x86, because there are fewer registers available and
> data therefore tends to spill to the stack.
>   

I'll update my tree to reflect this.  Thanks.

-- 
error compiling committee.c: too many arguments to function

