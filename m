Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWHPSMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWHPSMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHPSMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:12:50 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2572 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932175AbWHPSMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:12:49 -0400
Date: Wed, 16 Aug 2006 20:12:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [patch 2/5] -fstack-protector feature: Add the Kconfig option
Message-ID: <20060816181246.GE7813@stusta.de>
References: <1155746902.3023.63.camel@laptopd505.fenrus.org> <1155747038.3023.67.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155747038.3023.67.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 06:50:38PM +0200, Arjan van de Ven wrote:
> Subject: [patch 2/5] Add the Kconfig option for the stackprotector feature
> From: Arjan van de Ven <arjan@linux.intel.com>
> 
> This patch adds the config options for -fstack-protector.
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> CC: Andi Kleen <ak@suse.de>
> 
> ---
>  arch/x86_64/Kconfig |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> Index: linux-2.6.18-rc4-stackprot/arch/x86_64/Kconfig
> ===================================================================
> --- linux-2.6.18-rc4-stackprot.orig/arch/x86_64/Kconfig
> +++ linux-2.6.18-rc4-stackprot/arch/x86_64/Kconfig
> @@ -522,6 +522,30 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config CC_STACKPROTECTOR
> +	bool "Enable -fstack-protector buffer overflow detection (EXPRIMENTAL)"
> +	depends on EXPERIMENTAL
> +	help
> +         This option turns on the -fstack-protector GCC feature. This
> +	  feature puts, at the beginning of critical functions, a canary
> +	  value on the stack just before the return address, and validates
> +	  the value just before actually returning.  Stack based buffer
> +	  overflows (that need to overwrite this return address) now also
> +	  overwrite the canary, which gets detected and the attack is then
> +	  neutralized via a kernel panic.
> +
> +	  This feature requires gcc version 4.2 or above, or a distribution
> +	  gcc with the feature backported. Older versions are automatically
> +	  detected and for those versions, this configuration option is ignored.
>...

Please add something like

	This feature adds some extra security with a moderate
	performance overhead.

to make it easier for a user to decide whether or not to enable this 
option.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

