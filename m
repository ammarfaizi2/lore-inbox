Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbRGGDxi>; Fri, 6 Jul 2001 23:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbRGGDx3>; Fri, 6 Jul 2001 23:53:29 -0400
Received: from toscano.org ([64.50.191.142]:59076 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S266004AbRGGDxY>;
	Fri, 6 Jul 2001 23:53:24 -0400
Date: Fri, 6 Jul 2001 23:53:24 -0400
From: Pete Toscano <pete.lkml@toscano.org>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hi all, a strange full lock in SMP-kernel 2.4.6 and 2.4.5
Message-ID: <20010706235324.A19386@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010707021356.A2232@eresmas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010707021356.A2232@eresmas.net>; from linuxx@eresmas.net on Sat, Jul 07, 2001 at 02:13:56AM +0100
X-Unexpected: The Spanish Inquisition
X-Uptime: 11:41pm  up 1 day, 13:40,  3 users,  load average: 0.06, 0.30, 0.35
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I've seen this same problem, at least with regards to USB
printing.  Yesterday, I traced the problem down to a patch to usb-uhci.c
in the transition from 2.4.3 to 2.4.4.  The problem persists today.  A
work around for this problem is to use the alternate UHCI driver
(uhci.o).

What motherboard and chipset are you using.  I use the Tyan Tiger 133
motherboard with the VIA Apollo Pro 133a chipset.  Someone else who I
heard from uses another VIA-based chipset (I think, he never replied to
my question).  Maybe this is a VIA-related problem, like the APIC
problem is.  (Do you use "noapic" when you boot?  He and I both have SMP
systems too....)

I posted something on the linux-usb list yesterday about this problem
and with all the info I was able to track down, but I have yet to see
any response.  I've taken this as far as I can by myself.  I don't know
enough about kernel programming or about USB to check the code in
usb-uhci.c, but I'm more than happy to help by providing information
and/or testing potential patches/fixes.

pete

On Sat, 07 Jul 2001, linuxx wrote:

> Well Full lock in 2.4.5 and .6 when in a SMP intel p III 500mhz when i try to print any file in a epson 760 usb and parport
> printer.  
> I put in antecedents . With 2.4.3 and before the printer via usb or partport print ok . In 2.4.5-6 when i try to send
> anything to /dev/usb/lp0 like cat a.txt > /dev/usb/lp0 the system fail or if i do in lpr same . I have no problem if i use parport whit the sames kernels .I have all right configured. With the same computer in other distribution .Same kernel = same lock .Of course the LPRng and gcc are 
> all compiled in this machine and work right for months , both stables versions.I put the only trace y can get for the lock.
> I hope help something for any other thing i not subscribed to kernel list so i like to know any answer you can give. THANKS
> 
> CPU:    0
> EIP:    0010:[<d084acd1>]
> EFLAGS: 00000086
> eax: cd747600  ebx: cd1d42a0  ecx: 00000001  edx: cd747600
> esi: cd1d41fc  edi: 00000000  ebp: 00000004  esp: cd077f34
> ds: 0018  es: 0018  ss:0018
> Process cat (pid: 378, stackpage=cd077000)
> Stack: 0000017a 00000000 00000005 00000000 00000206 cd1d41a0 cd8f0000 00000000
>        00000004 d0837aac cd1d41fc d084e411 cd1d41fc 00000000 cdec8c60 ffffffea
>        00000000 00000004 c013a1c6 cdec8c60 0804c860 00000004 cdec8c80 00000025
> 
> Call Trace: [<013a1c6>] [<c0106ea7>]
> Code: 80 7b 24 00 f3 90 7e f8 e9 e0 d0 ff ff 80 bf 80 00 00 00 00
> console shuts up ...
> <unfinished ...>
> +++ killed by SIGSEGV +++
