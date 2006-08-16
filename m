Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWHPQHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWHPQHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWHPQHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:07:25 -0400
Received: from hera.kernel.org ([140.211.167.34]:43662 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750975AbWHPQHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:07:23 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH for review] [65/145] i386: Clean up code style in mpparse.c ACPI code
Date: Wed, 16 Aug 2006 12:08:43 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <20060810193620.EBC8913B90@wotan.suse.de>
In-Reply-To: <20060810193620.EBC8913B90@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161208.44087.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 15:36, Andi Kleen wrote:
> 
> Remove some unlinuxy ways to write function parameter definitions.
> Remove some stray "return;"s
> 
> No functional change.
> 
> Cc: len.brown@intel.com
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> ---
>  arch/i386/kernel/mpparse.c |   52 ++++++++++++++-------------------------------
>  1 files changed, 17 insertions(+), 35 deletions(-)

Maybe it is time to just Lindent the file?
When I Lindented the ACPI sub-system, I stopped short of mpparse.c.

As you know, I'd like to see the ACPI part of mpparse.c split out into a different file
that can be shared by i386 and x86_64.

Acked-by: Len Brown <len.brown@intel.com>


> Index: linux/arch/i386/kernel/mpparse.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/mpparse.c
> +++ linux/arch/i386/kernel/mpparse.c
> @@ -810,8 +810,7 @@ int es7000_plat;
>  
>  #ifdef CONFIG_ACPI
>  
> -void __init mp_register_lapic_address (
> -	u64			address)
> +void __init mp_register_lapic_address(u64 address)
>  {
>  	mp_lapic_addr = (unsigned long) address;
>  
> @@ -823,13 +822,10 @@ void __init mp_register_lapic_address (
>  	Dprintk("Boot CPU = %d\n", boot_cpu_physical_apicid);
>  }
>  
> -
> -void __devinit mp_register_lapic (
> -	u8			id, 
> -	u8			enabled)
> +void __devinit mp_register_lapic (u8 id, u8 enabled)
>  {
>  	struct mpc_config_processor processor;
> -	int			boot_cpu = 0;
> +	int boot_cpu = 0;
>  	
>  	if (MAX_APICS - id <= 0) {
>  		printk(KERN_WARNING "Processor #%d invalid (max %d)\n",
> @@ -866,11 +862,9 @@ static struct mp_ioapic_routing {
>  	u32			pin_programmed[4];
>  } mp_ioapic_routing[MAX_IO_APICS];
>  
> -
> -static int mp_find_ioapic (
> -	int			gsi)
> +static int mp_find_ioapic (int gsi)
>  {
> -	int			i = 0;
> +	int i = 0;
>  
>  	/* Find the IOAPIC that manages this GSI. */
>  	for (i = 0; i < nr_ioapics; i++) {
> @@ -883,15 +877,11 @@ static int mp_find_ioapic (
>  
>  	return -1;
>  }
> -	
>  
> -void __init mp_register_ioapic (
> -	u8			id, 
> -	u32			address,
> -	u32			gsi_base)
> +void __init mp_register_ioapic(u8 id, u32 address, u32 gsi_base)
>  {
> -	int			idx = 0;
> -	int			tmpid;
> +	int idx = 0;
> +	int tmpid;
>  
>  	if (nr_ioapics >= MAX_IO_APICS) {
>  		printk(KERN_ERR "ERROR: Max # of I/O APICs (%d) exceeded "
> @@ -937,16 +927,10 @@ void __init mp_register_ioapic (
>  		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,
>  		mp_ioapic_routing[idx].gsi_base,
>  		mp_ioapic_routing[idx].gsi_end);
> -
> -	return;
>  }
>  
> -
> -void __init mp_override_legacy_irq (
> -	u8			bus_irq,
> -	u8			polarity, 
> -	u8			trigger, 
> -	u32			gsi)
> +void __init
> +mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger, u32 gsi)
>  {
>  	struct mpc_config_intsrc intsrc;
>  	int			ioapic = -1;
> @@ -984,15 +968,13 @@ void __init mp_override_legacy_irq (
>  	mp_irqs[mp_irq_entries] = intsrc;
>  	if (++mp_irq_entries == MAX_IRQ_SOURCES)
>  		panic("Max # of irq sources exceeded!\n");
> -
> -	return;
>  }
>  
>  void __init mp_config_acpi_legacy_irqs (void)
>  {
>  	struct mpc_config_intsrc intsrc;
> -	int			i = 0;
> -	int			ioapic = -1;
> +	int i = 0;
> +	int ioapic = -1;
>  
>  	/* 
>  	 * Fabricate the legacy ISA bus (bus #31).
> @@ -1061,12 +1043,12 @@ void __init mp_config_acpi_legacy_irqs (
>  
>  #define MAX_GSI_NUM	4096
>  
> -int mp_register_gsi (u32 gsi, int triggering, int polarity)
> +int mp_register_gsi(u32 gsi, int triggering, int polarity)
>  {
> -	int			ioapic = -1;
> -	int			ioapic_pin = 0;
> -	int			idx, bit = 0;
> -	static int		pci_irq = 16;
> +	int ioapic = -1;
> +	int ioapic_pin = 0;
> +	int idx, bit = 0;
> +	static int pci_irq = 16;
>  	/*
>  	 * Mapping between Global System Interrups, which
>  	 * represent all possible interrupts, and IRQs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
