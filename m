Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbUDMExC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbUDMExB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:53:01 -0400
Received: from gizmo08ps.bigpond.com ([144.140.71.18]:58799 "HELO
	gizmo08ps.bigpond.com") by vger.kernel.org with SMTP
	id S263246AbUDMEwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:52:37 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: really bensoo_at_soo_dot_com <lnx-kern@soo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2
Date: Tue, 13 Apr 2004 14:55:52 +1000
User-Agent: KMail/1.5.1
References: <200404131117.31306.ross@datscreative.com.au> <20040413040145.GA3327@Sophia.soo.com>
In-Reply-To: <20040413040145.GA3327@Sophia.soo.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Len Brown <len.brown@intel.com>,
       christian.kroener@tu-harburg.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404131455.52195.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 April 2004 14:01, really bensoo_at_soo_dot_com wrote:
> Very odd.  i'm using plain 2.6.5 with your 2.6.3

Yes odd, it's the first report of a "hi-load" XT-PIC issue I know of.

> APIC patches, and left all this io_apic_set_pci_routing()
> stuff in.  And, for this first time in who knows
> how long i seem to have a stable computer.  Actually
> been up more than eight days.

Sounds Very Good.

Are you using my io-apic patch with the apic ack delay or with the
C1idle version?
i.e. patched io_apic.c and apic.c and using kernel arg "apic_tack="
or patched io_apic.c and process.c and using kernel arg "idle=C1halt"?

My cat proc/cmdline
root=/dev/hdb2 idle=C1halt nmi_watchdog=1

Could you please cat /proc/interrupts.
I would like to see how irq0 is routed.
Mine looks like.

           CPU0
  0:     229404    IO-APIC-edge  timer
  1:        376    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  9:          0   IO-APIC-level  acpi
 12:      13499    IO-APIC-edge  PS/2 Mouse
 14:      10482    IO-APIC-edge  ide0
 15:         73    IO-APIC-edge  ide1
 16:      27055   IO-APIC-level  nvidia
 20:      46913   IO-APIC-level  eth0, usb-ohci
 21:       3660   IO-APIC-level  ehci_hcd, NVIDIA nForce Audio
 22:          0   IO-APIC-level  usb-ohci
NMI:     229547
LOC:     229340
ERR:          0
MIS:          0

And from boot log
with my new timer setup

ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN2
..TIMER: Check if 8254 timer connected to IO-APIC INTIN0? ...
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
..TIMER: works OK on IO-APIC irq0
Using local APIC timer interrupts.
calibrating APIC timer ...

and my ioapic routing

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   0   0    1    1    D9
 11 001 01  1    1    0   0   0    1    1    E1
 12 001 01  1    1    0   0   0    1    1    C9
 13 001 01  1    1    0   0   0    1    1    D1
 14 001 01  1    1    0   0   0    1    1    B1
 15 001 01  1    1    0   0   0    1    1    C1
 16 001 01  1    1    0   0   0    1    1    B9
 17 001 01  1    1    0   0   0    1    1    A9
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing


> 
> This is an old overclocked MSI K7N2 with the first
> revision of the nForce2 chipset, the one that's only
> supposed to have UDMA100 (dunno if that's the chipset
> or the MSI mboard: the 2.6.X kernels have always said
> during bootup that it's running UDMA133).  i use an
> old Tulip ethercard instead of the onboard LAN.
>
 
I am now using forcedeth for onboard ether. It works well and is
convenient when rebuilding and testing kernels and modules.

> This machine is the beater box: an HTPC and a 24/7
> file share client, compile and test stuff, play music
> thru an Audigy sound card, burn DVD's, play video
> files, many of these things at the same time.
> 
> Before this kernel i was lucky to have uptimes over
> two days.

Yes I remember how frustrating it felt to have linux regularly die and 
even fail to boot properly.

> 
> b
> 
> On Tue, Apr 13, 2004 at 11:17:31AM +1000, Ross Dickson wrote:
> > I am working with 2.4.26-rc2 and have noticed a change with the the recent acpi?
> > update. The recent fix to stop unnecessary ioapic irq routing entries puts the 
> > following if statement into io_apic.c, io_apic_set_pci_routing()
> > 
> > 	/*
> > 	 * IRQs < 16 are already in the irq_2_pin[] map
> > 	 */
> > 	if (irq >= 16)
> > 		add_pin_to_irq(irq, ioapic, pin);
> > 
> > which prevents my io-apic patch from using that function to reprogram the
> > io-apic pin on irq0 from pin2 to pin0. 
> 
> 
> 
> 

I did some more reading on kernel version re Maciej's 8259 ack patch
Ignore my comments in previous posting as patch was fully pulled from all
kernels at end of 2.6.3 ie. never appeared in 2.6.4 or later

>>I have not as yet downloaded 2.6.5xxx
>>From memory this 2.4.26-rc2 code should be very similar to the (2.6.5-linus)
>>but a bit different to the -mm series. For the -mm series I think you can drop
>>the "timer_ack=" lines from my changes as it still has Maciej Rozycki's 8259 
>>ack patch? The timer ack should already have been correctly set to off by it's
>>checking if the apic is an integrated one.

Shame as it seemed theoretically correct to me to not ack.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/2143.html

Regards
Ross.



