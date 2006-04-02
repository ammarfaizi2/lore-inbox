Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWDBAFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWDBAFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 19:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWDBAFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 19:05:22 -0500
Received: from smtpout.mac.com ([17.250.248.87]:461 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932320AbWDBAFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 19:05:21 -0500
In-Reply-To: <Pine.LNX.4.44.0604011333160.11853-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0604011333160.11853-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <33009D87-11FC-4DF9-8FAD-5401751AEB8A@mac.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org,
       LKML Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
Date: Sat, 1 Apr 2006 19:05:05 -0500
To: Mark Hahn <hahn@physics.mcmaster.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't trim CC lists.  I re-added LKML and others to the CC.

On Apr 1, 2006, at 13:40:42, Mark Hahn wrote:
>> ide: Assuming 33MHz system bus speed for PIO modes; override with  
>> idebus=xx
> is it true that you haven't overridden this?

I leave all drives configured with the settings they have on boot.   
At one time while setting the system up I tried playing with hdparm,  
but that was long ago and my current /etc/hdparm.conf is empty.

>> PDC20268: IDE controller at PCI slot 0001:11:02.0
>> PDC20268: chipset revision 2
>> PDC20268: ROM enabled at 0x80090000
>> PDC20268: 100%% native mode on irq 52
>>      ide3: BM-DMA at 0x1400-0x1407, BIOS settings: hdg:pio, hdh:pio
>>      ide4: BM-DMA at 0x1408-0x140f, BIOS settings: hdi:pio, hdj:pio
> hmm, unkind of the bios to leave the ports programmed for PIO.

The problematic card is a FirmTek UltraTek/100 rebranded as a Sonnet  
Tempo ATA/100.  The chipset on the card is a PDC20268 with a mac- 
bootable firmware.  The system is an aging 400MHz Mac G4 [AGP  
model].  Unfortunately this means that it's using whatever odd  
OpenFirmware code it originally shipped with; I've never seen an  
updater, and it most likely would require classic MacOS.

>> hda: max request size: 1024KiB
>> hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63,
>> UDMA(66)
>> hda: cache flushes supported
>> hda: [mac] hda1 hda2 hda3 hda4 hda5
> looks good, but that's the builtin disk, right?

The built-in primary (ATA-100?) controller has:
   hda: a 80GB Seagate Barracuda 7200.7
The built-in secondary (ATA-66?) controller has:
   hdc: a basic no-name brand CDROM
The built-in tertiary (ATA-33?) controller has no drives attached
The primary (IDE0) channel on the PDC20268 has:
   hdg: a 80GB Maxtor DiamondMax Plus 9
The secondary (IDE1) channel on the PDC 20268 has:
   hdi: a 80GB refurbished Samsung SP0822N

>> hdg: max request size: 128KiB
>> hdg: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63,
>> UDMA(100)
>> hdg: cache flushes supported
>> hdg:hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>> hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
>> ide: failed opcode was: unknown
>
> OK, so the add-in disks are trouble right from the start.  have you  
> checked your PATA cables?  no more than 18" long?  both _ends_  
> plugged in (no stub if 1 disk/cable)?

All of the PATA cables are perfectly fine. I've tried at _least_ 5  
different cables, including the 2 that shipped with the add-in IDE  
controller and the 5 that came with the various drives (I've had to  
replace 2 of them over the years, they're cheap commodity drives).  I  
also purchased a generic rounded IDE cable which I'm currently using  
as a replacement to connect one of the drives to the add-in  
controller due to space restrictions, although it had exactly the  
same behavior as all of the other IDE cables I've ever tried.  I seem  
to recall replacing it with an ordinary ribbon cable on my last  
onsite visit as I rearranged some of the internal hardware.

>> PDC202XX: Primary channel reset.
>> ide3: reset: success
> reset to what, I wonder, since the bios only provided programming  
> for PIO.

I don't understand what this means, my comprehension of ATA/IDE  
extends only as far as what I have read on this list :-\

>> [mac] hdg1 hdg2 hdg3 hdg4 hdg5
>> hdi: max request size: 1024KiB
>> hdi: 156368016 sectors (80060 MB) w/2048KiB Cache,  
>> CHS=16383/255/63, UDMA(33)
> hmm, udma33 is a pretty low mode, should certainly avoid CRC errors  
> even on quite bad cables.
>
>> hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>> hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
>> ide: failed opcode was: unknown
>
> the BadCRC means that there's definitely a problem with cable,  
> power, overclocking or driver-controller-timer-programming.

As I mentioned above, I did check out the cables quite thoroughly,  
including swapping them around, but the problem did not change.  The  
power supply itself was shipped with the case; which has 4 spaces for  
mounting internal drives.  When I first noticed the problem, I pulled  
out an old oscilliscope and saw no problematic power fluctuations  
during boot; and removing 2 of the drives and booting from CDROM did  
not change the problem at all, the remaining drive on the PDC  
controller still had the CRC errors.

On Apr 1, 2006, at 18:23:24, Alan Cox wrote:
> On Gwe, 2006-03-31 at 21:54 -0500, Kyle Moffett wrote:
>> IDE controller at a higher-than-supported speed.  It gets errors  
>> for a couple seconds and automatically drops the bus down to a  
>> lower and safer speed.
>
> This indicates a problem somewhere. The drives and controller  
> report their speed capabilities and if they can't meet the ones  
> they are reporting something is very wrong somewhere and this is  
> most definitely the first thing to debug.

I would not be surprised to find out that the OpenFirmware boot ROM  
or the kernel incorrectly programmed PIO or DMA on this card (though  
I know next to nothing about IDE, as you have seen).  As far as I can  
tell the hardware itself is all operating as well as can be expected  
given its age and the commodity nature of the parts.  If I had a  
budget to replace the system I would in a heartbeat, but I'd like to  
continue for as long as possible with what I have.

Thanks for all the assistance!

Cheers,
Kyle Moffett

