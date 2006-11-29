Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758813AbWK2JzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758813AbWK2JzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758816AbWK2JzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:55:10 -0500
Received: from gw.goop.org ([64.81.55.164]:35245 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1758813AbWK2JzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:55:09 -0500
Message-ID: <456D5959.2000404@goop.org>
Date: Wed, 29 Nov 2006 01:56:41 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: akpm@osdl.org, Arjan van de Ven <arjan@infradead.org>, ak@suse.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <200611151227.04777.dada1@cosmosbay.com> <456CC25C.6070005@goop.org> <200611291030.56670.dada1@cosmosbay.com>
In-Reply-To: <200611291030.56670.dada1@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> if !CONFIG_SMP, why even dereferencing boot_pda+PDA_cpu to get 0 ?
> and as PER_CPU(cpu_gdt_descr, %ebx) in !CONFIG_SMP doesnt need the a value in 
> ebx, you can just do :
>
> #define CUR_CPU(reg) /* nothing */
>   

Yep.  On the other hand, I think that's an incredibly rare path anyway,
so it won't make any difference either way.

>> --- a/include/asm-i386/pda.h	Tue Nov 21 18:54:56 2006 -0800
>> +++ b/include/asm-i386/pda.h	Wed Nov 22 02:35:24 2006 -0800
>> @@ -22,6 +22,16 @@ extern struct i386_pda *_cpu_pda[];
>>
>>     
>
> My patch was better IMHO : we dont need to force asm () instructions to 
> perform regular C variable reading/writing in !CONFIG_SMP case.
>
> Using plain C allows compiler to generate a better code.
>   

Probably, but I'm interested in comparing apples with apples; how much
do the actual segment prefixes make a difference?

    J
