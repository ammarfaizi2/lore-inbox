Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWHBCU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWHBCU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWHBCU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:20:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20164 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751045AbWHBCU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:20:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 2/33] i386: define __pa_symbol
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302293540-git-send-email-ebiederm@xmission.com>
	<p73lkq81djg.fsf@verdi.suse.de>
Date: Tue, 01 Aug 2006 20:19:21 -0600
In-Reply-To: <p73lkq81djg.fsf@verdi.suse.de> (Andi Kleen's message of "01 Aug
	2006 21:06:27 +0200")
Message-ID: <m14pwvyj4m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
>> On x86_64 we have to be careful with calculating the physical
>> address of kernel symbols.  Both because of compiler odditities
>> and because the symbols live in a different range of the virtual
>> address space.
>> 
>> Having a defintition of __pa_symbol that works on both x86_64 and
>> i386 simplifies writing code that works for both x86_64 and
>> i386 that has these kinds of dependencies.
>> 
>> So this patch adds the trivial i386 __pa_symbol definition.
>> 
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> ---
>>  include/asm-i386/page.h |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>> 
>> diff --git a/include/asm-i386/page.h b/include/asm-i386/page.h
>> index f5bf544..eceb7f5 100644
>> --- a/include/asm-i386/page.h
>> +++ b/include/asm-i386/page.h
>> @@ -124,6 +124,7 @@ #define PAGE_OFFSET		((unsigned long)__P
>>  #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
>>  #define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
>>  #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
>> +#define __pa_symbol(x)		__pa(x)
>
> Actually PAGE_OFFSET arithmetic on symbols is outside ISO C and gcc 
> misoptimizes it occassionally. You would need to use HIDE_RELOC
> or similar. That is why x86-64 has the magic.

Yes.  ISO C only defines pointer arithmetic with in arrays.  
I believe gnu C makes it a well defined case.

Currently we do not appear to have any problems on i386.
But I have at least one case of code that is shared between
i386 and x86_64 and it is appropriate to use __pa_symbol on
x86_64.

So I added __pa_symbol for that practical reason.

I would have no problems with generalizing this but I wanted to
at least make it possible to use the concept on i386.

I will be happy to add in the assembly magic, if you don't have
any other problems with this.

Eric
