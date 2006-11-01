Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946622AbWKAGSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946622AbWKAGSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946630AbWKAGSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:18:34 -0500
Received: from hera.kernel.org ([140.211.167.34]:52632 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1946622AbWKAGSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:18:32 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 51/61] PCI: Remove quirk_via_abnormal_poweroff
Date: Wed, 1 Nov 2006 01:20:12 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Karsten Wiese <annabellesgarden@yahoo.de>,
       Karsten Wiese <fzu@wemgehoertderstaat.de>,
       Bob Moore <robert.moore@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>
References: <20061101053340.305569000@sous-sol.org> <20061101054443.703982000@sous-sol.org>
In-Reply-To: <20061101054443.703982000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611010120.13639.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Len Brown <len.brown@intel.com>

On Wednesday 01 November 2006 00:34, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Karsten Wiese <annabellesgarden@yahoo.de>
> 
> My K8T800 mobo resumes fine from suspend to ram with and without patch
> applied against 2.6.18.
> 
> quirk_via_abnormal_poweroff makes some boards not boot 2.6.18, so IMO patch
> should go to head, 2.6.18.2 and everywhere "ACPI: ACPICA 20060623" has been
> applied.
> 
> 
> Remove quirk_via_abnormal_poweroff
> 
> Obsoleted by "ACPI: ACPICA 20060623":
> <snip>
>     Implemented support for "ignored" bits in the ACPI
>     registers.  According to the ACPI specification, these
>     bits should be preserved when writing the registers via
>     a read/modify/write cycle. There are 3 bits preserved
>     in this manner: PM1_CONTROL[0] (SCI_EN), PM1_CONTROL[9],
>     and PM1_STATUS[11].
>     http://bugzilla.kernel.org/show_bug.cgi?id=3691
> </snip>
> 
> Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
> Cc: Bob Moore <robert.moore@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Acked-by: Dave Jones <davej@redhat.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  drivers/pci/quirks.c |   27 ---------------------------
>  1 file changed, 27 deletions(-)
> 
> --- linux-2.6.18.1.orig/drivers/pci/quirks.c
> +++ linux-2.6.18.1/drivers/pci/quirks.c
> @@ -685,33 +685,6 @@ static void __devinit quirk_vt82c598_id(
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id );
>  
> -#ifdef CONFIG_ACPI_SLEEP
> -
> -/*
> - * Some VIA systems boot with the abnormal status flag set. This can cause
> - * the BIOS to re-POST the system on resume rather than passing control
> - * back to the OS.  Clear the flag on boot
> - */
> -static void __devinit quirk_via_abnormal_poweroff(struct pci_dev *dev)
> -{
> -	u32 reg;
> -
> -	acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1_STATUS,
> -				&reg);
> -
> -	if (reg & 0x800) {
> -		printk("Clearing abnormal poweroff flag\n");
> -		acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
> -					ACPI_REGISTER_PM1_STATUS,
> -					(u16)0x800);
> -	}
> -}
> -
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8235, quirk_via_abnormal_poweroff);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, quirk_via_abnormal_poweroff);
> -
> -#endif
> -
>  /*
>   * CardBus controllers have a legacy base address that enables them
>   * to respond as i82365 pcmcia controllers.  We don't want them to
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
