Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVGKTpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVGKTpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVGKTpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:45:04 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51090 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S262450AbVGKTnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:43:50 -0400
Date: Mon, 11 Jul 2005 15:43:49 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
Subject: Re: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
In-Reply-To: <200507112133.07471@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507111539280.6399-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005, Michel Bouissou wrote:

> Le Lundi 11 Juillet 2005 20:36, Alan Stern a écrit :
> > It's also possible that the UHCI controllers are generating the unwanted
> > interrupt requests.  You should make sure that Legacy USB Support is
> > turned off in your BIOS settings.
> 
> My motherboard both holds USB 1.1 and USB 2.0 controllers. I don't have a 
> "Legacy USB Support" option in my BIOS, all my USB options are the following:
> 
> Enable USB 1.1 controller: YES	(Surely relates to my true USB 1.1 controller)
> 
> Enable USB 2.0 controller: YES	(Same for the high speed controller ?)
> 
> Enable USB keyboard: NO
> 
> Enable USB mouse support: YES	(Well, I have one ;-)

That's what I was talking about.  BIOS support for keyboard and mouse is
called "Legacy" support, because it emulates plain old non-USB AT-type 
devices.  I bet if you turned off the "Enable USB mouse support" option 
then everything would work.

> I didn't change anything regarding these so far.
> 
> > You can also try adding the "usb-handoff" kernel parameter to your boot
> > command line. 
> 
> Hey !! This one looks like the MIRACLE-OPTION !!
> 
> I just booted using my 2.6.12 kernel patched with Nathalie's patches (don't 
> know if they help in there...) and the problem seems to be gone !
> 
> Nothing complains anymore about the interrupt. I have:
> 
> [root@totor etc]# cat /proc/interrupts
>            CPU0
>   0:     934501    IO-APIC-edge  timer
>   1:       4611    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   4:       2779    IO-APIC-edge  serial
>   7:          3    IO-APIC-edge  parport0
>  14:       7909    IO-APIC-edge  ide4
>  15:       7918    IO-APIC-edge  ide5
>  16:      38447   IO-APIC-level  nvidia
>  18:       2982   IO-APIC-level  eth0, eth1
>  19:      37041   IO-APIC-level  ide0, ide1, ide2, ide3, ehci_hcd:usb4
>  21:      52036   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
>  22:       2850   IO-APIC-level  VIA8233
> NMI:          0
> LOC:     934453
> ERR:          0
> MIS:          0
> 
> 
> ...now let's see with time if this is stable...
> 
> A thousand thanks for your suggestion Alan !

You're welcome.

> (Kernel 2.4 was working plain good without such a boot option, I didn't know 
> it existed...)

A lot has changed since 2.4... not always for the better!

Alan Stern

