Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWARMPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWARMPi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWARMPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:15:38 -0500
Received: from relay.bostream.com ([81.26.227.9]:23263 "EHLO
	endeavour.mit.um.bostream.net") by vger.kernel.org with ESMTP
	id S1030291AbWARMPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:15:37 -0500
Message-ID: <43CE3163.60303@letterboxes.org>
Date: Wed, 18 Jan 2006 13:15:31 +0100
From: =?UTF-8?B?Q2hyaXN0ZXIgQsOkY2tzdHLDtm0=?= 
	<cbackstrom@letterboxes.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.1.20060mdk (X11/20050322)
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amd64 cdrom access locks system
References: <S1750841AbWAQXWc/20060117232242Z+104@vger.kernel.org>	 <43CD8C64.4080909@letterboxes.org> <1137575882.25819.8.camel@localhost.localdomain>
In-Reply-To: <1137575882.25819.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox skrev:
> On Mer, 2006-01-18 at 01:31 +0100, Christer Bäckström wrote:
> 
>>ALi Corporation M5229 IDE (rev c7)
>>
>>The cd-writer locks up if the DMA is enabled, as above. But the drive is 
>>usable if it is disabled.
> 
> 
> Under what circumstances does the writer lock - when writing or in
> general ?
> 
> 

It locks while writing and using DMA. I get the errors:

ide-cd: cmd 0x3 timed out
hdc: lost interrupt

And the cd-writer hangs. Disabling DMA makes it possible to write
(slowly, and only after rebooting). Reading always works. Other
functions also works while using DMA, like "cdrecord -checkdrive" or
"cdrecord -scanbus". However not things like "cdrecord -dummy".

A few snippets:
-------
lspci -v:
-------
00:1f.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if 8a 
[Master SecP PriP])
	Subsystem: Unknown device 1631:c00e
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 255
	I/O ports at 1100 [size=16]
	Capabilities: [60] Power Management version 2
-------

dmesg:
-------
Bootdata ok (command line is BOOT_IMAGE=2615 root=306 noinitrd 
hdc=ide-cdrom resume=/dev/hda5 resume2=/dev/hda5 splash=silent 3)
Linux version 2.6.15 (root@localhost) (gcc version 4.0.1 (4.0.1-5mdk for 
Mandriva Linux release 2006.0)) #7 PREEMPT Sun Jan 8 18:23:09 CET 2006
...
CPU: AMD Turion(tm) 64 Mobile Technology ML-30 stepping 02
...
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:1f.0
ACPI: PCI Interrupt 0000:00:1f.0[A]: no GSI
ALI15X3: chipset revision 199
ALI15X3: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD800UE-00HCT0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD+/-RW ND-6650A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, 
UDMA(100)
hda: cache flushes supported
  hda: hda1 hda2 hda3 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
-------

The irq and ioports in the dmesg are the same as presented in windows, 
if that helps in any way. Bartlomiej Zolnierkiewicz pointed out there 
are a bugzilla entry for this:

http://bugzilla.kernel.org/show_bug.cgi?id=5786

I'm going to look into the posts 'til tomorrow, and continue with this 
problem over there.

Cheers,

/Chris

-- 
Dr. Chris Backstrom, BSc, PhD.

