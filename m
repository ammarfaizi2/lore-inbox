Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWHWPHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWHWPHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWHWPHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:07:16 -0400
Received: from gw.goop.org ([64.81.55.164]:52631 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964936AbWHWPHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:07:14 -0400
Message-ID: <44EC6F21.9090000@goop.org>
Date: Wed, 23 Aug 2006 08:07:13 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Paul Drynoff <pauldrynoff@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@xensource.com>,
       linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>
Subject: Re: [BUG] Can not boot linux-2.6.18-rc4-mm2
References: <20060822125118.12ba1ed4.pauldrynoff@gmail.com>	 <20060822123850.bdb09717.akpm@osdl.org>	 <36e6b2150608221413h3b6baf24lf670a2aed61c0c57@mail.gmail.com>	 <44EB7D2D.7000006@goop.org> <36e6b2150608222127y39bb9314h9b0a31f1f8b6b399@mail.gmail.com>
In-Reply-To: <36e6b2150608222127y39bb9314h9b0a31f1f8b6b399@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Drynoff wrote:
> On 8/23/06, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>> Hm.  Try this:
>> --- a/arch/i386/kernel/paravirt.c
>> +++ b/arch/i386/kernel/paravirt.c
> I have no such file.
>
>> --- a/include/asm-i386/desc.h
>> +++ b/include/asm-i386/desc.h
>> @@ -97,7 +97,7 @@ static inline void set_ldt(const void *a
>>         __u32 low, high;
>>
>>         pack_descriptor(&low, &high, (unsigned long)addr,
>> -                       entries * sizeof(struct desc_struct) - 1,
>> +                       entries * sizeof(struct desc_struct),
>>                         DESCTYPE_LDT, 0);
>>         write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, low, 
>> high);
>
> There is no such code in this file.

Ah, yes, that was against a different patch queue.

> I adopt your code for linux-2.6.18-rc4-mm2, and looks like it fix bug.
>
> Index: linux-2.6.18-rc4-mm2/include/asm-i386/desc.h
> ===================================================================
> --- linux-2.6.18-rc4-mm2.orig/include/asm-i386/desc.h
> +++ linux-2.6.18-rc4-mm2/include/asm-i386/desc.h
> @@ -114,7 +114,7 @@ static inline void set_ldt_desc(unsigned
> {
>        __u32 a, b;
>        pack_descriptor(&a, &b, (unsigned long)addr,
> -                       entries * sizeof(struct desc_struct) - 1,
> +                       entries * sizeof(struct desc_struct),
>                        DESCTYPE_LDT, 0);
>        write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, a, b);
> }

Great!

    J
