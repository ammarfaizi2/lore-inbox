Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293737AbSCSF2X>; Tue, 19 Mar 2002 00:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293746AbSCSF2N>; Tue, 19 Mar 2002 00:28:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7186 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293737AbSCSF2H>; Tue, 19 Mar 2002 00:28:07 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gcc inline asm - short question
Date: 18 Mar 2002 21:27:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a76i8p$rc2$1@cesium.transmeta.com>
In-Reply-To: <20020318232740.39289.qmail@web13305.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020318232740.39289.qmail@web13305.mail.yahoo.com>
By author:    Carl Spalletta <cspalletta@yahoo.com>
In newsgroup: linux.dev.kernel
> 
>   I have read all the docs and I still can't clearly understand when it 
> is required to specify a clobberlist - a register or memory that will
> be modified and must be preserved by gcc.
> 
>   In searching the kernel source there were very few clobbers given
> and most of those were for memory.
> 
>   For example in arch/i386/lib/delay.c:
> 
> 71         __asm__("mull %0"
> 72         :"=d" (xloops), "=&a" (d0)
> 73         :"1" (xloops),"" (current_cpu_data.loops_per_jiffy));
> 74         __delay(xloops * HZ);
> 
>   It's pretty obvious that eax gets clobbered, as I know clobber.  Why is
> it not listed as such? Does the answer to this question apply in all cases? 
> What about memory clobbers - how do they happen?
> 

It's not listed as such because it's an output (the second output),
not a clobber.  This is particularly common on x86 where registers are
so specialized that they all have their own constraint letters.

Incidentally, the above asm statement is technically incorrect, "=&a"
(d0) means eax is an "early clobber", however, the instruction doesn't
require it to be early clobbered.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
