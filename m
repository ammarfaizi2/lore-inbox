Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263334AbRFWXdq>; Sat, 23 Jun 2001 19:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263089AbRFWXdg>; Sat, 23 Jun 2001 19:33:36 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:47507 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S263257AbRFWXdY>; Sat, 23 Jun 2001 19:33:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: For comment: draft BIOS use document for the kernel
Date: Fri, 22 Jun 2001 11:50:32 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15DTfd-0003gI-00@the-village.bc.nu>
In-Reply-To: <E15DTfd-0003gI-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <0106221150320N.00692@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 June 2001 12:20, Alan Cox wrote:

> int 0x10 service 3 is used during the boot loading sequence to obtain the
> cursor position. int 0x10 service 13 is used to display loading messages
> as the loading procedure continues. int 0x10 AH=0xE is used to display a
> progress bar of '=' characters during the bootstrap

I seem to remember '.' characters, not '='...

> It then uses int 0x10 AH=0x0E in order to print initial progress banners so
> that immediate feedback on the boot status is available. The 0x07 character
> is issued as well as printable characters and is expected to generate a
> bell.

Hmmm...  About when during the boot is this?  (I get a beep from the bios 
long before lilo, and another when the pcmcia stuff detects a card, but 
that's it...)

> usable memory data. It also handles older BIOSes that return AX/BX but not
> AX/BX data.

What does that mean?  (Return garbage in AX/BX?)

> Having sized memory the kernel moves on to set up peripherals. The BIOS
> INT 0x16, AH=0x03 service is invoked in order to set the keyboard repeat
> rate and the video BIOS is the called to set up video modes.

"then called"...

> The kernel tries to identify the video in terms of its generic features.
> Initially it invokes INT 0x10 AH=0x12 to test for the presence of EGA/VGA
> as oppose to CGA/MGA/HGA hardware.

"as opposed to"...

> Having completed video set up the hard disk data for hda and hdb is copied
> from the low memory BIOS area into the kernel tables. INT 0x13 AH-0x15 is
> used to check if a second disk is present.

Second disk or second IDE controller?  (We already copied hdb from low 
memory, are we now confirming it?)

> The kernel invokes the PCI_BIOS_PRESENT function initially, in order to
> test the availability of PCI services in the firmware. Assuming this is
> found them PCIBIOS_FIND_PCI_DEVICE, PCIBIOS_FIND_PCI_CLASS_CODE,
> PCIBIOS_GENERATE_SPECIAL_CYCLE, PCIBIOS_READ/WRITE_CONFIG_BYTE/WORD/DWORD
> calls are issued as the PCI service are configured, along with

either "services are" or "service is"...

> compatibility. One extension the Linux kernel makes to the official rules
> for parsing this table, is that in the presence of PCI/ISA machines it will

That is a totally gratuitous comma.  (Okay, I'm nit-picking.  It can stay if 
you think it can be house-trained, but I'm not feeding it.)


> 4.1	Boot Linux on the system
>
> 4.2	Insert a PCMCIA card, ensure the kernel detects it
>
> 4.3	Remove the PCMCIA card, ensure the kernel detects the change
>
> 4.4	Insert a cardbus card, ensure the kernel detects it
>
> 4.5	Verify the cardbus device is usable
>
> 4.6	Remove the cardbus device, ensure the kernel detects it


I have a 100% reproducable crash on Red Hat 7.1 if I put in a cardbus card, 
apm suspend, resume the system, then pop the cardbus card out.

Kernel panic, every time.  (I assumed it had been fixed in newer versions.  
I've been meaning to look into it, but it works fine with a 16 bit PCMCIA 
card so I just swapped my 100baseT for a 10baseT and everything's fine.

The cardbus card works fine if I put it in and pop it out without suspending, 
and it suspend works fine by itself (Although sound never comes back after an 
APM suspend.  I have to reboot the laptop to get sound back...)

Aht he joys of the Dell inspiron 3500.  Nice big screen, though...

Rob

