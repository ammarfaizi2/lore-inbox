Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTLMGfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 01:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbTLMGfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 01:35:16 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:63755 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S264469AbTLMGfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 01:35:05 -0500
Message-ID: <3FDAB2FC.7040302@nishanet.com>
Date: Sat, 13 Dec 2003 01:34:36 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic,
 io-apic, udma133 covered
References: <200312072312.01013.ross@datscreative.com.au> <200312111655.25456.ross@datscreative.com.au> <1071143274.2272.4.camel@big.pomac.com> <200312111912.27811.ross@datscreative.com.au> <1071165161.2271.22.camel@big.pomac.com> <20031211182108.GA353@tesore.local> <3FD98A1F.901@nishanet.com> <20031212165929.GA187@tesore.local>
In-Reply-To: <20031212165929.GA187@tesore.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hackers be clever--

"system temperature was getting -- above 40 deg C. CPU was getting up to 
49 deg C...how poorly it's thermal management was operating then. Now 
with the new patches, and ultimately, BIOS update, system temperature is 
about 35 deg C -JesseAllen"

Maybe that tells me that my bios update fixed my
lockup problems without turning on cpu disconnect
or even by turning it off with no doc as face-saver
and not allowing me to see a choice in setup, since
like yours before cpu disconnect working my temp
is 41C most of the time and 48C under a
heavy load, possibly 49C, the exact range you
are looking at before you had cpu disconnect
working

or they turned cpu disconnect off without saying
anything, buying time, saving embarrassment

anyway it's probably off here since I have exactly
the same heat profile

I have 120mm fans one in one out, blowing air
across Zalman cpu and gpu heatsinks, no 80mm
extra Zalman fan. amd xp 3000+ 333mhz 1:1
arctic silver compound on heatsinks

Thermal 1: ok, 41.0 degrees C 105.8 degrees F
 - 41C in X, running realplayer
 - 48C compile a fat kernel or several heavy tasks

-Bob

Jesse Allen wrote:

> ....I compiled a new kernel without the disconnect off patch, or the 
> ack delay. These are the exact patches I used on 2.6.0-test11:
>
>patch-2.6.0-test11-bk8.bz2
>acpi-2.6.0t11.patch acpi bugfixes from Maciej.
>nforce-ioapic-timer-2.6t11.patch from Ross Dickson.  Timer patch.
>forcedeth.patch Patch stolen from -test10-mm1?  Unused.
>forcedeth-update-2.patch Same.
>
>Sure enough, under this kernel, no lockups.  Athcool reported Disconnect was "on".
>
>I decided to wait till this morning, to try the BIOS "C1 Disconnect" set to enabled.  Still no lockups under this kernel.  Tried a vanilla kernel, no lockups (but timer and watchdog messed up still).  Now that I read your message Bob, I understand what you are saying.  Luckily, the updated BIOS changelog states "Add C1 disconnect item."  And this exact version seems to have fixed it, and now we have an exact fix (another one?) to refer to.
>
>So the fix was absolutely a BIOS fix.
>
...but we're stuck looking at smoke and mirrors,
when the kernel might be able to work around
bioses that have not been "updated". Or to put
it another way, "voodoo" may be done by
kernel if not done by bios. Whatever is being
tweaked may be accessible to kernel code.

I can't read anything useful in my bios flash
file w6570nms.760 which is contained in--

>>http://download.msi.com.tw/support/bos_exe/6570v76.exe
>>

>>Nvidia X driver for ti4200 agp8 still locks up linux though,
>>but X nv works fine. agp8 3d may expose the timer issue.
>>
>>    
>>
>
>That's either an nvidia driver problem, or agpgart-nforce problem.  I'd try 4x agp, and or NVAGP (or agpgart, if already using NVAGP).  If you think it's the timer, try the timer patch, or with nolapic noapic.
>
>Jesse
>
Thanks, I've tried all of those except passing agp4 or agp2
to the nvidia X "nvidia" driver. Another clue that it's related
to interrupts or timing of access to interrupts is that before
I put another card on the pci bus I could get into X for a
few seconds with the nvidia driver before linux locked up,
now with an elan pcmcia 32-bit cardbus pci card that claims
it needs its own interrupt(can't give it one yet!) X just locks
up linux on load.
