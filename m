Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130830AbQJaXWP>; Tue, 31 Oct 2000 18:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130859AbQJaXWG>; Tue, 31 Oct 2000 18:22:06 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:42507 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130830AbQJaXVz>; Tue, 31 Oct 2000 18:21:55 -0500
Message-ID: <39FF5332.7C862223@timpanogas.org>
Date: Tue, 31 Oct 2000 16:18:10 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Pavel Machek <pavel@suse.cz>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0011010122160.18143-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:
> 
> On Tue, 31 Oct 2000, Jeff V. Merkey wrote:
> 
> > [...] These types of optimizations are possible when people have
> > acccess to Intel Red Cover documents, [...]
> 
> optimizing away AGIs has been documented by public Intel PDFs for years:
> 
>  [...] Since the Pentium processor has two integer pipelines, a register
>  used as the base or index component of an effective address calculation
>  (in either pipe) causes an additional clock cycle if that register is the
>  destination of either instruction from the immediately preceding clock
>  cycle. This effect is known as Address Generation Interlock (AGI).
> 
> (ditto for the p6 core CPUs), and GCC (IIRC) tries to avoid AGI conflicts
> as much as possible. (and this kind of stuff belongs into the compiler)

Odd.  When I profile Linux with EMON, I see tons of them.  Anywhere code
does

mov    eax, addr
mov    [addr], ebx

one will get generated.  Even something as simple as:

mov    eax, addr
inc    eax
dec    eax
mov    [addr]. ebx

will avoid an AGI (since the other pipeline has now been allowed a few
clocks to fetch the address and load it).

Jeff



> 
>         Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
