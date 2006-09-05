Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWIEA5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWIEA5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 20:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWIEA5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 20:57:33 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:37356 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1751513AbWIEA5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 20:57:32 -0400
Message-ID: <44FCCB7A.8000105@bellsouth.net>
Date: Mon, 04 Sep 2006 19:57:30 -0500
From: Jay Cliburn <jacliburn@bellsouth.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1 unusual IRQ number for VIA device
References: <fa.zOFUKsGFxa+fu0uGVN6HuRT+Krg@ifi.uio.no> <fa.2CAUcMm0GNX2+CNwugoJEUNtwzQ@ifi.uio.no> <44FCA4EC.3060507@shaw.ca> <44FCA920.4020706@bellsouth.net>
In-Reply-To: <44FCA920.4020706@bellsouth.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Cliburn wrote:
> Robert Hancock wrote:
>> Jay Cliburn wrote:
>>> Jay Cliburn wrote:
>>>> Running 2.6.18-rc5.mm1 on an Asus M2V mainboard with dual-core 
>>>> Athlon cpu, the onboard audio device gets assigned and IRQ of 8410.  
>>>> Under 2.6.18-rc4-mm3, the same device gets assigned IRQ 17.  Is this 
>>>> a way to get around this?
>>>
>>> What I meant to ask is:  Is there a way to get around this?
>>>
>>> Thanks,
>>> Jay
>>
>> What do you think needs to be "gotten around"? It is using MSI 
>> interrupts, I think that the IRQ numbers will be different.
>>
> I'll have to go research what MSI interrupts are.  Thanks for the pointer.

Nothing I've read about MSI so far indicates that an IRQ number greater 
than 255 is permissible, yet this device gets assigned an IRQ number of 
8,410 when MSI is enabled.  Booting 2.6.18-rc5-mm1 with pci=nomsi causes 
the device to be assigned IRQ 17 instead of 8410.

The problem with the large IRQ number is made manifest in Fedora's 
irqbalance program, which is run as an init script.  An array is built 
in that program that's indexed by IRQ number, with a max of 255.  When 
the program attempts to index element 8410, it segfaults.

Are IRQ numbers greater than 255 allowed with MSI?

