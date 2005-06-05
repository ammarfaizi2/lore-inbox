Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVFEOd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVFEOd3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 10:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVFEOd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 10:33:29 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:63248 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261572AbVFEOdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 10:33:16 -0400
Message-ID: <42A30D29.1000207@blueyonder.co.uk>
Date: Sun, 05 Jun 2005 15:33:13 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Zoltan Boszormenyi <zboszor@freemail.hu>
Subject: Re: USB mice do not work on 2.6.12-rc5-git9, -rc5-mm1, -rc5-mm2
References: <42A2A0B2.7020003@freemail.hu> <42A2A657.9060803@freemail.hu> <20050605001001.3e441076.akpm@osdl.org> <200506050227.25378.dtor_core@ameritech.net> <42A309B4.9060808@blueyonder.co.uk>
In-Reply-To: <42A309B4.9060808@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jun 2005 14:33:52.0193 (UTC) FILETIME=[982F7B10:01C569DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce wrote:
> Dmitry Torokhov wrote:
> 
>> On Sunday 05 June 2005 02:10, Andrew Morton wrote:
>>
>>> Zoltan Boszormenyi <zboszor@freemail.hu> wrote:
>>>
>>>> Zoltan Boszormenyi írta:
>>>>
>>>>> Hi,
>>>>>
>>>>> $SUBJECT says almost all, system is MSI K8TNeo FIS2R,
>>>>> Athlon64 3200+, running FC3/x86-64. I use the multiconsole
>>>>> extension from linuxconsole.sf.net, the patch does not touch
>>>>> anything relevant under drivers/input or drivers/usb.
>>>>>
>>>>> The mice are detected just fine but the mouse pointers
>>>>> do not move on either of my two screens. The same patch
>>>>> (not counting the trivial reject fixes) do work on the
>>>>> 2.6.11-1.14_FC3 errata kernel. Both PS2 keyboard on the
>>>>> keyboard and aux ports work correctly.
>>>>
>>>>
>>>> The same patch also works on 2.6.12-rc4-mm2, with working mice.
>>>> It seems the bug is mainstream.
>>>>
>>>
>>> Please test an unpatched kernel.
>>
>>
>>
>> I think it is the same problem as Sid is seeing on his box.
>>
>>
>>> I attached dmesg and the contents of /proc/interrupts.
>>> The interrupt count on USB does not increase if I move either
>>> mouse.
>>>
>>
>>
>> Sid, if you move mouse on your box, do you see interrupts reported
>> in /proc/interrupts? Do you also have x86-64?
>>
> 
> 2.6.12-rc5-git9 on both x86 and x86_64. On the x86 I have as follows:-
> 177:     178576   IO-APIC-level  ohci_hcd:usb3, eth0
> 185:         64   IO-APIC-level  eth1
> 193:          5   IO-APIC-level  ehci_hcd:usb1, ohci1394
> 201:        961   IO-APIC-level  ohci_hcd:usb2, NVidia nForce2
> The interrupts are increasing, but they come from eth0 only, usb3 and 
> eth0 share the same interrupt.
> 
> On the x86_64, all joystick controls and buttons are functional
> 193:     107220   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, 
> uhci_hcd:usb3, uhci_hcd:usb4
> 201:      20940   IO-APIC-level  eth0
> 
> Possible problem with interrupt routing on the x86 box?. I shall try 
> "pci=routeirq" next boot.
> Regards
> Sid.

pci=routeirq didn't fix the problem. Device 007 probably causing the 
interrupts - USB IDE HD.
185:       9675   IO-APIC-level  ohci_hcd:usb2, ohci1394, eth0
193:       8141   IO-APIC-level  ohci_hcd:usb3
201:       1032   IO-APIC-level  ehci_hcd:usb1, NVidia nForce2

Bus 003 Device 008: ID 04b8:0103 Seiko Epson Corp. Perfection 610
Bus 003 Device 007: ID 067b:3507 Prolific Technology, Inc.
Bus 003 Device 006: ID 068e:00f2 CH Products, Inc. Flight Sim Pedals
Bus 003 Device 005: ID 05e3:0760 Genesys Logic, Inc. Card Reader
Bus 003 Device 004: ID 03f0:0604 Hewlett-Packard DeskJet 840c
Bus 003 Device 003: ID 068e:00ff CH Products, Inc. Flight Sim Yoke
Bus 003 Device 002: ID 0451:2077 Texas Instruments, Inc. TUSB2077 Hub
Bus 003 Device 001: ID 0000:0000

barrabas:/home/lancelot # jscal /dev/js0
Joystick has 7 axes and 12 buttons.
Correction for axis 0 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 1 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 2 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 3 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 4 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 5 is broken line, precision is 0.
Coeficients are: 0, 0, 536870912, 536870912
Correction for axis 6 is broken line, precision is 0.
Coeficients are: 0, 0, 536870912, 536870912

barrabas:/home/lancelot # jscal /dev/js1
Joystick has 3 axes and 0 buttons.
Correction for axis 0 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 1 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 2 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751

Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
