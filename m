Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287475AbSALUyN>; Sat, 12 Jan 2002 15:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287471AbSALUyC>; Sat, 12 Jan 2002 15:54:02 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:41490 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287450AbSALUxu>; Sat, 12 Jan 2002 15:53:50 -0500
Message-ID: <3C40A255.EBE646@linux-m68k.org>
Date: Sat, 12 Jan 2002 21:53:41 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PTIR-0002sL-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:

> So with pre-empt this happens
> 
>         driver magic
>         disable_irq(dev->irq)
> PRE-EMPT:
>         [large periods of time running other code]
> PRE-EMPT:
>         We get back and we've missed 300 packets, the serial port sharing
>         the IRQ has dropped our internet connection completely.

But it shouldn't deadlock as Victor is suggesting.

> There are numerous other examples in the kernel tree where the current code
> knows that there is a small bounded time between two actions in kernel space
> that do not have a sleep. They are not spin locked, and putting spin locks
> everywhere will just trash performance. They are pure hardware interactions
> so you can't automatically detect them.

Why should spin locks trash perfomance, while an expensive disable_irq()
doesn't?

bye, Roman
