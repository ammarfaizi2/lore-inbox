Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136210AbREDLI2>; Fri, 4 May 2001 07:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136189AbREDLIS>; Fri, 4 May 2001 07:08:18 -0400
Received: from smtp1.libero.it ([193.70.192.51]:5104 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S136139AbREDLIH>;
	Fri, 4 May 2001 07:08:07 -0400
Message-ID: <3AF28D79.4BC0D1BE@alsa-project.org>
Date: Fri, 04 May 2001 13:07:37 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: David Woodhouse <dwmw2@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <3AF10E80.63727970@alsa-project.org>
		<Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg>
		<15089.979.650927.634060@pizda.ninka.net>
		<11718.988883128@redhat.com>
		<3AF12B94.60083603@alsa-project.org>
		<15089.63036.52229.489681@pizda.ninka.net>
		<3AF25700.19889930@alsa-project.org> <15090.23187.739430.925103@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Abramo Bagnara writes:
>  > it's perfectly fine to have:
>  >
>  > regs = (struct reg *) ioremap(addr, size);
>  > foo = readl((unsigned long)&regs->bar);
>  >
> 
> I don't see how one can find this valid compared to my preference of
> just plain readl(&regs->bar); You're telling me it's nicer to have the
> butt ugly cast there which serves no purpose?

It's right API a bit misused (to allow your request to use fields by
name)

i.e. foo = readl((unsigned long)&regs->bar);

vs a wrong API that need a cast to be used correctly

i.e. rme9652->iobase = (unsigned long) ioremap(rme9652->port,
RME9652_IO_EXTENT);

Taken in account that the main point is to not have fake pointers here
and there, my choice would be obvious.

> One could argue btw that structure offsets are less error prone to
> code than register offset defines out the wazoo.

offset defines are never correct on some architecture while being
incorrect on some other, that's the whole point: a wrong #define is
likely squashed during the very first phase of driver development.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
