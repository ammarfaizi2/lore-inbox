Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136410AbREDOl2>; Fri, 4 May 2001 10:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136411AbREDOlT>; Fri, 4 May 2001 10:41:19 -0400
Received: from geos.coastside.net ([207.213.212.4]:21980 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S136410AbREDOlK>; Fri, 4 May 2001 10:41:10 -0400
Mime-Version: 1.0
Message-Id: <p05100303b71862b98488@[207.213.214.37]>
In-Reply-To: <15090.23187.739430.925103@pizda.ninka.net>
In-Reply-To: <3AF10E80.63727970@alsa-project.org>
 <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg>
 <15089.979.650927.634060@pizda.ninka.net>	<11718.988883128@redhat.com>
 <3AF12B94.60083603@alsa-project.org>
 <15089.63036.52229.489681@pizda.ninka.net>
 <3AF25700.19889930@alsa-project.org>
 <15090.23187.739430.925103@pizda.ninka.net>
Date: Fri, 4 May 2001 06:53:26 -0700
To: "David S. Miller" <davem@redhat.com>,
        Abramo Bagnara <abramo@alsa-project.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: unsigned long ioremap()?
Cc: David Woodhouse <dwmw2@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:30 AM -0700 2001-05-04, David S. Miller wrote:
>Abramo Bagnara writes:
>  > it's perfectly fine to have:
>  >
>  > regs = (struct reg *) ioremap(addr, size);
>  > foo = readl((unsigned long)&regs->bar);
>  >
>
>I don't see how one can find this valid compared to my preference of
>just plain readl(&regs->bar); You're telling me it's nicer to have the
>butt ugly cast there which serves no purpose?
>
>One could argue btw that structure offsets are less error prone to
>code than register offset defines out the wazoo.
>
>I think your argument here is bogus.

The proposed API change serves to avoid the worse-than-butt-ugly:

	foo = regs->bar;

which on the evidence of the current kernel source is in fact a real problem.

One could imagine a pointer-type-modifier in C that says "this 
pointer can't be dereferenced, but pointer arithmetic is OK, and any 
derived pointers inherit the property", with syntax similar to 
volatile, or some kind of C++ dereference overloading, but absent 
that, a correct API offsets the marginal burden of having to cast in 
order to treat non-pointers as pointers.

As Abramo points out, if you can't abide the above cast, you can 
create a relatively trivial macro to hide the dirty work.
-- 
/Jonathan Lundell.
