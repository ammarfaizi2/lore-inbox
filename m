Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136148AbRECH35>; Thu, 3 May 2001 03:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136149AbRECH3s>; Thu, 3 May 2001 03:29:48 -0400
Received: from css-1.cs.iastate.edu ([129.186.3.24]:273 "EHLO
	css-1.cs.iastate.edu") by vger.kernel.org with ESMTP
	id <S136148AbRECH3b>; Thu, 3 May 2001 03:29:31 -0400
Date: Thu, 3 May 2001 02:29:28 -0500 (CDT)
From: "C.Praveen" <cpraveen@cs.iastate.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: "David S. Miller" <davem@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <3AF10648.C5986A8E@mandrakesoft.com>
Message-ID: <Pine.HPX.4.31.0105030222230.17348-100000@beast.cs.iastate.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for ccing this to people not on the kernel list too, but i
hope  the more expert heads, the better ...

Can i do a

if (softirq_active(cpu) & softirq_mask(cpu))
    {
        do_softirq();
    }

at the end of smp_apic_timer_interrupt ? i mean

smp_apic_timer_interrupt ()
{
  irq_enter
  All it does normally.
  irq_exit
  if (softirq_active(cpu) & softirq_mask(cpu))
  {
        do_softirq();
  }
}

My understanding is that smp_apic_timer_interrupt is very similar to
do_IRQ but it knows which function to call already,
and since the do_IRQ does this at the end of its execution, it
should be ok here too. Am i ok in doing this ? basically the function
smp_apic_timer_interrupt activates a tasklet, that i would like done here
at this point, executed as a tasklet itself. If this is not ok, can
someone suggest something for acheiving this ?

Thanks for any help!

CP

