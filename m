Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVBELeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVBELeR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 06:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVBELeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 06:34:17 -0500
Received: from mailhub2.nextra.sk ([195.168.1.110]:12811 "EHLO toe.nextra.sk")
	by vger.kernel.org with ESMTP id S261811AbVBELeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 06:34:09 -0500
Message-ID: <4204AF64.9060201@rainbow-software.org>
Date: Sat, 05 Feb 2005 12:35:00 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> <1107485504.5727.35.camel@desktop.cunninghams> <9e4733910502032318460f2c0c@mail.gmail.com> <20050204074454.GB1086@elf.ucw.cz> <9e473391050204093837bc50d3@mail.gmail.com> <20050205093550.GC1158@elf.ucw.cz>
In-Reply-To: <20050205093550.GC1158@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>We already try to do that, but it hangs on 70% of machines. See
>>>Documentation/power/video.txt.
>>
>>We know that all of these ROMs are run at power on so they have to
>>work. This implies that there must be something wrong with the
>>environment the ROM are being run in. Video ROMs make calls into the
>>INT vectors of the system BIOS. If these haven't been set up yet
>>running the VBIOS is sure to hang.  Has someone with ROM source and
>>the appropriate debugging tools tried to debug one of these hangs?
>>Alternatively code could be added to wakeup.S to try and set these up
>>or dump the ones that are there and see if they are sane.
> 
> 
> Rumors say that notebooks no longer have video bios at C000h:0; rumors
> say that video BIOS on notebooks is simply integrated into main system
> BIOS. I personaly do not know if rumors are true, but PCs are ugly
> machines....

On systems with integrated graphics chips, there is no separate ROM chip 
for Video BIOS. Instead, it's integrated into system BIOS (this is true 
for onboard SCSI and pseudo-RAID controllerss too). During early 
initialization, system BIOS decompresses and initializes these BIOSes 
(if these is a PCI vendor ID and device ID match). (There is nothing 
wrong with this - BIOSes on PCI cards should not be run directly from 
the card's ROM but copied to RAM and executed from there instead 
according to PCI spec.)
After the POST is complete, the BIOSes are shadowed in RAM so Video BIOS 
is at C000:0 - so you can run DOS for example.

-- 
Ondrej Zary
