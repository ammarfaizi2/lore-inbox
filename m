Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbUDFWxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUDFWxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:53:30 -0400
Received: from ns.suse.de ([195.135.220.2]:41876 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264053AbUDFWx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:53:28 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {put,get}_user() side effects
References: <200404062053.i36KrC3Y005111@eeyore.valparaiso.cl>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I joined scientology at a garage sale!!
Date: Wed, 07 Apr 2004 00:53:26 +0200
In-Reply-To: <200404062053.i36KrC3Y005111@eeyore.valparaiso.cl> (Horst von
 Brand's message of "Tue, 06 Apr 2004 16:53:11 -0400")
Message-ID: <je3c7gyazd.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> Geert Uytterhoeven <geert@linux-m68k.org> said:
>> On Tue, 6 Apr 2004, Andi Kleen wrote:
>> > Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> > > On most (all?) architectures {get,put}_user() has side effects:
>> > >
>> > > #define put_user(x,ptr)                                                 \
>> > >   __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
>> >
>> > Neither typeof not sizeof are supposed to have side effects. If your
>> > compiler generates them that's a compiler bug.
>
>> From a simple compile test, you seem to be right... Weird, since it does
>> expand to 3 times 'pIndex++', but pIndex is incremented only once.
>
> Better check with a C language lawyer. Maybe gcc gets it wrong, or it is
> undefined

It's not undefined, the standard explicitly says that the argument of
sizeof is not evaluated (unless its type is a VLA).  I can't remember gcc
ever getting that wrong.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
