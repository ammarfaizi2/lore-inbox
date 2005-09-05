Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVIEF3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVIEF3m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 01:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVIEF3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 01:29:42 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:15622 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S932208AbVIEF3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 01:29:41 -0400
Message-ID: <431BD7D3.2090607@snapgear.com>
Date: Mon, 05 Sep 2005 15:29:55 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Brian Waite <waite@skycomputers.com>,
       paulus@samba.org, linuxppc-dev@ozlabs.org, matthew@wil.cx,
       grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       gerg@uclinux.org, davidm@snapgear.com, jeff@uclinux.org
Subject: Re: [RFC: 2.6 patch] remove some unused IDE stuff
References: <20050902001538.GH3657@stusta.de>
In-Reply-To: <20050902001538.GH3657@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Adrian Bunk wrote:
> This patch removes some dead IDE-related #define's and
> "static inline" functions.
> 
> Please double-check it since I've only tested it with grep and didn't 
> try compilation.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

I think the include/asm-m68knommu/ide.h should just be removed
altogether. None of the underlying code support for it has been
carried into 2.6, so it is pretty much useless.

Regards
Greg




> ---
> 
>  arch/ppc/platforms/hdpu.c   |   40 -----------------------------------
>  include/asm-m68knommu/ide.h |   41 ------------------------------------
>  include/asm-parisc/ide.h    |    5 ----
>  3 files changed, 86 deletions(-)
> 
> --- linux-2.6.13-mm1-full/arch/ppc/platforms/hdpu.c.old	2005-09-02 02:02:33.000000000 +0200
> +++ linux-2.6.13-mm1-full/arch/ppc/platforms/hdpu.c	2005-09-02 02:04:08.000000000 +0200
> @@ -608,46 +608,6 @@
>  	}
>  }
>  
> -#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
> -static int hdpu_ide_check_region(ide_ioreg_t from, unsigned int extent)
> -{
> -	return check_region(from, extent);
> -}
> -
> -static void
> -hdpu_ide_request_region(ide_ioreg_t from, unsigned int extent, const char *name)
> -{
> -	request_region(from, extent, name);
> -	return;
> -}
> -
> -static void hdpu_ide_release_region(ide_ioreg_t from, unsigned int extent)
> -{
> -	release_region(from, extent);
> -	return;
> -}
> -
> -static void __init
> -hdpu_ide_pci_init_hwif_ports(hw_regs_t * hw, ide_ioreg_t data_port,
> -			     ide_ioreg_t ctrl_port, int *irq)
> -{
> -	struct pci_dev *dev;
> -
> -	pci_for_each_dev(dev) {
> -		if (((dev->class >> 8) == PCI_CLASS_STORAGE_IDE) ||
> -		    ((dev->class >> 8) == PCI_CLASS_STORAGE_RAID)) {
> -			hw->irq = dev->irq;
> -
> -			if (irq != NULL) {
> -				*irq = dev->irq;
> -			}
> -		}
> -	}
> -
> -	return;
> -}
> -#endif
> -
>  void hdpu_heartbeat(void)
>  {
>  	if (mv64x60_read(&bh, MV64x60_GPP_VALUE) & (1 << 5))
> --- linux-2.6.13-mm1-full/include/asm-m68knommu/ide.h.old	2005-09-02 02:04:17.000000000 +0200
> +++ linux-2.6.13-mm1-full/include/asm-m68knommu/ide.h	2005-09-02 02:10:11.000000000 +0200
> @@ -141,47 +141,6 @@
>  
>  #define ide_init_default_irq(base)	ide_default_irq(base)
>  
> -static IDE_INLINE int
> -ide_request_irq(
> -	unsigned int irq,
> -	void (*handler)(int, void *, struct pt_regs *),
> -	unsigned long flags,
> -	const char *device,
> -	void *dev_id)
> -{
> -#ifdef CONFIG_COLDFIRE
> -	mcf_autovector(irq);
> -#endif
> -	return(request_irq(irq, handler, flags, device, dev_id));
> -}
> -
> -
> -static IDE_INLINE void
> -ide_free_irq(unsigned int irq, void *dev_id)
> -{
> -	free_irq(irq, dev_id);
> -}
> -
> -
> -static IDE_INLINE int
> -ide_check_region(ide_ioreg_t from, unsigned int extent)
> -{
> -	return 0;
> -}
> -
> -
> -static IDE_INLINE void
> -ide_request_region(ide_ioreg_t from, unsigned int extent, const char *name)
> -{
> -}
> -
> -
> -static IDE_INLINE void
> -ide_release_region(ide_ioreg_t from, unsigned int extent)
> -{
> -}
> -
> -
>  static IDE_INLINE void
>  ide_fix_driveid(struct hd_driveid *id)
>  {
> --- linux-2.6.13-mm1-full/include/asm-parisc/ide.h.old	2005-09-02 02:05:19.000000000 +0200
> +++ linux-2.6.13-mm1-full/include/asm-parisc/ide.h	2005-09-02 02:08:39.000000000 +0200
> @@ -20,11 +20,6 @@
>  #define IDE_ARCH_OBSOLETE_INIT
>  #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
>  
> -#define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
> -#define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
> -#define ide_check_region(from,extent)		check_region((from), (extent))
> -#define ide_request_region(from,extent,name)	request_region((from), (extent), (name))
> -#define ide_release_region(from,extent)		release_region((from), (extent))
>  /* Generic I/O and MEMIO string operations.  */
>  
>  #define __ide_insw	insw
> 
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
