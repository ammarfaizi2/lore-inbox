Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313385AbSDJRrq>; Wed, 10 Apr 2002 13:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313384AbSDJRrp>; Wed, 10 Apr 2002 13:47:45 -0400
Received: from wb3-a.mail.utexas.edu ([128.83.126.138]:30214 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S313385AbSDJRro>;
	Wed, 10 Apr 2002 13:47:44 -0400
Date: Wed, 10 Apr 2002 12:52:15 -0500 (CDT)
From: Brent Cook <busterb@mail.utexas.edu>
X-X-Sender: busterb@ozma.union.utexas.edu
To: John Adams <johna@onevista.com>
cc: linux-kernel-owner@vger.kernel.org, Oleg Drokin <green@linuxhacker.ru>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Mouse interrupts: the death knell of a VP6
In-Reply-To: <200204101716.NAA30717@onevista.com>
Message-ID: <20020410124233.X60995-100000@ozma.union.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, John Adams wrote:

> On Wednesday 10 April 2002 11:23 am, Oleg Drokin wrote:
> > Hello!
> >
> > On Wed, Apr 10, 2002 at 09:02:05AM -0500, Brent Cook wrote:
> > > I have an ABIT VP6 motherboard, using the VIA Apollo chipset and 2
> > > 700Mhz PIII's, but please don't hold that against me. The system is
> > > running 2.4.19-pre6. I believe that I either have a system that has
> > > trouble handling a sudden bursts of interrupts, or have found a fault
> > > in mouse handling.
> >
> > Have you tried to change MPS mode to 1.1 from 1.4 (I see addres message
> > timeouts in your log)?
> >
> > > I have already tried removing memory, adding memory, changing
> > > processors, video cards. The only thing that has remained constant is
> > > the VP6 motherboard and the hard drive.
> >
> > My VP6 died on me recently with some funny symptoms:
> > it hangs in X when I start netscape and move mouse, or if I do
> > bk clone on kernel tree, it dies with
> > kernel BUG at /usr/src/linux-2.4.18/include/asm/smplock.h:62!
> > BUG in various places pretty soon.
> > (this BUG is only appears if 2 CPUs are present in motherboard).
> > So if your troubles began only recently, you might want to try another
> > motherboard just to be sure.
>
> I have a VP6 with 2 CPUs.  Its has both a PS/2 mouse and a usb mouse.  Its
> been up for 90 days and handled lots of mouse interrupts.  See below.
>            CPU0       CPU1
>   0:  392228152  392338774    IO-APIC-edge  timer
>   1:     312494     312380    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:          1          3    IO-APIC-edge  serial
>  12:   40362907   40324010    IO-APIC-edge  PS/2 Mouse
>  14:    3386577    3383180    IO-APIC-edge  ide0
>  15:     679030     672810    IO-APIC-edge  ide1
>  17:    1165246    1162993   IO-APIC-level  DC395x_TRM
>  18:   83937970   83935445   IO-APIC-level  ide2, eth0
>  19:     131956     132468   IO-APIC-level  es1371, usb-uhci, usb-uhci
> NMI:          0          0
> LOC:  784686934  784686951
> ERR:        191
> MIS:          0

Oleg's suggestion about MPS didn't work, but it was fun. Instead of dying
instantly, a USB mouse pauses about 9 times before it finally halts. The
device in dmesg also disconnects/reconnects 9 times before it is unable to
assign a device number again to the mouse. PS/2 still locks the entire
machine. Loading and unloading usb-uhci.o does reinitialize the USB mouse
for a while, so it is fixable w/o rebooting.

This is also interesting. You appear to not have the strange ACPI device
at hardware interrupt 9 that I do. While the VP6 BIOS does not have the
option to turn off ACPI, perhaps I should try one of the hacked bioses at
abitvp6.com to turn off ACPI (maybe it is the culprit..) This is my
current situation (right after a USB lock):

           CPU0       CPU1
  0:     260203     267484    IO-APIC-edge  timer
  1:      10471      10704    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:      29249      29198   IO-APIC-level  usb-uhci, usb-uhci
  9:          0          0    IO-APIC-edge  acpi
 10:      13715      13332   IO-APIC-level  eth0
 14:       6255       5839    IO-APIC-edge  ide0
 15:         10          3    IO-APIC-edge  ide1
NMI:          0          0
LOC:     527647     527647
ERR:          0
MIS:          0

The acpi device appears whether or not I have ACPI support in the kernel.

 - Brent

> Its running a recent kernel.  Maybe 2.4.18 is broken.  Here's a uname -a
> Linux flash 2.5.0 #16 SMP Wed Jan 9 16:48:16 EST 2002 i686 unknown
>
> johna

2.5 exhibits similar behavior.

Thanks,
 Brent

