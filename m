Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131452AbRAKRk7>; Thu, 11 Jan 2001 12:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131674AbRAKRkt>; Thu, 11 Jan 2001 12:40:49 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:18959 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S131452AbRAKRkb>; Thu, 11 Jan 2001 12:40:31 -0500
Message-ID: <3A5DEFFE.4495683D@Hell.WH8.TU-Dresden.De>
Date: Thu, 11 Jan 2001 18:40:14 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>
Subject: [OOPS] APIC on Athlon [was Re: Linux 2.4.0-ac6]
In-Reply-To: <E14GX1V-0001T5-00@the-village.bc.nu> <3A5DD86B.1EC84550@Hell.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> Alan Cox wrote:
> >
> > 2.4.0-ac6
> > o       Fix athlon crash on boot with local apic/nmi    (Ingo Molnar)
> 
> Still crashes here with -ac6 on my Athlon. I'll have to write down the
> oops by hand later on or set up a serial console, but once that's done
> I'll post the trace - unless someone already knows what's still wrong
> with it.

Ok, here goes:

Right before it oopses, I can still read the following info on the
console which might be of help to someone:

Getting VERSION: 40010
Getting VERSION: 40010
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabling Ext INT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000

general protection fault: 0000

ksymoops 2.3.7 on i686 2.4.0.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.0-ac6 (specified)
     -m /boot/System.map-2.4.0-ac6 (specified)

No modules in ksyms, skipping objects
CPU: 0
EIP: 0010:[<c011174a>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000     ecx: 00000186       edx: 00000000
esi: 00000004   edi: c0105000     ebp: 0008e000       esp: c02a1fc0
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 0, stackpage=c02a1000)
Stack: 00000000 c02a787b 0000ffec 00099800 c02a7ae3 c02a27f5 c02a2900 c022f620
       0000ffec 0000ffec 0000ffec 0000ffec 0000ffec 00000000 c02d8ce0 c0100192
Call Trace: [<c0100192>]
Code: 0f 30 41 0f 30 b9 c1 00 00 00 0f 30 b9 c2 00 00 00 0f 30 b8

>>EIP; c011174a <setup_apic_nmi_watchdog+a/90>   <=====
Trace; c0100192 <L6+0/2>
Code;  c011174a <setup_apic_nmi_watchdog+a/90>
00000000 <_EIP>:
Code;  c011174a <setup_apic_nmi_watchdog+a/90>   <=====
   0:   0f 30                     wrmsr     <=====
Code;  c011174c <setup_apic_nmi_watchdog+c/90>
   2:   41                        incl   %ecx
Code;  c011174d <setup_apic_nmi_watchdog+d/90>
   3:   0f 30                     wrmsr  
Code;  c011174f <setup_apic_nmi_watchdog+f/90>
   5:   b9 c1 00 00 00            movl   $0xc1,%ecx
Code;  c0111754 <setup_apic_nmi_watchdog+14/90>
   a:   0f 30                     wrmsr  
Code;  c0111756 <setup_apic_nmi_watchdog+16/90>
   c:   b9 c2 00 00 00            movl   $0xc2,%ecx
Code;  c011175b <setup_apic_nmi_watchdog+1b/90>
  11:   0f 30                     wrmsr  
Code;  c011175d <setup_apic_nmi_watchdog+1d/90>
  13:   b8 00 00 00 00            movl   $0x0,%eax

Kernel panic: Attempted to kill the idle task!

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
