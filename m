Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129540AbRB0DYP>; Mon, 26 Feb 2001 22:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbRB0DYG>; Mon, 26 Feb 2001 22:24:06 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:44530 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129540AbRB0DXt>; Mon, 26 Feb 2001 22:23:49 -0500
Message-ID: <3A9B1CB8.B989A10@coplanar.net>
Date: Mon, 26 Feb 2001 22:19:20 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Passos <lists@cyclades.com>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux Serial List <linux-serial@vger.kernel.org>
Subject: Re: CLOCAL and TIOCMIWAIT
In-Reply-To: <Pine.LNX.4.10.10102261651000.15230-100000@main.cyclades.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Passos wrote:

> Hello,
>
> A customer has just brought to my attention that when you try to use the
> TIOCMIWAIT ioctl with our boards and CLOCAL is enabled, you can't check
> changes in the DCD signal. He also mentioned that that is possible with
> the regular serial ports.
>
> As I understood, CLOCAL meant disabling DCD sensitivity, so if CLOCAL is
> disabled, no changes in DCD will be passed from hardware driver to the
> kernel or userspace. The way the serial driver is implemented, this is not
> true (i.e. even with CLOCAL enabled, you can still see DCD changes through
> the TIOCMIWAIT command).

I remember auditing the exact code where this happens, but on 2.0 or earlier.

I had written a simple program 10-20 lines C to count pulses at rate of 1 per

second give or take.  It turned out that the driver disabled the UART's
generation
of interrupts completely for certain signals.  I don't remember which
exactly, but
I think it was DCD; I was using CLOCAL so the hangups wouldn't close the
descriptor.  The problems was that by disabling the interrupt at the source,
the ioctl's to read the bits stopped working!  not what I wanted.

I'm afraid I can't help, other that to suggest that that behaviour can have
problems.
The extra irq traffic was probably the motivation for this optimisation, but
I don't know of anyone's modem hanging up frequently enough to measure the
extra load.  Only people crazy enough to use the built-in serial port ($0)
as opposed to an $500 industrial digital io card are likely to care though...

>
>
> My question is: what's the correct interpretation of CLOCAL?? If the
> serial driver's interpretation is the correct one, I'll be more than happy
> to change the Cyclades' driver to comply with that, I just want to make
> sure that this is the expected behavior before I patch the driver.

