Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWBTQdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWBTQdc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWBTQda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:33:30 -0500
Received: from dvhart.com ([64.146.134.43]:58275 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1161021AbWBTQdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:33:09 -0500
Message-ID: <43F9EF43.3020709@mbligh.org>
Date: Mon, 20 Feb 2006 08:33:07 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] some fixups for the X86_NUMAQ dependencies
References: <20060219232621.GC4971@stusta.de>
In-Reply-To: <20060219232621.GC4971@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> You must always ensure to fulfill the dependencies of what you are 
> select'ing.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  arch/i386/Kconfig |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.16-rc3-mm1-full/arch/i386/Kconfig.old	2006-02-20 00:12:50.000000000 +0100
> +++ linux-2.6.16-rc3-mm1-full/arch/i386/Kconfig	2006-02-20 00:17:57.000000000 +0100
> @@ -84,6 +84,7 @@
>  
>  config X86_NUMAQ
>  	bool "NUMAQ (IBM/Sequent)"
> +	select SMP
>  	select NUMA
>  	help
>  	  This option is used for getting Linux to run on a (IBM/Sequent) NUMA
> @@ -419,6 +420,7 @@

Surely NUMA should select SMP, not NUMA-Q?

>  config NOHIGHMEM
>  	bool "off"
> +	depends on !X86_NUMAQ
>  	---help---
>  	  Linux can use up to 64 Gigabytes of physical memory on x86 systems.
>  	  However, the address space of 32-bit x86 processors is only 4
> @@ -455,6 +457,7 @@
>  
>  config HIGHMEM4G
>  	bool "4GB"
> +	depends on !X86_NUMAQ
>  	help
>  	  Select this if you have a 32-bit processor and between 1 and 4
>  	  gigabytes of physical RAM.
> @@ -522,10 +525,6 @@
>  	default n if X86_PC
>  	default y if (X86_NUMAQ || X86_SUMMIT)
>  
> -# Need comments to help the hapless user trying to turn on NUMA support
> -comment "NUMA (NUMA-Q) requires SMP, 64GB highmem support"
> -	depends on X86_NUMAQ && (!HIGHMEM64G || !SMP)
> -

Hmm. ISTR the reason we put that in there in the first place was that
NUMA-Q got mysteriously hidden by other deps before, and it wasn't clear 
how to select it. Perhaps we just had some of the deps backwards.

M.
