Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136222AbRECI1w>; Thu, 3 May 2001 04:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136227AbRECI1n>; Thu, 3 May 2001 04:27:43 -0400
Received: from hood.tvd.be ([195.162.196.21]:19072 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S136222AbRECI1e>;
	Thu, 3 May 2001 04:27:34 -0400
Date: Thu, 3 May 2001 10:26:15 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Abramo Bagnara <abramo@alsa-project.org>,
        "David S. Miller" <davem@redhat.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <3AF11211.B226543D@mandrakesoft.com>
Message-ID: <Pine.LNX.4.05.10105031024340.9438-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2001, Jeff Garzik wrote:
> Abramo Bagnara wrote:
> > "David S. Miller" wrote:
> > > There is a school of thought which believes that:
> > >
> > > struct xdev_regs {
> > >         u32 reg1;
> > >         u32 reg2;
> > > };
> > >
> > >         val = readl(&regs->reg2);
> > >
> > > is cleaner than:
> > >
> > > #define REG1 0x00
> > > #define REG2 0x04
> > >
> > >         val = readl(regs + REG2);
> 
> > The problem I see is that with the former solution nothing prevents from
> > to do:
> > 
> >         regs->reg2 = 13;
> 
> Why should there be something to prevent that?

Because people can't seem to be teached to not do it?

> If a programmer does that to an ioremapped area, that is a bug.  Pure
> and simple.
> 
> We do not need extra mechanisms simply to guard against programmers
> doing the wrong thing all the time.
> 
> > That's indeed the reason to change ioremap prototype for 2.5.
> 
> Say what??
> 
> I have heard a good argument from rth about creating a pci_ioremap,
> which takes a struct pci_dev argument.  But there is no reason to change
> the ioremap prototype.

If ioremap() would return unsigned long, the programmer at least has to cast it
before he can do the buggy thing. But indeed bad programmers probably don't
know that casts are evil (except when used very carefully).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

