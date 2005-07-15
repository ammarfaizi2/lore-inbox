Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263357AbVGOT31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbVGOT31 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVGOT0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:26:52 -0400
Received: from [132.170.108.1] ([132.170.108.1]:21133 "EHLO
	longwood.cs.ucf.edu") by vger.kernel.org with ESMTP id S261714AbVGOTZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:25:23 -0400
Message-ID: <42D80D97.3080800@vaevictus.net>
Date: Fri, 15 Jul 2005 15:25:11 -0400
From: Nathan Mahon <vae@vaevictus.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Mahon <lkml.org@vaevictus.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Orinoco_plx woes on 2.6.13
References: <42D6A677.6040307@vaevictus.net>
In-Reply-To: <42D6A677.6040307@vaevictus.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a suggestion that i needed to update firmware, along with a
suggestion to move to the hostap driver.
for what it's worth,  I'm pretty sure hostap won't work for this card.
it's listed under orinoco_cs at pcmcia-cs.sf.net, and hostap doesn't
like it:

hostap_crypt: registered algorithm 'NULL'
hostap_plx: 0.3.9 - 2005-06-10 (Jouni Malinen <jkmaline@cc.hut.fi>)
PCI: Found IRQ 9 for device 0000:00:0a.0
PLX9052 PCI/PCMCIA adapter: mem=0xdf001000, plx_io=0x2800, irq=9,
pccard_io=0x2c00
hostap_plx: CIS: 09 7c f0 00 ff 17 ...
hostap_plx: invalid CIS data
Unknown PC Card CIS - not a Prism2/2.5 card?
hostap_plx: Driver unloaded
hostap_crypt: unregistered algorithm 'NULL' (deinit)

Thanks,
n8

Nathan Mahon wrote:

>I use a Belkin F5D6020 wifi card, (version one), and a belkin f5d6000 pci adapter for it.  A while ago, it was working flawlessly, though I
>didn't use it that much after the wife's laptop died.
>I've rolled through some kernel upgrades... and it appears my wifi does not work anymore.
>here's the technical stuff:
>
>I was still using 2.4 when it was working for sure, but I can't verify that it wasn't ever working on 2.6.
>under 2.6.11, i noticed the problem, I couldn't bring the interface up.
>dmesg produced similar results (to 2.6.13 i have now), but iirc, the
>iwconfig didn't make it look like the card was working at all.  I rolled
>to 2.6.13, and things improved only slightly.
>
>Now, with 2.6.13, I get a successful modprobe orinoco_plx:
>
>
>  
>
>>>auron root # dmesg
>>>orinoco_plx 0.15rc2 (Pavel Roskin <proski@gnu.org>, David Gibson 
>>><hermes@gibson.dropbear.id.au>, Daniel Barlow <dan@telent.net>)
>>>PCI: Found IRQ 9 for device 0000:00:0a.0
>>>orinoco_plx: Detected Orinoco/Prism2 PLX device at 0000:00:0a.0 irq:9, 
>>>io addr:0x2c00
>>>orinoco_plx: CIS: 01:03:00:00:FF:17:04:67:5A:08:FF:1D:05:01:67:5A:
>>>eth2: Hardware identity 8002:0000:0001:0000
>>>eth2: Station identity  001f:0003:0000:0008
>>>eth2: Firmware determined as Intersil 0.8.3
>>>eth2: Ad-hoc demo mode supported
>>>eth2: IEEE standard IBSS ad-hoc mode supported
>>>eth2: WEP supported, 104-bit key
>>>eth2: MAC address 00:30:BD:63:21:11
>>>eth2: Station name "Prism  I"
>>>eth2: ready
>>>      
>>>
>> 
>>
>>    
>>
>
>and at this point, iwconfig looks like the card is behaving somewhat:
>
>
>  
>
>>>auron root # iwconfig eth2
>>>eth2      IEEE 802.11b  ESSID:""  Nickname:"Prism  I"
>>>          Mode:Managed  Frequency:2.462 GHz  Access Point: 
>>>00:00:00:00:00:00
>>>          Bit Rate:11 Mb/s   Sensitivity:1/3
>>>          Retry min limit:8   RTS thr:off   Fragment thr:off
>>>          Encryption key:off
>>>          Power Management:off
>>>          Link Quality=0/92  Signal level=134/153  Noise level=134/153
>>>          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
>>>          Tx excessive retries:0  Invalid misc:0   Missed beacon:0
>>>      
>>>
>> 
>>
>>    
>>
>
>dmesg hasn't changed at this point.
>however, ifconfig breaks it:
>auron root # ifconfig eth2 10.5.6.1 netmask 255.255.255.0 broadcast
>10.5.6.255
>
>
>  
>
>>>SIOCSIFFLAGS: No such device
>>>      
>>>
>> 
>>
>>    
>>
>
>and dmesg now says this:
>
>
>  
>
>>>hermes @ 00012c00: Card removed while waiting for command 0x0f38 
>>>completion.
>>>eth2: Error -19 configuring card
>>>      
>>>
>> 
>>
>>    
>>
>
>and if i retry the ifconfig, i get a different error and a different
>dmesg result:
>
>
>  
>
>>>SIOCSIFFLAGS: Connection timed out
>>>      
>>>
>> 
>>
>>    
>>
>
>  
>
>>>eth2: Error -110 setting MAC address
>>>eth2: Error -110 configuring card
>>>      
>>>
>> 
>>
>>    
>>
>
>
>Just to state the implied, I'm *not* removing the card, and rmmod'ing the orinico_plx driver and re-modprobing it will produce consistantly the same errors.
>
>Thanks,
>Nathan Mahon
>
>
>System: old amd k6-2 333mhz box with 256mb ram
>Distro: gentoo
>Kernel config: http://www.vaevictus.net/2.6.13_config.txt
>First Post: so flame me if necessary. :D
>
>
>
>
>
>
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

