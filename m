Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWGLHyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWGLHyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 03:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWGLHyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 03:54:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:40931 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750792AbWGLHyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 03:54:19 -0400
Message-ID: <44B4AAF9.1000706@manoweb.com>
Date: Wed, 12 Jul 2006 09:55:37 +0200
From: Alessio Sangalli <alesan@manoweb.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cardbus: revert IO window limit
References: <200607010003.31324.daniel.ritz-ml@swissonline.ch> <Pine.LNX.4.64.0606301516140.12404@g5.osdl.org> <200607010109.40486.daniel.ritz-ml@swissonline.ch> <Pine.LNX.4.64.0606301614470.12404@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606301614470.12404@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:98b9443de46bd48dbf34b16449aa5d76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Alessio, try Daniel's patch. We'd love to hear if it works, and in 
> particular what the dmesg output is (if it does work, it should print out 
> something like
> 
> 	PIIX4 ACPI PIO at 2000-203f
> 	PIIX4 SMB PIO at 2040-204f
> 
> and perhaps even a few "PIIX4 devres X" lines..)

this is the relevat dmesg output:

PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-103f claimed by PIIX4 ACPI
PCI quirk: region 1400-140f claimed by PIIX4 SMB
PIIX4 devres C PIO at 0398-0399
Boot video device is 0000:00:09.0
PCI: Using IRQ router PIIX/ICH [8086/7198] at 0000:00:07.0
PCI: Cannot allocate resource region 0 of device 0000:00:0b.0
PCI: BIOS reporting unknown device 00:01
PCI: BIOS reporting unknown device 00:02
PCI: Bus 1, cardbus bridge: 0000:00:08.0
  IO window: 00001c00-00001cff
  IO window: 00002000-000020ff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: setting IRQ 10 as level-triggered
PCI: Found IRQ 10 for device 0000:00:08.0

> Alessio, it might also make sense to try to enable ACPI if you haven't 
> done so - not because you need to use it, but because sometimes the ACPI 
> table parsing also ends up exposing these kinds of things..


It's not that I don't want ACPI, but if I enable it I only get:

ACPI: RSDP (v000 OID_00                                ) @ 0x000f0010
ACPI: RSDT (v001 OID_00 RSDT_000 0x30303030 <90>& 0x00010000) @ 0x0ffffbd0
ACPI: FADT (v001 OID_00 FACP_000 0x30303030 <90>& 0x00010000) @ 0x0ffffb20
ACPI: BOOT (v001 OID_00 BOOT_000 0x30303030 <90>& 0x00010000) @ 0x0ffffba0
ACPI: DSDT (v001 INT440 SYSFexxx 0x00001001 MSFT 0x0100000b) @ 0x00000000
ACPI: Vendor "INT440" System "SYSFexxx" Revision 0x1001 has a known ACPI
BIOS problem.
ACPI: Reason: Does not use _REG to protect EC OpRegions. This is a
non-recoverable error
ACPI: Disabling ACPI support
Allocating PCI resources starting at 20000000 (gap: 10000000:effc0000)


bye, thank you
Alessio Sangalli



