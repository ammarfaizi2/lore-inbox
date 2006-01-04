Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965278AbWADTyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbWADTyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbWADTyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:54:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23050 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965185AbWADTyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:54:39 -0500
Date: Wed, 4 Jan 2006 20:54:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Eric Van Buggenhaut <ericvb@debian.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, mpm@selenic.com
Subject: Re: [hw_random] device not detected/patch
Message-ID: <20060104195438.GT3831@stusta.de>
References: <20060102000856.GA11491@alterna.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102000856.GA11491@alterna.homelinux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Jeff and Matt (Cc'ed) should hopefully be able to answer your questions.

cu
Adrian


On Mon, Jan 02, 2006 at 01:08:57AM +0100, Eric Van Buggenhaut wrote:
> I run a TP42 with 2.6.14.2
> 
> One of the pci device is
> 
> 0000:00:1e.0 0604: 8086:2448 (rev 81)
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=02, subordinate=08, sec-latency=64
>         I/O behind bridge: 00004000-00008fff
>         Memory behind bridge: c0200000-cfffffff
>         Prefetchable memory behind bridge: e8000000-efffffff
> 
> 
> discover sees it as a hw_random device
> 
> # grep 80862448 /lib/discover/pci.lst 
>         80862448        bridge  i810_rng        82801 Mobile PCI Bridge
> 
> 
> and tries to load i810_rng module when support is really in hw_random:
> 
> # cat drivers/char/hw_random.c
> [...]
> static struct pci_device_id rng_pci_tbl[] = {
>         { 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
>         { 0x1022, 0x746b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
> 
>         { 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
>         { 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
>         { 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
>         { 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
>         { 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
> 
>         { 0, }, /* terminate list */
> };
> 
> 
> device isn't detected though:
> 
> # modprobe hw_random
> FATAL: Error inserting hw_random (/lib/modules/2.6.14.2n/kernel/drivers/char/hw_random.ko): No such device
> 
> hw_random: RNG not detected
> 
> Why wouldn't module detect the device ?
> 
> 
> OTOH, pci.lst also lists device 80862430 as another RNG
> 
> # grep 80862430 /lib/discover/pci.lst 
>         80862430        bridge  i810_rng        82801AB PCI Bridge
> 
> but it's not listed in rng_pci_tbl[]
> 
> Does
> 
> --- drivers/char/hw_random.c.orig       2005-12-22 19:36:00.000000000 +0100
> +++ drivers/char/hw_random.c    2005-12-22 19:36:16.000000000 +0100
> @@ -155,6 +155,7 @@
>  
>         { 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
>         { 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
> +       { 0x8086, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
>         { 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
>         { 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
>         { 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
> 
> seem reasonable ?
> 
> Please CC me on reply
> 
> -- 
> Eric VAN BUGGENHAUT
> ericvb@debian.org
