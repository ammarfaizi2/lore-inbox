Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVBTUBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVBTUBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 15:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVBTUBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 15:01:15 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:52944 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261786AbVBTUAq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 15:00:46 -0500
Message-ID: <4218EC6A.5000800@tiscali.de>
Date: Sun, 20 Feb 2005 21:00:42 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       bzolnier@gmail.com, bzolnier@elka.pw.edu.pl,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 2.6.11rc4: irq 5, nobody cared
References: <20050220155600.GD5049@vanheusden.com> <20050220164010.GA17806@ime.usp.br> <4218C692.9040106@tiscali.de> <20050220180550.GA18606@ime.usp.br>
In-Reply-To: <20050220180550.GA18606@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito wrote:

>On Feb 20 2005, Matthias-Christian Ott wrote:
>  
>
>>Rogério Brito wrote:
>>    
>>
>>>I am willing to test any patch and configuration (let's call me a
>>>"guinea pig"), but I don't know what I should do. I have, OTOH,
>>>reported my problem many times in the past few days. :-(
>>>
>>>I will retry sending my message to the list once again, with the
>>>details (in my case, the message I get is "irq 10: nobody cared!"
>>>and it is regarding my primary HD on my secondary Promise PDC20265
>>>controller).
>>>      
>>>
>
>First of all, Matthias-Christian, thank you very much for your kind
>answer.
>
>I have already tried contacting the linux-ide mailing list as a CC to my
>earlier messages, but I got no response. I am including some details in
>this e-mail. I included Bartlomiej in the CC, as he is listed as general
>IDE maintainer in the MAINTAINERS file.
>
>  
>
>>Report it to http://bugzilla.kernel.org/. Maybe you'll get help there.
>>    
>>
>
>Thanks. I will try filing a bug on that system as soon as I get the
>reply to create my account there.
>
>(...)
>  
>
>>You see it's very difficult to fix such irq problems because some factors
>>can cause such an error.
>>    
>>
>
>Yes, I understand that.
>
>  
>
>>Maybe contacting specific malinglists (e.g. for "broken" pci cards
>>the pci mailinglist, etc.), maintainers or developers would be more
>>efficient (cc the lkml) and solve your problem (faster), because
>>this people are specialists are this type of hardware (e.g. pci).
>>
>>What hardware is connect through irq 5?
>>    
>>
>
>In my case, my problem is not with irq 5, but with irq 10, as I
>mentioned earlier.
>
>The situation is this: I have an Asus A7V motherboard with 2 VIA
>vt82c686a controllers and 2 Promise PDC20265 controllers.
>
>I recently bought myself a new DVD recorder and since Alan Cox told
>me[*] that the Promise controllers had problems with ATAPI devices, I
>decided to arrange my system this way:
>
>/dev/hda: the DVD recorder (VIA controller, master)
>/dev/hdc: an old CD recorder (VIA controller, master)
>/dev/hde: my first HD (Promise controller, master)
>/dev/hdg: my second HD (Promise controller, master)
>
>The Promise controller is able to control the HDs (which now have
>exclusive 80-pin cables) at their maximum, but I get the following
>stack trace if I have /dev/hdg turned on:
>
>- - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - -
>ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 10 (level, low) -> IRQ 10
>PDC20265: chipset revision 2
>PDC20265: 100% native mode on irq 10
>PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
>    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
>    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
>Probing IDE interface ide2...
>hde: QUANTUM FIREBALL CX13.0A, ATA DISK drive
>ide2 at 0x8800-0x8807,0x8402 on irq 10
>Probing IDE interface ide3...
>hdg: QUANTUM FIREBALLlct15 30, ATA DISK drive
>irq 10: nobody cared!
> [<c0128fc1>] __report_bad_irq+0x31/0x77
> [<c012906b>] note_interrupt+0x4c/0x71
> [<c0128c86>] __do_IRQ+0x93/0xbd
> [<c0104635>] do_IRQ+0x19/0x24
> [<c010335a>] common_interrupt+0x1a/0x20
> [<c011935c>] __do_softirq+0x2c/0x7d
> [<c01193cf>] do_softirq+0x22/0x26
> [<c010463a>] do_IRQ+0x1e/0x24
> [<c010335a>] common_interrupt+0x1a/0x20
> [<c0128d89>] enable_irq+0x88/0x8d
> [<c021edc0>] probe_hwif+0x2da/0x366
> [<c021a137>] ata_attach+0xa3/0xbd
> [<c021ee5c>] probe_hwif_init_with_fixup+0x10/0x74
> [<c0221597>] ide_setup_pci_device+0x72/0x7f
> [<c0216f82>] pdc202xx_init_one+0x15/0x18
> [<c039182e>] ide_scan_pcidev+0x34/0x59
> [<c039186f>] ide_scan_pcibus+0x1c/0x88
> [<c039179f>] probe_for_hwifs+0xb/0xd
> [<c03917e5>] ide_init+0x44/0x59
> [<c037c6ce>] do_initcalls+0x4b/0x99
> [<c0100272>] init+0x0/0xce
> [<c0100299>] init+0x27/0xce
> [<c0101245>] kernel_thread_helper+0x5/0xb
>handlers:
>[<c021c2a6>] (ide_intr+0x0/0xee)
>Disabling IRQ #10
>irq 10: nobody cared!
>- - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - -
>
>This is just an excerpt of the messages. I can provide much more
>details if I know what is relevant.
>
>I had already posted some old dmesg logs at my site
><http://www.ime.usp.br/~rbrito/ide-problem/>, but this was before I
>got myself a second 80-ribbon cable (I expected that the problem would
>go away, but it didn't).
>
>Any other comments are more than welcome.
>
>
>Thanks in advance, Rogério Brito.
>
>[*] http://infocenter.guardiandigital.com/archive/linux-kernel/2004/Dec/2663.html
>  
>
Hi!
I'm not IDE specialist, but what about operating systems? Did you try a 
Windows or BSD CD (try it with a Windows 2000/XP CD, if you have one, 
else burn a NetBSD or FreeBSD/DragonflyBSD CD -- this is important to 
see if it's a linux bug or acpi bug)? Anyway this is very strange.

Good luck!
Matthias-Christian Ott
