Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316252AbSEVRBI>; Wed, 22 May 2002 13:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316254AbSEVRBH>; Wed, 22 May 2002 13:01:07 -0400
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:39808 "EHLO
	Bluesong.NET") by vger.kernel.org with ESMTP id <S316252AbSEVRBG>;
	Wed, 22 May 2002 13:01:06 -0400
Message-Id: <200205221710.g4MHAhX05491@Bluesong.NET>
Content-Type: text/plain; charset=US-ASCII
From: "Jack F. Vogel" <jfv@trane.bluesong.net>
Reply-To: jfv@bluesong.net
To: Greg KH <greg@kroah.com>, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 fix for running a SMP kernel on a UP box
Date: Wed, 22 May 2002 10:10:43 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020521215217.GA3784@kroah.com>
Cc: jfv@us.ibm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 May 2002 02:52 pm, Greg KH wrote:
> I can't seem to run a SMP 2.5.17 kernel on a UP machine, it locks up
> during the boot process.  In talking to Jack Vogel, he suggested I make
> the following patch, which seems to solve the problem for me.  In
> looking at the code, I have no idea of why this seems to work, so there
> probably is a better fix out there.
>
> Any suggestions?
>
> thanks,
>
> greg k-h

I should add one bit of information. I originally saw this problem on a
UP IBM Netvista machine, its the same box Greg had it happen on.

However, I have a 933Mhz PIII HP box at home and it does not
have the problem.

Since we are limited in the variety of machines to test on I am not
sure about this, but I believe its only going to occur on UP systems
with an IOAPIC.

If you apply the irq_balance patch to a 2.4.* kernel you can recreate
the same hang, in fact it was on 2.4.18 that i first ran into it.

I realize its kinda a corner case, running an SMP kernel on a
subset of UP machines, but hey, I figure its supposed to work :)

>
> diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
> --- a/arch/i386/kernel/io_apic.c	Tue May 21 14:47:06 2002
> +++ b/arch/i386/kernel/io_apic.c	Tue May 21 14:47:06 2002
> @@ -205,7 +205,7 @@
>  } ____cacheline_aligned irq_balance_t;
>
>  static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned
> -			= { [ 0 ... NR_IRQS-1 ] = { 1, 0 } };
> +			= { [ 0 ... NR_IRQS-1 ] = { 0, 0 } };
>
>  extern unsigned long irq_affinity [NR_IRQS];

Cheers,

-- 
Jack F. Vogel
IBM  Linux Solutions
jfv@us.ibm.com  (work)
jfv@Bluesong.NET (home)
