Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbTBJINY>; Mon, 10 Feb 2003 03:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbTBJINY>; Mon, 10 Feb 2003 03:13:24 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:3258 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S264724AbTBJINV>; Mon, 10 Feb 2003 03:13:21 -0500
Date: Mon, 10 Feb 2003 03:23:08 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: john@pianoman.cluster.toy
To: linux-kernel@vger.kernel.org
Subject: Mouse/Keyboard hangs..
Message-ID: <Pine.LNX.4.44.0302100225160.26242-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all..

I'm having an issue with my laptop.. the same issue i've had for since I
baught it..  Under linux the mouse (synaptics touchpad) and/or keyboard
will suddenly lock.  All input stops.  I can telnet in and shutdown
cleanly, but that doesn't help recover that I've got on my screen in X (or
the console).

Hardware: HP n5430 laptop, synaptics touchpad, trident XP graphics,
standard low-end laptop.

Here's the really odd part.  When it happens, if i notice quickly enough
and hit the power switch on my laptop for just a split second (not the 5
seconds to power off).. it sometimes comes back!  It's happened twice
while typing this email in pine using a text console (no X, no mouse).
But if I wait too long (a few seconds)...no matter how many times i nudge
the power switch, it never comes back.  Sometimes it's more frequent then
others.. sometimes I'll go for days/weeks without seeing it.

I've been seeing this since I got the laptop, and I've run almost every
2.4.x (x > ~10) and a lot of 2.5 kernels on here (currently, 2.5.54).
The behavior is a little different recently though with the 2.5 series.
Now, sometimes when it comes back, i get the character i was typing
repeated (as if a key was stuck) until i hit another key.  This change
could be related to the new i8042 changes in 2.5, I'm not sure.

I've tried : APIC, no APIC.
	     ACPI, no ACPI.
	     ALI IRQ router, ACPI IRQ router.
	     psmouse_noext command line arg.
	     powernow-ing the CPU down to 500Mhz (850Mhz duron... heat
							related?)

All to no avial.  The only possible reason I can think of that hitting the
power button could help is that triggers ACPI, which uses IRQ 9...
and I seem to remember something about IRQ 2 (cascade) and IRQ 9 (ACPI)
being one in the same, really.. maybe we missed an interrupt somewhere and
hitting the power switch forces IRQ 2 to trigger, somehow triggering IRQ
1 (keyboard) as well?  It's a stretch and my understanding of PC IRQ
logic is sketchy at best.

Does anyone have any ideas?

/proc/interrupts and relevant dmesg output is below the sig..
thanks,
john.c

- --
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens

Linux diana 2.5.54 #14 Sat Jan 4 00:02:14 EST 2003 i686 unknown

           CPU0
  0:  615936502          XT-PIC  timer
  1:       4574          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 11:   24012204          XT-PIC  eth0
 12:         52          XT-PIC  i8042
 14:     285204          XT-PIC  ide0
 15:     628739          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0

dmesg:
....
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7c20
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0fffcc46
ACPI: FADT (v001 ALI    M1533    01540.00000) @ 0x0fffef64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0fffefd8
ACPI: DSDT (v001 COMPAL      736 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=305 ide0=ata66 psmouse_noext=1
ide_setup: ide0=ata66
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 849.376 MHz processor.
....
Enabling disabled K7/SSE Support.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU: AMD mobile AMD Duron(tm) Processor stepping 01
....
device class 'input': registering
register interface 'mouse' with class 'input'
mice: PS/2 mouse device common for all mice
register interface 'event' with class 'input'
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
....

