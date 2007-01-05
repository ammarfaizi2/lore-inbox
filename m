Return-Path: <linux-kernel-owner+w=401wt.eu-S1161024AbXAEIwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbXAEIwf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 03:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbXAEIwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 03:52:35 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:1922 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161024AbXAEIwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 03:52:34 -0500
Date: Fri, 5 Jan 2007 09:52:33 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Re: [-mm patch] drivers/pci/quirks.c: cleanup
Message-Id: <20070105095233.4ce72e7e.khali@linux-fr.org>
In-Reply-To: <20061219041315.GE6993@stusta.de>
References: <20061219041315.GE6993@stusta.de>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, 19 Dec 2006 05:13:15 +0100, Adrian Bunk wrote:
> This patch contains the following cleanups:
> - move all EXPORT_SYMBOL's directly below the code they are exporting
> - move all DECLARE_PCI_FIXUP_*'s directly below the functions they
>   are calling

Thanks for doing this cleanup, it was really needed. I think you didn't
get everything right though:

> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/pci/pci.c    |    4 ----
>  drivers/pci/quirks.c |   42 +++++++++++++++++-------------------------
>  2 files changed, 17 insertions(+), 29 deletions(-)
> 
> --- linux-2.6.20-rc1-mm1/drivers/pci/quirks.c.old	2006-12-19 04:12:39.000000000 +0100
> +++ linux-2.6.20-rc1-mm1/drivers/pci/quirks.c	2006-12-19 04:59:22.000000000 +0100
> @@ -61,7 +61,8 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_I
>      
>      This appears to be BIOS not version dependent. So presumably there is a 
>      chipset level fix */
> -int isa_dma_bridge_buggy;		/* Exported */
> +int isa_dma_bridge_buggy;
> +EXPORT_SYMBOL(isa_dma_bridge_buggy);
>      
>  static void __devinit quirk_isa_dma_hangs(struct pci_dev *dev)
>  {
> @@ -83,6 +84,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NE
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs );
>  
>  int pci_pci_problems;
> +EXPORT_SYMBOL(pci_pci_problems);
>  
>  /*
>   *	Chipsets where PCI->PCI transfers vanish or hang
> @@ -94,6 +96,8 @@ static void __devinit quirk_nopcipci(str
>  		pci_pci_problems |= PCIPCI_FAIL;
>  	}
>  }
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci );
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci );
>  
>  static void __devinit quirk_nopciamd(struct pci_dev *dev)
>  {
> @@ -105,9 +109,6 @@ static void __devinit quirk_nopciamd(str
>  		pci_pci_problems |= PCIAGP_FAIL;
>  	}
>  }
> -
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci );
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci );
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd );
>  
>  /*
> @@ -1122,6 +1123,14 @@ static void quirk_sis_96x_smbus(struct p
>  	pci_write_config_byte(dev, 0x77, val & ~0x10);
>  	pci_read_config_byte(dev, 0x77, &val);
>  }
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
>  
>  /*
>   * ... This is further complicated by the fact that some SiS96x south
> @@ -1158,6 +1167,8 @@ static void quirk_sis_503(struct pci_dev
>  	 */
>  	dev->device = devid;
>  }
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );

Was this patch tested on the SiS-based boards which need these quirks?
I think you broke them. If I remember correctly, quirk_sis_503() must
be called before quirk_sis_96x_smbus() for some boards to work
properly, and we currently rely on the linking order to guarantee that.
Likewise, quirk_sis_96x_compatible() should be called before
quirk_sis_503() otherwise the warning message in quirk_sis_503() will
no longer be correct.

So if you want to put the calls right after the quirk functions, you
need to reorder the functions themselves as well. Feel free to add a
comment explaining the order requirement so that nobody breaks it
accidentally again in the future.

>  
>  static void __init quirk_sis_96x_compatible(struct pci_dev *dev)
>  {
> @@ -1170,8 +1181,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_651,		quirk_sis_96x_compatible );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_735,		quirk_sis_96x_compatible );
>  
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
> -DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
>  /*
>   * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
>   * and MC97 modem controller are disabled when a second PCI soundcard is
> @@ -1202,21 +1211,8 @@ static void asus_hides_ac97_lpc(struct p
>  	}
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc );
> -
> -
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
> -
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc );
>  
> -
> -DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
> -DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
> -DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
> -DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
> -
>  #if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
>  
>  /*
> @@ -1261,7 +1257,6 @@ static void quirk_jmicron_dualfn(struct 
>  			break;
>  	}
>  }
> -
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
>  
> @@ -1405,6 +1400,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
>  
>  
>  int pcie_mch_quirk;
> +EXPORT_SYMBOL(pcie_mch_quirk);
>  
>  static void __devinit quirk_pcie_mch(struct pci_dev *pdev)
>  {
> @@ -1649,6 +1645,7 @@ void pci_fixup_device(enum pci_fixup_pas
>  	}
>  	pci_do_fixups(dev, start, end);
>  }
> +EXPORT_SYMBOL(pci_fixup_device);
>  
>  /* Enable 1k I/O space granularity on the Intel P64H2 */
>  static void __devinit quirk_p64h2_1k_io(struct pci_dev *dev)
> @@ -1791,8 +1788,3 @@ static void __devinit quirk_nvidia_ck804
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
>  			quirk_nvidia_ck804_msi_ht_cap);
>  #endif /* CONFIG_PCI_MSI */
> -
> -EXPORT_SYMBOL(pcie_mch_quirk);
> -#ifdef CONFIG_HOTPLUG
> -EXPORT_SYMBOL(pci_fixup_device);
> -#endif
> --- linux-2.6.20-rc1-mm1/drivers/pci/pci.c.old	2006-12-19 04:15:52.000000000 +0100
> +++ linux-2.6.20-rc1-mm1/drivers/pci/pci.c	2006-12-19 04:16:00.000000000 +0100
> @@ -1210,7 +1210,3 @@ EXPORT_SYMBOL(pci_save_state);
>  EXPORT_SYMBOL(pci_restore_state);
>  EXPORT_SYMBOL(pci_enable_wake);
>  
> -/* Quirk info */
> -
> -EXPORT_SYMBOL(isa_dma_bridge_buggy);
> -EXPORT_SYMBOL(pci_pci_problems);
> -

Thanks,
-- 
Jean Delvare
