Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130513AbRBKAAx>; Sat, 10 Feb 2001 19:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131022AbRBKAAd>; Sat, 10 Feb 2001 19:00:33 -0500
Received: from femail14.sdc1.sfba.home.com ([24.0.95.141]:27009 "EHLO
	femail14.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S130513AbRBKAA1>; Sat, 10 Feb 2001 19:00:27 -0500
Message-ID: <3A85D79C.3DE3A527@didntduck.org>
Date: Sat, 10 Feb 2001 19:06:52 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: IRQ conflicts
In-Reply-To: <E14RfhV-0002A1-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > <SoundBlaster EMU8000 (RAM2048k)>
> > ACPI: Core Subsystem version [20010208]
> > ACPI: SCI (IRQ9) allocation failed
> > ACPI: Subsystem enable failed
> > Trying to free free IRQ9
> 
> That seems to indicate acpi is freeing a free irq. Turn ACPI off. Its a
> good bet it will fix any random irq/driver problem right now

Looking at this a bit further, I realised that when the sound driver was
compiled in the kernel, it is initialised before ACPI.  The BIOS has
assigned IRQ9 to ACPI, but the PCI code does not know this because of:

PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class. 

The ISAPnP code then assigns IRQ9 to the sound card, causing the ACPI
code to fail to allocate it.  If I compile sound as a module then the
ACPI driver grabs IRQ9 and the sound get IRQ7.

--
					Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
