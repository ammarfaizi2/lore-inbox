Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWHANEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWHANEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWHANEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:04:47 -0400
Received: from relay6.ptmail.sapo.pt ([212.55.154.26]:48302 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1751128AbWHANEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:04:46 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.3
Subject: Re: [PATCH for 2.6.18] [2/8] x86_64: On Intel systems when CPU has
	C3 don't use TSC
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <44cbba2d.ejpOKfo7QfGElmoT%ak@suse.de>
References: <44cbba2d.ejpOKfo7QfGElmoT%ak@suse.de>
Content-Type: text/plain; charset=utf-8
Date: Tue, 01 Aug 2006 14:04:43 +0100
Message-Id: <1154437483.3264.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 21:42 +0200, Andi Kleen wrote:
> On Intel systems generally the TSC stops in C3 or deeper, 
> so don't use it there. Follows similar logic on i386.
> 
> This should fix problems on Meroms.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
...
> +	/* Most intel systems have synchronized TSCs except for
> +	   multi node systems */
> + 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
> +#ifdef CONFIG_ACPI
> +		/* But TSC doesn't tick in C3 so don't use it there */
> +		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 100)
> +			return 1;
> +#endif
> + 		return 0;
> +	}
> +
>   	/* Assume multi socket systems are not synchronized */
>   	return num_present_cpus() > 1;
>  }

Hi, 

I had some faith in this patch , but this just enable boot parameter
notsc (which I already use). And "just" disable tsc don't solve all the
problems. 

After "Using ACPI (MADT) for SMP configuration information"
my acpi_fadt.length is great than  0
acpi_fadt.plvl3_lat is 1001

On BIOS 1.40 update description of ASRock, claims this VIA chipset have
C1 stepping support.

this is a Pentium Dual Core on a 775Dual-880Pro
http://www.asrock.com/product/775Dual-880Pro.htm
http://bugme.osdl.org/show_bug.cgi?id=6419

Thanks,
Sérgio M. B.

