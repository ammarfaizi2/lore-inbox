Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129982AbQK0R2b>; Mon, 27 Nov 2000 12:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130599AbQK0R2V>; Mon, 27 Nov 2000 12:28:21 -0500
Received: from ext.lri.fr ([129.175.15.4]:54160 "EHLO ext.lri.fr")
        by vger.kernel.org with ESMTP id <S129982AbQK0R2O>;
        Mon, 27 Nov 2000 12:28:14 -0500
From: "Benjamin Monate <Benjamin Monate" <Benjamin.Monate@lri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <14882.37528.366653.855907@sun-demons>
Date: Mon, 27 Nov 2000 17:58:00 +0100 (MET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup of the timer with 2.4.0-test10 SMP (and older)
In-Reply-To: <Pine.GSO.3.96.1001127154910.13774O-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <14877.29271.211561.467359@sun-demons>
        <Pine.GSO.3.96.1001127154910.13774O-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.62 under Emacs 20.7.1
Reply-To: Benjamin.Monate@lri.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just patched my kernel and here are my results: 

> systems.  Please apply and give me the "IRQ to pin mappings:" part of the
> bootstrap log.  I'm pretty confident we get everything fine there, but
> just in case...
0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ20 -> 1:4
IRQ24 -> 1:8
IRQ25 -> 1:9
Just curious : what do these numbers on the right refer to ? Are they
real physical pins of the processor ?

>  Patch-2.4.0-test11-pic_debug-0 fetches as much as possible from chips
> involved in IRQ handling.  Most of the code is already in place -- the
> patch only adds another magic SysRq command (credit goes for Andrew Morton
> for the idea).  Please apply the patch and provide me the output of
> SysRq+A (you need to have MAGIC_SYSRQ enabled) as caught just after a
> bootstrap and then after you notice the timer IRQ counter no longer
> advances.  I strongly suspect some software (be it XFree86 or not) enables
> one of the 8259A inputs which should remain disabled.  This would lead to
> symptoms as you describe due to the special 8259A setup we use when the
> workaround is in use.

Here are both outputs: 
Just after bootstrap:
Nov 27 16:51:35 pc8-118 kernel: SysRq:
Nov 27 16:51:35 pc8-118 kernel: print_PIC()
Nov 27 16:51:35 pc8-118 kernel: printing PIC contents
Nov 27 16:51:35 pc8-118 kernel: print_IO_APIC()
Nov 27 16:51:35 pc8-118 kernel: testing the IO APIC.......................
Nov 27 16:51:35 pc8-118 kernel:
Nov 27 16:51:35 pc8-118 kernel:
Nov 27 16:51:35 pc8-118 kernel: .................................... done.
Nov 27 16:51:35 pc8-118 kernel: print_all_local_APICs()
Nov 27 16:51:35 pc8-118 kernel:
Nov 27 16:51:35 pc8-118 kernel: ... APIC ID:      03000000 (3)
Nov 27 16:51:35 pc8-118 kernel: ... APIC VERSION: 00040011
Nov 27 16:51:35 pc8-118 kernel: 00000000000000000000000000000000
Nov 27 16:51:35 pc8-118 last message repeated 9 times
Nov 27 16:51:35 pc8-118 kernel: 00000000010000000100000000000000
Nov 27 16:51:35 pc8-118 kernel: 00000000000000000000000000000000
Nov 27 16:51:35 pc8-118 last message repeated 2 times
Nov 27 16:51:35 pc8-118 kernel: 00000000000000000100000000000000
Nov 27 16:51:35 pc8-118 kernel: 00000000000000000000000000000000
Nov 27 16:51:35 pc8-118 last message repeated 4 times
Nov 27 16:51:35 pc8-118 kernel: 00000000000000010000000000000000
Nov 27 16:51:35 pc8-118 kernel:
Nov 27 16:51:35 pc8-118 kernel:
Nov 27 16:51:35 pc8-118 kernel: ... APIC ID:      00000000 (0)
Nov 27 16:51:35 pc8-118 kernel: ... APIC VERSION: 00040011
Nov 27 16:51:35 pc8-118 kernel: 00000000000000000000000000000000
Nov 27 16:51:35 pc8-118 last message repeated 9 times
Nov 27 16:51:35 pc8-118 kernel: 00000000010000000100000000000000
Nov 27 16:51:35 pc8-118 kernel: 00000000000000000000000000000000
Nov 27 16:51:35 pc8-118 last message repeated 8 times
Nov 27 16:51:35 pc8-118 kernel: 00000000000000010000000000000000
Nov 27 16:51:35 pc8-118 kernel:

And then a quite different one after the locks: 
Nov 27 17:10:57 pc8-118 kernel: SysRq:
Nov 27 17:10:57 pc8-118 kernel: print_PIC()
Nov 27 17:10:57 pc8-118 kernel: printing PIC contents
Nov 27 17:10:57 pc8-118 kernel: print_IO_APIC()
Nov 27 17:10:57 pc8-118 kernel: testing the IO APIC.......................
Nov 27 17:10:57 pc8-118 kernel:
Nov 27 17:10:57 pc8-118 kernel:
Nov 27 17:10:57 pc8-118 kernel: .................................... done.
Nov 27 17:10:57 pc8-118 kernel: print_all_local_APICs()
Nov 27 17:10:57 pc8-118 kernel:
Nov 27 17:10:57 pc8-118 kernel: ... APIC ID:      00000000 (0)
Nov 27 17:10:57 pc8-118 kernel: ... APIC VERSION: 00040011
Nov 27 17:10:57 pc8-118 kernel: 00000000000000000000000000000000
Nov 27 17:10:57 pc8-118 last message repeated 9 times
Nov 27 17:10:57 pc8-118 kernel: 00000000010000000100000000000000
Nov 27 17:10:57 pc8-118 kernel: 00000000000000000000000000000000
Nov 27 17:10:57 pc8-118 last message repeated 9 times
Nov 27 17:10:57 pc8-118 kernel:
Nov 27 17:10:57 pc8-118 kernel:
Nov 27 17:10:57 pc8-118 kernel: ... APIC ID:      03000000 (3)
Nov 27 17:10:57 pc8-118 kernel: ... APIC VERSION: 00040011
Nov 27 17:10:57 pc8-118 kernel: 00000000000000000000000000000000
Nov 27 17:10:57 pc8-118 last message repeated 9 times
Nov 27 17:10:57 pc8-118 kernel: 00000000010000000100000000000000
Nov 27 17:10:57 pc8-118 kernel: 00000000000000000000000000000000
Nov 27 17:10:57 pc8-118 last message repeated 8 times
Nov 27 17:10:57 pc8-118 kernel: 00000000000000010000000000000000
Nov 27 17:10:57 pc8-118 kernel:

Now this looks really cryptic to me.

Both outputs are different.

- They are in displayed in a different order : 
  APIC 3 then 0 before lock and APIC 0 then 3 after the lock.

- Last line of the APIC 0 differ on one bit : 
   Before lock    00000000000000010000000000000000
   After lock     00000000000000000000000000000000

- Line 15 of APIC 3 differ :
  Before lock	  00000000000000000100000000000000
  After lock	  00000000000000000000000000000000

>  I am trying to pull documentation from ServerWorks -- they appear not to
> want to share them with everyone.  From marketing brochures available on
> their web site I found out their chipsets feature integrated I/O APICs
> which makes me quite suspicious the original problem with the timer IRQ
> routing (i.e. not the secondary one you observe when the workaround gets
> activated) lies in the chipset setup. 

The only informations that I can read in the manual are :

ServerWorks LE 3.0 Chipset: features the ServerWorks LE 3.0 North
Bridge and RCC Open South Bridge.
Integrated IOAPIC: Supports full 32-APIC entries and removes the need
for a separate IOAPIC chip. <<<< the source of the original problem ?

I will try to find some technical specification on the web.

Thank you.
-- 
| Benjamin Monate
| LRI - Bât. 490          
| Université de Paris-Sud


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
