Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVBELx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVBELx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 06:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVBELx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 06:53:59 -0500
Received: from mailhub1.nextra.sk ([195.168.1.111]:61193 "EHLO
	mailhub1.nextra.sk") by vger.kernel.org with ESMTP id S262186AbVBELwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 06:52:46 -0500
Message-ID: <4204B3C1.80706@rainbow-software.org>
Date: Sat, 05 Feb 2005 12:53:37 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Jon Smirl <jonsmirl@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <20050122134205.GA9354@wsc-gmbh.de>	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>	 <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net>	 <20050204163019.GC1290@elf.ucw.cz>	 <9e4733910502040931955f5a6@mail.gmail.com>	 <1107569089.8575.35.camel@tyrosine>	 <9e4733910502041809738017a7@mail.gmail.com>	 <1107569842.8575.44.camel@tyrosine>	 <9e47339105020418306a4c2c93@mail.gmail.com> <1107591336.8575.51.camel@tyrosine>
In-Reply-To: <1107591336.8575.51.camel@tyrosine>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Fri, 2005-02-04 at 21:30 -0500, Jon Smirl wrote:
> 
> 
>>I suspect the problem in that case is a compressed VBIOS. Some laptops
>>compress the VBIOS and the system BIOS into a single ROM and then
>>expand them at power on. Sounds like this is not happening on resume.
>>To get around the problem copy the image from C000:0 before suspend to
>>a place in preserved RAM where wakeup.S can find it and then copy it
>>back to C000:0 on resume. To test for this checksum C000:0 before
>>suspend and after and see if it has changed.
> 
> 
> No, that's not what's happening. If you disassemble the code at
> c000:blah in a laptop, you'll often find that it jumps off to a
> completely different section of address space. During POST, that
> contains video BIOS. After POST, it may be something like USB boot
> support. Without reading it directly out of flash, it's not possible to
> recover that code.

I wonder how this can work:
a motherboard with i815 chipset (integrated VGA), Video BIOS is 
integrated into system BIOS
a PCI card inserted into one of the PCI slots, configured as primary in 
system BIOS

During POST, the PCI card BIOS is initialized. I boot Windows 98SE - 
then the onboard VGA initializes and I can use 2 monitors.
So either:
1. The driver can initialize the onboard VGA on its own (without VGA BIOS)
or
2. There is a way how to get the onboard VGA BIOS code from system BIOS


-- 
Ondrej Zary
