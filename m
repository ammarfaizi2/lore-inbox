Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286368AbRLJURg>; Mon, 10 Dec 2001 15:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286370AbRLJUR2>; Mon, 10 Dec 2001 15:17:28 -0500
Received: from fmr01.intel.com ([192.55.52.18]:60891 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S286368AbRLJURI>;
	Mon, 10 Dec 2001 15:17:08 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D7D2@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Kai Germaschewski'" <kai@tp1.ruhr-uni-bochum.de>
Cc: "Acpi-linux (E-mail 2)" <acpi-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Cory Bell <cory.bell@usa.net>,
        John Clemens <john@deater.net>
Subject: RE: ACPI IRQ routing (was [ACPI] ACPI source release updated (200
	11205))
Date: Mon, 10 Dec 2001 12:17:04 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kai Germaschewski [mailto:kai@tp1.ruhr-uni-bochum.de]

Hi Kai,

I also got ACPI IRQ routing working on a system over the weekend. Sounds
like yours is better, so great we'll adopt yours. Thanks for stepping up on
this.

> I changed pci-irq.c to use the ACPI interrupt routing, and also added 
> dynamic routing table support. The appended patch is a bit 
> preliminary, 
> but it works here, even for assigning irqs.

> Further comments/to do:
> o The ACPI PCI in general needs further cleanup and 
> integration with the 
>   normal PCI layer. I believe that should wait until the new device 
>   infrastructure is in place, though. E.g., I think one can
>   get rid of the static table which is currently setup in acpi_pci.c. 

<shrug>. Once we get it working, we can get it working right, and save the
1K.

> o I'm not exactly happy with the way ACPI does things currently, but I
>   didn't change it to keep the patch small. It uses multiple functions
>   to parse the IRQ resource descriptor into a linked list of 
>   "acpi_resource" which I then again have to convert back into the
>   mask which was in the IRQ resource desriptor in the first place.
>   About the same holds for the other way, instead of just setting
>   up a five byte IRQ descriptor, I need to setup two "acpi_resource" 
>   structs, calculate lengths, etc. which will eventually be 
> converted to
>   just the five bytes. IMO the conversion routines are unnecessary 
>   bloat...	

Like I said above, I think it's too early to be optimizing this code. My
main concern was more about integrating ACPI into pci-irq.c in a readable
manner. It is pretty $PIR-specific (no surprise there). Anyways let me work
with your new code and I will be able to comment more.

> o Things need to be made dynamic, i.e. try ACPI and if it 
> doesn't work,
>   fall back to the normal method. Also, a command line flag to disable
>   acpi irq routing is probably a good idea.

At this point, I'd think one to *enable* it would be better until the code
is tested more.

Regards -- Andy
