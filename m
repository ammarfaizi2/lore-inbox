Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272843AbRIGUlb>; Fri, 7 Sep 2001 16:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272844AbRIGUlV>; Fri, 7 Sep 2001 16:41:21 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:64091 "HELO
	pirx.hexapodia.org") by vger.kernel.org with SMTP
	id <S272843AbRIGUlK>; Fri, 7 Sep 2001 16:41:10 -0400
Date: Fri, 7 Sep 2001 15:41:29 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: USB IRQ routing problems on Via Apollo Pro 133A
Message-ID: <20010907154129.B9370@hexapodia.org>
In-Reply-To: <20010906004520.A2891@hexapodia.org> <20010906202536.A11264@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010906202536.A11264@middle.of.nowhere>; from thunder7@xs4all.nl on Thu, Sep 06, 2001 at 08:25:36PM +0200
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Moving from private mail to linux-kernel]

On Thu, Sep 06, 2001 at 08:25:36PM +0200, thunder7@xs4all.nl wrote:
> You have missed something all right. In the later kernels, the output of
> 'dmesg' mentions:
> 
> PCI: Probing PCI hardware
[snip]
> PCI: Enabling Via external APIC routing
> PCI: Via IRQ fixup for 00:07.2, from 9 to 3
> PCI: Via IRQ fixup for 00:07.3, from 9 to 3
> 
> Those last 2 lines are the ones that are new (since 2.4.5 or so, I guess
> - it was back in June, anyway)

Hrm.  Depending on what I enable in the BIOS, I do get similar lines,
but even then my USB controller doesn't work.  On the current boot for
example, I have

PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 00:07.2, from 9 to 3

and the usb-uhci driver shows up in /proc/interrupts:

           CPU0       CPU1
  0:     384195     341825    IO-APIC-edge  timer
  1:       4166       4032    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  9:          0          0          XT-PIC  acpi
 12:      39181      39875    IO-APIC-edge  PS/2 Mouse
 14:       5362       5509    IO-APIC-edge  ide0
 15:          0          0    IO-APIC-edge  ide1
 17:      13441      13344   IO-APIC-level  eth0
 18:        284        304   IO-APIC-level  es1371
 19:          0          0   IO-APIC-level  usb-uhci
NMI:          0          0
LOC:     725968     725967
ERR:          0
MIS:          0

But there are still no interrupts getting from the USB controller to
the CPU.  I get the standard

hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 101, change 3, 12 Mb/s
usb-uhci.c: v1.251:USB Universal Host Controller Interface driver
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: USB new device connect on bus1/2, assigned device number 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)

and /proc/interrupts continues to show 0 interrupts on line 19.

If I switch back to MPS1.1, the USB controller moves to IRQ 9 (shared
with the acpi controller) but the behavior is the same.  If I toggle
"PnP OS" in the BIOS, I see no relevant differences.  I've tried turning
off and on just about everything of relevance; no change.

Booting a non-APIC kernel makes it work, of course.

The system is a Tyan Tiger 133A, Via Apollo Pro 133A chipset, SMP,
currently running 2.4.9.  Complete dmesg, lspci -vvvvxxxx, and
/proc/interrupts are at
http://web.hexapodia.org/~adi/straum/usb/

Thanks for any help.  Feel free to CC me on replies; I am on the list,
but procmail is a harsh mistress.

(Related question:  Why the '& 0xf' in the calculation of newirq in
quirk_via_irqpic?)

-andy
