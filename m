Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131384AbQL3NJ6>; Sat, 30 Dec 2000 08:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbQL3NJs>; Sat, 30 Dec 2000 08:09:48 -0500
Received: from p3EE3CA77.dip.t-dialin.net ([62.227.202.119]:35588 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S131384AbQL3NJm>; Sat, 30 Dec 2000 08:09:42 -0500
Date: Sat, 30 Dec 2000 13:39:10 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
Message-ID: <20001230133910.A5341@emma1.emma.line.org>
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001228112305.A2571@emma1.emma.line.org> <E14Bc2d-0003e0-00@the-village.bc.nu> <20001228145337.A2887@emma1.emma.line.org> <20001229134252.L22081@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001229134252.L22081@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Fri, Dec 29, 2000 at 13:42:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2000, Erik Mouw wrote:

> On Thu, Dec 28, 2000 at 02:53:37PM +0100, Matthias Andree wrote:
> However, reading from /proc/apm also triggers other weird problems:
> 
> - Received characters dropped on serial line. I thought my serial port
>   was broken, because a 16550 is supposed to have a receive buffer.

I don't know that the Linux driver sets the IRQ trigger to (you can have
the 16550 request interrupts after its 16-byte FIFO has 1, 4, 8 or 14
bytes ready for reading), but if it's set to 14 (to reduce the IRQ
frequency), you don't have much time at 115200 Bit/s, you have 1 Byte
every 87 ms then (it has 10 bit usually, 1 start + 1 stop bit), and
reading from /proc/apm stops my system clock for approx. 80 ... 90 ms -
then you still have IRQs with higher precedence and whooops, your buffer
overruns. Setting the trigger lower would help, but I never looked how
this will happen.

(I never run into this problem myself since I have 16750s here which
have at least 8 Bytes left when triggering, they have 64 Byte FIFO.)

> I got the same problems with my previous notebook (Asus P6300, PII 266,
> 112MB, Intel BX/ZX chipset). It might be a BIOS problem, because both
> notebooks use a Phoenix BIOS. OTOH, I can create the same problems with
> USB on my desktop (Asus P5A motherboard, K6 333, 160MB, Ali 1541
> chipset, Award BIOS) when I run the GNOME battery_applet. So is this an
> Asus problem, or a general APM problem?

My problem shows up on a Gigabyte board with AMIBIOS, so it's certainly
not a Phoenix or Asus specific problem.

However, reading from /proc/apm triggers BIOS calls which involve
certain action, maybe switching to Real Mode and other things, and I
suspect that either IRQs are still disabled while the BIOS is called or
the BIOS plays bad games which Linux would have to compensate for. :-/

HTH,
Matthias
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
