Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285261AbSACKFZ>; Thu, 3 Jan 2002 05:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285266AbSACKFP>; Thu, 3 Jan 2002 05:05:15 -0500
Received: from mail.sonytel.be ([193.74.243.200]:39826 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S285261AbSACKFC>;
	Thu, 3 Jan 2002 05:05:02 -0500
Date: Thu, 3 Jan 2002 11:03:49 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
cc: Richard Henderson <rth@redhat.com>, Tom Rini <trini@kernel.crashing.org>,
        jtv <jtv@xs4all.nl>, Momchil Velikov <velco@fadata.bg>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        gcc@gcc.gnu.org,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <15411.49911.958835.299377@argo.ozlabs.ibm.com>
Message-ID: <Pine.GSO.4.21.0201031057430.18863-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Paul Mackerras wrote:
> Richard Henderson writes:
> > Ignore strcpy.  Yes, that's what visibly causing a failure here,
> > but the bug is in the funny pointer arithmetic.  Leave that in
> > there and the compiler _will_ bite your ass sooner or later.
> 
> I look forward to seeing your patch to remove all uses of
> virt_to_phys, phys_to_virt, __pa, __va, etc. from arch/alpha... :)

Isn't this why we use `unsigned long' to represent physical addresses, and
`void *' to represent kernel virtual addresses? Not only helps it against a
user dereferencing a physical address `pointer', but also against gcc trying to
be (too) smart.

Of course this also implies we have to change the pointer argument in readb()
and friends, since it's not a real pointer but a magic cookie. But we already
had that discussion last year...

[ and the conclusion was: keep the pointer, so we can do readl(&base->field) ]

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


