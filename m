Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWCDTEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWCDTEM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 14:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWCDTEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 14:04:12 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:937
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751090AbWCDTEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 14:04:11 -0500
Message-ID: <4409E4A8.70902@dark-green.com>
Date: Sat, 04 Mar 2006 20:04:08 +0100
From: gimli <gimli@dark-green.com>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: mactel-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Mactel-linux-devel] Re: [PATCH] /sys/firmware/efi/systab giving
 incorrect value for smbios
References: <20060304180018.GA3695@srcf.ucam.org> <20060304190026.GA4041@srcf.ucam.org>
In-Reply-To: <20060304190026.GA4041@srcf.ucam.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Do you have any idea why the kernel crashes on machines with more then 512 MB ram ?

cu

gimli

Matthew Garrett wrote:
> Or, as an alternative, remove the virtual to physical mapping that 
> efivars does. This requires fixing up IA64 to match. I've no idea which 
> approach is right.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> diff --git a/drivers/firmware/efivars.c b/drivers/firmware/efivars.c
> index bda5bce..ba598af 100644
> --- a/drivers/firmware/efivars.c
> +++ b/drivers/firmware/efivars.c
> @@ -575,7 +575,7 @@ systab_read(struct subsystem *entry, cha
>  	if (efi.acpi)
>  		str += sprintf(str, "ACPI=0x%lx\n", __pa(efi.acpi));
>  	if (efi.smbios)
> -		str += sprintf(str, "SMBIOS=0x%lx\n", __pa(efi.smbios));
> +		str += sprintf(str, "SMBIOS=0x%lx\n", efi.smbios);
>  	if (efi.hcdp)
>  		str += sprintf(str, "HCDP=0x%lx\n", __pa(efi.hcdp));
>  	if (efi.boot_info)
> diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
> index a3aa45c..ff3795b 100644
> --- a/arch/ia64/kernel/efi.c
> +++ b/arch/ia64/kernel/efi.c
> @@ -451,7 +451,7 @@ efi_init (void)
>  			efi.acpi = __va(config_tables[i].table);
>  			printk(" ACPI=0x%lx", config_tables[i].table);
>  		} else if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
> -			efi.smbios = __va(config_tables[i].table);
> +			efi.smbios = config_tables[i].table;
>  			printk(" SMBIOS=0x%lx", config_tables[i].table);
>  		} else if (efi_guidcmp(config_tables[i].guid, SAL_SYSTEM_TABLE_GUID) == 0) {
>  			efi.sal_systab = __va(config_tables[i].table);
> 

