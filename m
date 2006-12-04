Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936774AbWLDMvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936774AbWLDMvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936740AbWLDMvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:51:43 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:2822 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S936600AbWLDMvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:51:41 -0500
Date: Mon, 4 Dec 2006 13:51:37 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Alan <alan@lxorguk.ukuu.org.uk>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]: first proposal for pci resume quirk interface
Message-Id: <20061204135137.f2877516.khali@linux-fr.org>
In-Reply-To: <20061114175510.6e7c7119@localhost.localdomain>
References: <20061114175510.6e7c7119@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, Carl-Daniel,

Any progress on this? I'd like to see this patch in -mm so that it gets
wider testing. One thing that needs to be fixed is that the Asus SMBus
quirks are currently ifdef'd out when suspend support (ACPI sleep
states) is enabled, so this part of the patch is not actually doing
anything. Alan, could you please fix this and resend the patch to
Andrew?

Thanks.

On Tue, 14 Nov 2006 17:55:10 +0000, Alan wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm1/arch/i386/pci/fixup.c linux-2.6.19-rc5-mm1/arch/i386/pci/fixup.c
> --- linux.vanilla-2.6.19-rc5-mm1/arch/i386/pci/fixup.c	2006-11-10 10:38:25.000000000 +0000
> +++ linux-2.6.19-rc5-mm1/arch/i386/pci/fixup.c	2006-11-14 15:13:03.000000000 +0000
> @@ -117,7 +117,7 @@
>  #define VIA_8363_KL133_REVISION_ID 0x81
>  #define VIA_8363_KM133_REVISION_ID 0x84
>  
> -static void __devinit pci_fixup_via_northbridge_bug(struct pci_dev *d)
> +static void pci_fixup_via_northbridge_bug(struct pci_dev *d)
>  {
>  	u8 v;
>  	u8 revision;
> @@ -153,6 +153,10 @@
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8622, pci_fixup_via_northbridge_bug);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8361, pci_fixup_via_northbridge_bug);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8367_0, pci_fixup_via_northbridge_bug);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8363_0, pci_fixup_via_northbridge_bug);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8622, pci_fixup_via_northbridge_bug);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8361, pci_fixup_via_northbridge_bug);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8367_0, pci_fixup_via_northbridge_bug);
>  
>  /*
>   * For some reasons Intel decided that certain parts of their
> @@ -183,7 +187,7 @@
>   * issue another HALT within 80 ns of the initial HALT, the failure condition
>   * is avoided.
>   */
> -static void __init pci_fixup_nforce2(struct pci_dev *dev)
> +static void pci_fixup_nforce2(struct pci_dev *dev)
>  {
>  	u32 val;
>  
> @@ -206,6 +210,7 @@
>  	}
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2, pci_fixup_nforce2);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2, pci_fixup_nforce2);
>  
>  /* Max PCI Express root ports */
>  #define MAX_PCIEROOT	6
> @@ -421,7 +426,7 @@
>   * Prevent the BIOS trapping accesses to the Cyrix CS5530A video device
>   * configuration space.
>   */
> -static void __devinit pci_early_fixup_cyrix_5530(struct pci_dev *dev)
> +static void pci_early_fixup_cyrix_5530(struct pci_dev *dev)
>  {
>  	u8 r;
>  	/* clear 'F4 Video Configuration Trap' bit */
> @@ -431,3 +436,5 @@
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_LEGACY,
>  			pci_early_fixup_cyrix_5530);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_LEGACY,
> +			pci_early_fixup_cyrix_5530);
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm1/drivers/pci/pci-driver.c linux-2.6.19-rc5-mm1/drivers/pci/pci-driver.c
> --- linux.vanilla-2.6.19-rc5-mm1/drivers/pci/pci-driver.c	2006-11-10 10:38:26.000000000 +0000
> +++ linux-2.6.19-rc5-mm1/drivers/pci/pci-driver.c	2006-11-14 15:29:20.000000000 +0000
> @@ -357,6 +357,8 @@
>  	struct pci_dev * pci_dev = to_pci_dev(dev);
>  	struct pci_driver * drv = pci_dev->driver;
>  
> +	pci_fixup_device(pci_fixup_resume, pci_dev);
> +	
>  	if (drv && drv->resume_early)
>  		error = drv->resume_early(pci_dev);
>  	return error;
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm1/drivers/pci/quirks.c linux-2.6.19-rc5-mm1/drivers/pci/quirks.c
> --- linux.vanilla-2.6.19-rc5-mm1/drivers/pci/quirks.c	2006-11-10 10:38:26.000000000 +0000
> +++ linux-2.6.19-rc5-mm1/drivers/pci/quirks.c	2006-11-14 15:44:23.000000000 +0000
> @@ -36,7 +36,7 @@
>  
>  /* Deal with broken BIOS'es that neglect to enable passive release,
>     which can cause problems in combination with the 82441FX/PPro MTRRs */
> -static void __devinit quirk_passive_release(struct pci_dev *dev)
> +static void quirk_passive_release(struct pci_dev *dev)
>  {
>  	struct pci_dev *d = NULL;
>  	unsigned char dlc;
> @@ -53,6 +53,7 @@
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release );
>  
>  /*  The VIA VP2/VP3/MVP3 seem to have some 'features'. There may be a workaround
>      but VIA don't answer queries. If you happen to have good contacts at VIA
> @@ -134,7 +135,7 @@
>   *	Updated based on further information from the site and also on
>   *	information provided by VIA 
>   */
> -static void __devinit quirk_vialatency(struct pci_dev *dev)
> +static void quirk_vialatency(struct pci_dev *dev)
>  {
>  	struct pci_dev *p;
>  	u8 rev;
> @@ -185,6 +186,10 @@
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency );
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency );
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,		quirk_vialatency );
> +/* Must restore this on a resume from RAM */
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,		quirk_vialatency );
>  
>  /*
>   *	VIA Apollo VP3 needs ETBF on BT848/878
> @@ -532,7 +537,7 @@
>   * TODO: When we have device-specific interrupt routers,
>   * this code will go away from quirks.
>   */
> -static void __devinit quirk_via_ioapic(struct pci_dev *dev)
> +static void quirk_via_ioapic(struct pci_dev *dev)
>  {
>  	u8 tmp;
>  	
> @@ -548,6 +553,7 @@
>  	pci_write_config_byte (dev, 0x58, tmp);
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic );
>  
>  /*
>   * VIA 8237: Some BIOSs don't set the 'Bypass APIC De-Assert Message' Bit.
> @@ -555,7 +561,7 @@
>   * Set this bit to get rid of cycle wastage.
>   * Otherwise uncritical.
>   */
> -static void __devinit quirk_via_vt8237_bypass_apic_deassert(struct pci_dev *dev)
> +static void quirk_via_vt8237_bypass_apic_deassert(struct pci_dev *dev)
>  {
>  	u8 misc_control2;
>  #define BYPASS_APIC_DEASSERT 8
> @@ -567,6 +573,7 @@
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt8237_bypass_apic_deassert);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt8237_bypass_apic_deassert);
>  
>  /*
>   * The AMD io apic can hang the box when an apic irq is masked.
> @@ -600,7 +607,7 @@
>  #define AMD8131_revB0        0x11
>  #define AMD8131_MISC         0x40
>  #define AMD8131_NIOAMODE_BIT 0
> -static void __init quirk_amd_8131_ioapic(struct pci_dev *dev) 
> +static void quirk_amd_8131_ioapic(struct pci_dev *dev) 
>  { 
>          unsigned char revid, tmp;
>          
> @@ -616,6 +623,7 @@
>          }
>  } 
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_ioapic);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_ioapic);
>  #endif /* CONFIG_X86_IO_APIC */
>  
>  
> @@ -720,13 +747,14 @@
>   * do this even if the Linux CardBus driver is not loaded, because
>   * the Linux i82365 driver does not (and should not) handle CardBus.
>   */
> -static void __devinit quirk_cardbus_legacy(struct pci_dev *dev)
> +static void quirk_cardbus_legacy(struct pci_dev *dev)
>  {
>  	if ((PCI_CLASS_BRIDGE_CARDBUS << 8) ^ dev->class)
>  		return;
>  	pci_write_config_dword(dev, PCI_CB_LEGACY_MODE_BASE, 0);
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_cardbus_legacy);
> +DECLARE_PCI_FIXUP_RESUME(PCI_ANY_ID, PCI_ANY_ID, quirk_cardbus_legacy);
>  
>  /*
>   * Following the PCI ordering rules is optional on the AMD762. I'm not
> @@ -735,7 +763,7 @@
>   * To be fair to AMD, it follows the spec by default, its BIOS people
>   * who turn it off!
>   */
> -static void __devinit quirk_amd_ordering(struct pci_dev *dev)
> +static void quirk_amd_ordering(struct pci_dev *dev)
>  {
>  	u32 pcic;
>  	pci_read_config_dword(dev, 0x4C, &pcic);
> @@ -749,6 +777,7 @@
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering );
>  
>  /*
>   *	DreamWorks provided workaround for Dunord I-3000 problem
> @@ -784,7 +813,7 @@
>   * datasheets found at http://www.national.com/ds/GX for info on what
>   * these bits do.  <christer@weinigel.se>
>   */
> -static void __init quirk_mediagx_master(struct pci_dev *dev)
> +static void quirk_mediagx_master(struct pci_dev *dev)
>  {
>  	u8 reg;
>  	pci_read_config_byte(dev, 0x41, &reg);
> @@ -795,13 +824,14 @@
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
>  
>  /*
>   *	Ensure C0 rev restreaming is off. This is normally done by
>   *	the BIOS but in the odd case it is not the results are corruption
>   *	hence the presence of a Linux check
>   */
> -static void __init quirk_disable_pxb(struct pci_dev *pdev)
> +static void quirk_disable_pxb(struct pci_dev *pdev)
>  {
>  	u16 config;
>  	u8 rev;
> @@ -817,6 +847,7 @@
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb );
>  
>  
>  /*
> @@ -874,7 +905,7 @@
>   * runs everywhere at present we suppress the printk output in most
>   * irrelevant cases.
>   */
> -static void __init k8t_sound_hostbridge(struct pci_dev *dev)
> +static void k8t_sound_hostbridge(struct pci_dev *dev)
>  {
>  	unsigned char val;
>  
> @@ -893,6 +924,7 @@
>  	}
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, k8t_sound_hostbridge);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, k8t_sound_hostbridge);
>  
>  #ifndef CONFIG_ACPI_SLEEP
>  /*
> @@ -1019,7 +1051,7 @@
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82915GM_HB, asus_hides_smbus_hostbridge );
>  
> -static void __init asus_hides_smbus_lpc(struct pci_dev *dev)
> +static void asus_hides_smbus_lpc(struct pci_dev *dev)
>  {
>  	u16 val;
>  	
> @@ -1042,8 +1074,14 @@
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_0,	asus_hides_smbus_lpc );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
>  
> -static void __init asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
> +static void asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
>  {
>  	u32 val, rcba;
>  	void __iomem *base;
> @@ -1059,13 +1097,14 @@
>  	printk(KERN_INFO "PCI: Enabled ICH6/i801 SMBus device\n");
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6 );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6 );
>  
>  #endif
>  
>  /*
>   * SiS 96x south bridge: BIOS typically hides SMBus device...
>   */
> -static void __init quirk_sis_96x_smbus(struct pci_dev *dev)
> +static void quirk_sis_96x_smbus(struct pci_dev *dev)
>  {
>  	u8 val = 0;
>  	printk(KERN_INFO "Enabling SiS 96x SMBus.\n");
> @@ -1086,7 +1125,7 @@
>  
>  #define SIS_DETECT_REGISTER 0x40
>  
> -static void __init quirk_sis_503(struct pci_dev *dev)
> +static void quirk_sis_503(struct pci_dev *dev)
>  {
>  	u8 reg;
>  	u16 devid;
> @@ -1122,13 +1161,14 @@
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_735,		quirk_sis_96x_compatible );
>  
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
>  /*
>   * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
>   * and MC97 modem controller are disabled when a second PCI soundcard is
>   * present. This patch, tweaking the VT8237 ISA bridge, enables them.
>   * -- bjd
>   */
> -static void __init asus_hides_ac97_lpc(struct pci_dev *dev)
> +static void asus_hides_ac97_lpc(struct pci_dev *dev)
>  {
>  	u8 val;
>  	int asus_hides_ac97 = 0;
> @@ -1159,6 +1199,14 @@
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
>  
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc );
> +
> +
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
> +
>  #if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
>  
>  /*
> @@ -1167,7 +1215,7 @@
>   *	the PCI scanning.
>   */
>  
> -static void __devinit quirk_jmicron_dualfn(struct pci_dev *pdev)
> +static void quirk_jmicron_dualfn(struct pci_dev *pdev)
>  {
>  	u32 conf;
>  	u8 hdr;
> @@ -1205,6 +1253,7 @@
>  }
>  
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
>  
>  #endif
>  
> @@ -1532,6 +1581,8 @@
>  extern struct pci_fixup __end_pci_fixups_final[];
>  extern struct pci_fixup __start_pci_fixups_enable[];
>  extern struct pci_fixup __end_pci_fixups_enable[];
> +extern struct pci_fixup __start_pci_fixups_resume[];
> +extern struct pci_fixup __end_pci_fixups_resume[];
>  
>  
>  void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
> @@ -1559,6 +1610,11 @@
>  		end = __end_pci_fixups_enable;
>  		break;
>  
> +	case pci_fixup_resume:
> +		start = __start_pci_fixups_resume;
> +		end = __end_pci_fixups_resume;
> +		break;
> +
>  	default:
>  		/* stupid compiler warning, you would think with an enum... */
>  		return;
> @@ -1596,7 +1652,7 @@
>   * Force it to be linked by setting the corresponding control bit in the
>   * config space.
>   */
> -static void __devinit quirk_nvidia_ck804_pcie_aer_ext_cap(struct pci_dev *dev)
> +static void quirk_nvidia_ck804_pcie_aer_ext_cap(struct pci_dev *dev)
>  {
>  	uint8_t b;
>  	if (pci_read_config_byte(dev, 0xf41, &b) == 0) {
> @@ -1610,6 +1666,8 @@
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
>  			quirk_nvidia_ck804_pcie_aer_ext_cap);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
> +			quirk_nvidia_ck804_pcie_aer_ext_cap);
>  
>  #ifdef CONFIG_PCI_MSI
>  /* To disable MSI globally */
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm1/include/asm-generic/vmlinux.lds.h linux-2.6.19-rc5-mm1/include/asm-generic/vmlinux.lds.h
> --- linux.vanilla-2.6.19-rc5-mm1/include/asm-generic/vmlinux.lds.h	2006-11-10 10:38:28.000000000 +0000
> +++ linux-2.6.19-rc5-mm1/include/asm-generic/vmlinux.lds.h	2006-11-14 16:06:08.000000000 +0000
> @@ -35,6 +35,9 @@
>  		VMLINUX_SYMBOL(__start_pci_fixups_enable) = .;		\
>  		*(.pci_fixup_enable)					\
>  		VMLINUX_SYMBOL(__end_pci_fixups_enable) = .;		\
> +		VMLINUX_SYMBOL(__start_pci_fixups_resume) = .;		\
> +		*(.pci_fixup_resume)					\
> +		VMLINUX_SYMBOL(__end_pci_fixups_resume) = .;		\
>  	}								\
>  									\
>  	/* RapidIO route ops */						\
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm1/include/linux/pci.h linux-2.6.19-rc5-mm1/include/linux/pci.h
> --- linux.vanilla-2.6.19-rc5-mm1/include/linux/pci.h	2006-11-10 10:38:28.000000000 +0000
> +++ linux-2.6.19-rc5-mm1/include/linux/pci.h	2006-11-14 15:44:11.000000000 +0000
> @@ -786,6 +804,7 @@
>  	pci_fixup_header,	/* After reading configuration header */
>  	pci_fixup_final,	/* Final phase of device fixups */
>  	pci_fixup_enable,	/* pci_enable_device() time */
> +	pci_fixup_resume,	/* pci_enable_device() time */
>  };
>  
>  /* Anonymous variables would be nice... */
> @@ -804,6 +823,9 @@
>  #define DECLARE_PCI_FIXUP_ENABLE(vendor, device, hook)			\
>  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_enable,			\
>  			vendor##device##hook, vendor, device, hook)
> +#define DECLARE_PCI_FIXUP_RESUME(vendor, device, hook)			\
> +	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume,			\
> +			resume##vendor##device##hook, vendor, device, hook)
>  
>  
>  void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Jean Delvare
