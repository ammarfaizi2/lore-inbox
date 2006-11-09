Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753472AbWKICIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbWKICIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 21:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbWKICIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 21:08:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:24741 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1753472AbWKICIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 21:08:01 -0500
X-Authenticated: #5039886
Date: Thu, 9 Nov 2006 03:07:58 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: Mark Lord <lkml@rtr.ca>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal PATA IDE performance
Message-ID: <20061109020758.GA21537@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Stephen Clark <Stephen.Clark@seclark.us>, Mark Lord <lkml@rtr.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca> <455277E1.3040803@seclark.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <455277E1.3040803@seclark.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.11.08 19:35:45 -0500, Stephen Clark wrote:
> Mark Lord wrote:
> 
> >Remove the drivers/ide stuff from you system and let libata (ata_piix)
> >manage the ICH7.  That should speed things up quite a bit.
> >
> >-ml
> >
> > 
> >
> Isn't already enabled?
> 
> ata_piix 0000:00:1f.2: version 2.00
> ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
> ata: 0x170 IDE port busy
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
> scsi0 : ata_piix
> 

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdc: HTS721060G9AT00, ATA DISK drive

Appears first and that's where the other driver has taken control of the
drives. I had the same issue on my thinkpad, getting rid of the whole
IDE stuff solved the problem (because the other drivers does no longer
grab the drive).

This ThinkWiki entry should apply to your laptop just as well, just
replace /dev/hda with /dev/hdc.
http://www.thinkwiki.org/wiki/Problems_with_SATA_and_Linux#No_DMA_on_system_hard_disk

> also this laptop has nothing on ide0 - both the harddrive and dvdrom are 
> on ide1.
> is this confusing things?

Probably ide0 is pure SATA, while ide1 has the PATA adapters (just a
guess).

Björn
