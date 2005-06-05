Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVFEOSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVFEOSc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 10:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVFEOSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 10:18:32 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:39531 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261563AbVFEOSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 10:18:25 -0400
Message-ID: <42A309B4.9060808@blueyonder.co.uk>
Date: Sun, 05 Jun 2005 15:18:28 +0100
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
References: <42A2A0B2.7020003@freemail.hu> <42A2A657.9060803@freemail.hu> <20050605001001.3e441076.akpm@osdl.org> <200506050227.25378.dtor_core@ameritech.net>
In-Reply-To: <200506050227.25378.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jun 2005 14:19:03.0559 (UTC) FILETIME=[8684B170:01C569D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Sunday 05 June 2005 02:10, Andrew Morton wrote:
> 
>>Zoltan Boszormenyi <zboszor@freemail.hu> wrote:
>>
>>>Zoltan Boszormenyi írta:
>>>
>>>>Hi,
>>>>
>>>>$SUBJECT says almost all, system is MSI K8TNeo FIS2R,
>>>>Athlon64 3200+, running FC3/x86-64. I use the multiconsole
>>>>extension from linuxconsole.sf.net, the patch does not touch
>>>>anything relevant under drivers/input or drivers/usb.
>>>>
>>>>The mice are detected just fine but the mouse pointers
>>>>do not move on either of my two screens. The same patch
>>>>(not counting the trivial reject fixes) do work on the
>>>>2.6.11-1.14_FC3 errata kernel. Both PS2 keyboard on the
>>>>keyboard and aux ports work correctly.
>>>
>>>The same patch also works on 2.6.12-rc4-mm2, with working mice.
>>>It seems the bug is mainstream.
>>>
>>
>>Please test an unpatched kernel.
> 
> 
> I think it is the same problem as Sid is seeing on his box.
> 
> 
>>I attached dmesg and the contents of /proc/interrupts.
>>The interrupt count on USB does not increase if I move either
>>mouse.
>>
> 
> 
> Sid, if you move mouse on your box, do you see interrupts reported
> in /proc/interrupts? Do you also have x86-64?
> 

2.6.12-rc5-git9 on both x86 and x86_64. On the x86 I have as follows:-
177:     178576   IO-APIC-level  ohci_hcd:usb3, eth0
185:         64   IO-APIC-level  eth1
193:          5   IO-APIC-level  ehci_hcd:usb1, ohci1394
201:        961   IO-APIC-level  ohci_hcd:usb2, NVidia nForce2
The interrupts are increasing, but they come from eth0 only, usb3 and 
eth0 share the same interrupt.

On the x86_64, all joystick controls and buttons are functional
193:     107220   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, 
uhci_hcd:usb3, uhci_hcd:usb4
201:      20940   IO-APIC-level  eth0

Possible problem with interrupt routing on the x86 box?. I shall try 
"pci=routeirq" next boot.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
