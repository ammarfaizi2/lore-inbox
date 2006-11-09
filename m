Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWKIIkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWKIIkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 03:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWKIIkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 03:40:24 -0500
Received: from smtp.ono.com ([62.42.230.12]:30959 "EHLO resmaa02.ono.com")
	by vger.kernel.org with ESMTP id S932476AbWKIIkX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 03:40:23 -0500
Date: Thu, 9 Nov 2006 09:40:14 +0100
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Stephen.Clark@seclark.us
Cc: =?UTF-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
       Mark Lord <lkml@rtr.ca>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal PATA IDE performance
Message-ID: <20061109094014.1c8b6bed@werewolf-wl>
In-Reply-To: <4552A638.4010207@seclark.us>
References: <455206E7.2050104@seclark.us>
	<45526D50.5020105@rtr.ca>
	<455277E1.3040803@seclark.us>
	<20061109020758.GA21537@atjola.homenet>
	<4552A638.4010207@seclark.us>
X-Mailer: Claws Mail 2.6.0cvs17 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 22:53:28 -0500, Stephen Clark <Stephen.Clark@seclark.us> wrote:

> Björn Steinbrink wrote:
> 
> >On 2006.11.08 19:35:45 -0500, Stephen Clark wrote:
> >  
> >
> >>Mark Lord wrote:
> >>
> >>    
> >>
> >>>Remove the drivers/ide stuff from you system and let libata (ata_piix)
> >>>manage the ICH7.  That should speed things up quite a bit.
> >>>
> >>>-ml
> >>>
> >>>
> >>>
> >>>      
> >>>
> >>Isn't already enabled?
> >>
> >>ata_piix 0000:00:1f.2: version 2.00
> >>ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> >>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
> >>ata: 0x170 IDE port busy
> >>PCI: Setting latency timer of device 0000:00:1f.2 to 64
> >>ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
> >>scsi0 : ata_piix
> >>
> >>    
> >>
> >
> >Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> >ide: Assuming 33MHz system bus speed for PIO modes; override with
> >idebus=xx
> >ide0: I/O resource 0x1F0-0x1F7 not free.
> >ide0: ports already in use, skipping probe
> >Probing IDE interface ide1...
> >hdc: HTS721060G9AT00, ATA DISK drive
> >
> >Appears first and that's where the other driver has taken control of the
> >drives. I had the same issue on my thinkpad, getting rid of the whole
> >IDE stuff solved the problem (because the other drivers does no longer
> >grab the drive).
> >
> >This ThinkWiki entry should apply to your laptop just as well, just
> >replace /dev/hda with /dev/hdc.
> >http://www.thinkwiki.org/wiki/Problems_with_SATA_and_Linux#No_DMA_on_system_hard_disk
> >
> >  
> >
> >>also this laptop has nothing on ide0 - both the harddrive and dvdrom are 
> >>on ide1.
> >>is this confusing things?
> >>    
> >>
> >
> >Probably ide0 is pure SATA, while ide1 has the PATA adapters (just a
> >guess).
> >
> >Björn
> >
> >  
> >
> Thank Bjorn,
> 
> I tried this and the kernel couldn't find the root volumegroup - so i 
> got a kernel panic.
> I am not sure on how to tell the system the volumegroup is now on sd? 
> This is a
> fc6 installation.
> 

Probably your drives are renamed.
Before you had (wild guess, look at your boot log messages):
- ata bus -> hdc,hdd
- sata -> sda (if you really have any sata bus...)

Now all hdX become sdX, and PATA is detected _before_ SATA, so you names
probaly became:
- ata via libata -> sda (HD), sr0 (CDROM)
- sata -> sdb.

So boot with root=/dev/sda. And don't forget to update lilo/grub config.
And /dev/cdrom links if udev doesn't.

Hope this helps.

PD: It would be very nice if libata had some parameter like 'sata_before_pata=1'
or the like...

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.1 (Cooker) for i586
Linux 2.6.18-jam12 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP PREEMPT
