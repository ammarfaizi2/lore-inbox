Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946619AbWKAGSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946619AbWKAGSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946622AbWKAGSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:18:24 -0500
Received: from hera.kernel.org ([140.211.167.34]:51352 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1946619AbWKAGSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:18:23 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 41/61] x86-64: Fix C3 timer test
Date: Wed, 1 Nov 2006 01:19:56 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Andi Kleen <ak@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
References: <20061101053340.305569000@sous-sol.org> <20061101054241.885074000@sous-sol.org>
In-Reply-To: <20061101054241.885074000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611010119.57463.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Len Brown <len.brown@intel.com>

On Wednesday 01 November 2006 00:34, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Andi Kleen <ak@suse.de>
> 
> There was a typo in the C3 latency test to decide of the TSC
> should be used or not. It used the C2 latency threshold, not the
> C3 one. Fix that.
> 
> This should fix the time on various dual core laptops.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> 
> ---
>  arch/x86_64/kernel/time.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.18.1.orig/arch/x86_64/kernel/time.c
> +++ linux-2.6.18.1/arch/x86_64/kernel/time.c
> @@ -960,7 +960,7 @@ __cpuinit int unsynchronized_tsc(void)
>   	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
>  #ifdef CONFIG_ACPI
>  		/* But TSC doesn't tick in C3 so don't use it there */
> -		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 100)
> +		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 1000)
>  			return 1;
>  #endif
>   		return 0;
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
