Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131371AbRAPBQG>; Mon, 15 Jan 2001 20:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRAPBP5>; Mon, 15 Jan 2001 20:15:57 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64130 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131371AbRAPBPt>; Mon, 15 Jan 2001 20:15:49 -0500
Date: Mon, 15 Jan 2001 20:15:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dominik Kubla <dominik.kubla@uni-mainz.de>
cc: Jack Hammer <jhammer@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Slot Number Question
In-Reply-To: <20010116004754.A14902@uni-mainz.de>
Message-ID: <Pine.LNX.3.95.1010115195014.8710A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Dominik Kubla wrote:

> On Mon, Jan 15, 2001 at 03:22:58PM -0500, Richard B. Johnson wrote:
> > 
> > In any case, there is no way to correlate the device number with a
> > PC connector slot just as there is no way to find out which of the
> > 4 INT lines go to these connectors. The BIOS vendor only knows for
> > sure, and since BIOSes are not updated as often as boards, even the
> > BIOS is often incorrect.
> 
> Well actually there seems to be a way to do this. Quoting "System Management
> BIOS Reference Specification" v2.3.1 (p.51):
> 
>    3.3.10 System Slots (Type 9)
> 
>    The information in this structure defines the attributes of a system
>    slot. One structure is provided for each slot in the system.
> 
> And later in table 3.3.10.5 (p.53):
> 
>    Identifies the value present in the Slot Number field of the PCI Interrupt
>    Routing Table entry that is associated with this slot, in offset 09h [...]
> 
>    Software can determine the PCI bus number and device associated with the
>    slot by matching the "Slot ID" to an entry in the routing table... and
>    ultimately determine what device is present in that slot.
> 
> Right now Linux' SMBIOS implementation use only the first 3 tables to determine
> the manufacturer of system and BIOS to blacklist known buggy APM/ACPI
> implementations.  Since i have the SMBIOS specs at hand i will have a lot.
> Is there a PCI spec available on the net? www.pcisig.org asks for a password
> when you try to download the specs... (don't you just love "secret" standards?)
> 
> Yours,
>   Dominik Kubla
> -- 
>   Sign me!
> 

Well yes and no. The problem is that the 'slot' is not the connector!
It's easy to determine the slot to which they refer simply from the
bits at <11:15>. However, applications are not supposed to do the
port I/O to get this info, though. Instead, they are supposed to use
BIOS32 or other provisions.

All of the information necessary to observe/configure the bridge(s)
is/are available from the two ports specified in the standard.
Machines that don't have 'ports' emulate them (also in the standard)
so that minimum changes are necessary.

When a vendor puts a PCI Ethernet controller or a SCSI controller
on the board (or both). Any notion of a slot referencing a card-
connector goes out the window.

Linux now provides a 'local' PCI database. However, if hot-swapping
of PCI devices becomes a reality, this extra code may have limited
utility. Nevertheless it is a good idea for fixed configurations
that use modules because one doesn't run the risk of corrupting
a running PCI bus to get the resource information necessary to
install a new module.

The invisibility of a physical connector may actually be good. This
allows any PCI board to work in any PCI card-connector. Software that
requires a particular card-connector is probably broken by design.  If
software needs someone to 'adjust' something on a particular board,
hardware should provide an indication on the board (like a LED). 

--- Adjust the Contrabulator(tm) on the board with the flashing LED
to obtain a pale blue flame... Press any key to test.....
		**** RELEASE to DETONATE ***


I have heard that there is a spec available on the Net . However, I just
buy the latest books because the company has "plenty" of money and
I like hard copies. Sombody else will probably tell you where. There
is even a complete BIOS (several) on the Net.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
