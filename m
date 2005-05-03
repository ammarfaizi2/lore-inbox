Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVECXGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVECXGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 19:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVECXGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 19:06:19 -0400
Received: from animx.eu.org ([216.98.75.249]:46216 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261899AbVECXGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 19:06:02 -0400
Date: Tue, 3 May 2005 19:05:32 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zImage on 2.6?
Message-ID: <20050503230532.GA13063@animx.eu.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050503012951.GA10459@animx.eu.org> <20050502193503.20e6ac6e.rddunlap@osdl.org> <20050503104503.GA11123@animx.eu.org> <20050503072626.3a3c7349.rddunlap@osdl.org> <20050503163343.GC11937@animx.eu.org> <20050503095913.1c9b62ba.rddunlap@osdl.org> <20050503221922.GC12199@animx.eu.org> <20050503153737.5e3627ad.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503153737.5e3627ad.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 3 May 2005 18:19:22 -0400 Wakko Warner wrote:
> 
> | Randy.Dunlap wrote:
> | > On Tue, 3 May 2005 12:33:43 -0400 Wakko Warner wrote:
> | > | Yes, I do recall it says "System is 724k".  zImage failes.  bzImage says
> | > | 724k as well and succeeds.
> | > 
> | > The image size needs to be <= 0x7f000 (520192 bytes, 508 KB).
> | > 
> | > (No, I don't know why, just that this is what is being
> | > enforced.)
> | > 
> | > Just cut more out of the kernel image...
> | 
> | Any suggestions?  All that I know of that is modularizable is a module,
> | except for keyboard, ext2, unix sockets, ramdisk+initrd.  Some of the options I need since
> | this is supposed to support all relevent hardware that we use where I work.
> | (all scsi,ide,sata,raid cards,ethernet cards that we have)
> 
> Are those (mostly) modular?

Yes.

> Is this supposed to be a kernel that is used on a regular basis,
> not just a temporary quick boot thing?

I'd say it would be used frequently, but short lived.

> You want one kernel that handles many configurations but fits
> in < 510 KB?  That is aggressive.  :)

=)  hehe, if I can.

> I think of this as being a custom kernel, but it sounds
> like you want a very general-purpose (small) one.

Yes, very custom.

> | Hmm, I did find one I forgot.  CONFIG_MII.
> | 
> | EXPERIMENTAL=y
> | CLEAN_COMPILE=y
> | BROKEN_ON_SMP=y
> 
> Do you need some drivers etc. that are EXPERIMENTAL or BROKEN?
> Just curious.

Actually, not sure, I've always enabled that.

> | ACPI=y
> | ACPI_BOOT=y
> | ACPI_INTERPRETER=y
> | ACPI_BUS=y
> | ACPI_EC=y
> | ACPI_POWER=y
> | ACPI_PCI=y
> | ACPI_SYSTEM=y
> so some systems may need ACPI ?

I wanted to beable to query battery life on laptops that I use this on.  I
can remove it I think, all ACPI that can be a module is.  I don't think it
works that way though.  I'll have to check it on a laptop.

> | ISA=y
> | CARDBUS=y
> | PCMCIA_PROBE=y
> some systems have ISA?  some are PCMCIA/CardBus?

Yes, however, pcmcia is modular.

> | PNP=y
> | ISAPNP=y
> and ISA PNP?  :(

We have some old ISA cards that support PNP (3c509 comes to mind)

> | SCSI_PROC_FS=y
> drop this one
> 
> | AIC7XXX_DEBUG_ENABLE=y
> | AIC7XXX_REG_PRETTY_PRINT=y
> | AIC79XX_DEBUG_ENABLE=y
> | AIC79XX_REG_PRETTY_PRINT=y
> drop these.

All SCSI is a module, these I assume are just capabilites in the modules.

> | SOUND_GAMEPORT=y
> drop.

Couldn't find a configure option to disable this.  It caught my eye too.  I
don't have gameport in input configured.

> | VT=y
> | VT_CONSOLE=y
> | HW_CONSOLE=y
> | VGA_CONSOLE=y
> | DUMMY_CONSOLE=y
> drop that ^^^^^

All of those or DUMMY_CONSOLE?

> | USB_ARCH_HAS_HCD=y
> | USB_ARCH_HAS_OHCI=y
> | USB_DEVICEFS=y
> | USB_OHCI_LITTLE_ENDIAN=y
> | USB_STORAGE_FREECOM=y
> | USB_STORAGE_ISD200=y
> | USB_STORAGE_DPCM=y
> | USB_STORAGE_USBAT=y
> | USB_STORAGE_SDDR09=y
> | USB_STORAGE_SDDR55=y
> | USB_STORAGE_JUMPSHOT=y
> | USB_HIDINPUT=y
> | USB_ALI_M5632=y
> | USB_AN2720=y
> | USB_BELKIN=y
> | USB_GENESYS=y
> | USB_NET1080=y
> | USB_PL2301=y
> | USB_KC2190=y
> | USB_ARMLINUX=y
> | USB_EPSON2888=y
> | USB_ZAURUS=y
> | USB_CDCETHER=y
> | USB_AX8817X=y
> | EXT2_FS=y
> | JOLIET=y
> | UDF_NLS=y
> | NTFS_RW=y
> drop NTFS (you didn't list it as a requirement :)

All USB are modules, NTFS is a module (yes I need it)

> | PROC_FS=y
> | SYSFS=y
> | TMPFS=y
> | RAMFS=y
> | NFS_V3=y
> | LOCKD_V4=y
> | MSDOS_PARTITION=y
> | DEBUG_KERNEL=y
> | MAGIC_SYSRQ=y
> | CRYPTO=y
> drop ^^^^^

Crypto is required by one of the wireless drivers (MADWIFI I believe)

> so what's the problem with using a bzImage kernel?

Nothing, I wanted to see if zImage would be smaller.  As others have stated,
it's not.  However, I did not know this.

I do appriate your time in helping me.  I'm real close to getting this on a
single floppy (if I formatted to 1.7mb, it would be easy.  I know some of
our systems that I would need this on can't use these).  One goal is to use
the same kernel for all booting.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
