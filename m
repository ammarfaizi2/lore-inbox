Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUFBPVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUFBPVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUFBPVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:21:13 -0400
Received: from [213.239.201.226] ([213.239.201.226]:42194 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S263159AbUFBPVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:21:06 -0400
Message-ID: <40BDF1AC.7070209@shadowconnect.com>
Date: Wed, 02 Jun 2004 17:26:36 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com> <40BD1211.9030302@pobox.com> <40BD95EB.40506@shadowconnect.com> <40BDD4C9.5070602@pobox.com> <40BDDAD9.5070809@shadowconnect.com> <20040602134603.GA8589@havoc.gtf.org> <40BDE1BB.3030605@shadowconnect.com> <Pine.LNX.4.53.0406021024400.3280@chaos>
In-Reply-To: <Pine.LNX.4.53.0406021024400.3280@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Richard B. Johnson wrote:
>>>>>>>My preferred approach would be:  consider that the hardware does not
>>>>>>>need the entire 0x8000000-byte area mapped.  Plain and simple.
>>>>>>>This is a "don't do that" situation, and that renders the other
>>>>>>>questions moot :)  You should only be mapping what you need to map.
>>>>>>Okay, i'll let try it out with only 64MB.
>>>>>Why do you need 64MB, even?  :)
>>>>I don't know how much space i need :-D But why does the device set the
>>>>size to 128MB then?
>>>Devices often export things you don't care about, such as direct access
>>>to internal chip RAM.
>>>Look through the driver that figure out the maximum value that the
>>>driver actually _uses_.  There is no need to guess.
>>Okay, i've looked at it, but i don't think i could simply use less
>>space, because (if i understand the I2O spec right :-D) the controller
>>returns me a address inside this window, where i could write the I2O
>>message. So i ask the controller, where do you want my request, then he
>>tells me a address...
>>If i only ioremap 64MB, and the controller tells me write at 80MB, i'm
>>in deep trouble :-D
> I2O, as seen from the PCI/Bus, is a bus! Right? You have a
> PCI/Bus controller that provides for an interface into
> I2O? Right? Can you do `cat /proc/pci` and show what device

Hope a lspci -v would also help :-D

If not i must ask for the output again...

First controller:

0000:00:09.0 I2O: Distributed Processing Technology SmartRAID V 
Controller (rev 02) (prog-if 01)
	Subsystem: Distributed Processing Technology 2400A UDMA Four Channel
	Flags: bus master, medium devsel, latency 64, IRQ 17
	BIST result: 00
	Memory at d0000000 (32-bit, prefetchable)
	Capabilities: [80] Power Management version 2

0000:00:09.1 PCI bridge: Distributed Processing Technology PCI Bridge 
(rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	Expansion ROM at 0000a000 [disabled] [size=4K]
	Capabilities: [68] Power Management version 2


Second controller:

0000:00:0c.0 I2O: Distributed Processing Technology SmartRAID V 
Controller (rev 02) (prog-if 01)
	Subsystem: Distributed Processing Technology 2400A UDMA Four Channel
	Flags: bus master, medium devsel, latency 64, IRQ 19
	BIST result: 00
	Memory at d8000000 (32-bit, prefetchable)
	Capabilities: [80] Power Management version 2

0000:00:0c.1 PCI bridge: Distributed Processing Technology PCI Bridge 
(rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 64
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000b000-0000bfff
	Expansion ROM at 0000b000 [disabled] [size=4K]
	Capabilities: [68] Power Management version 2

> you think it is?  I think you are attempting to access a bridge
> or something. I2O is supposed to be intelligent and to grab
> 64 megabytes of host address space is the anthesis of this.

I don't know the hardware part very vell :-( But because i'm not the 
author of the driver i don't think there is something wrong :-)


Best regards,



Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
