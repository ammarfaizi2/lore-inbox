Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWG2Rsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWG2Rsu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 13:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWG2Rsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 13:48:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3858 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932191AbWG2Rsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 13:48:40 -0400
Date: Sat, 29 Jul 2006 19:48:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
Message-ID: <20060729174840.GE26963@stusta.de>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <1154102627.6416.13.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154102627.6416.13.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 06:03:46PM +0200, Arjan van de Ven wrote:
>...
> --- linux-2.6.18-rc2-git5-stackprot.orig/arch/x86_64/Kconfig
> +++ linux-2.6.18-rc2-git5-stackprot/arch/x86_64/Kconfig
> @@ -522,6 +522,31 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config CC_STACKPROTECTOR
> +	bool "Enable -fstack-protector buffer overflow detection (EXPRIMENTAL)"
> +	depends on EXPERIMENTAL
> +	default n

You can remove the "default n".

> +	help
> +	  This option turns on the -fstack-protector GCC feature that is new
> +	  in GCC version 4.1. This feature puts, at the beginning of
> +	  critical functions, a canary value on the stack just before the return
> +	  address, and validates the value just before actually returning.
> +	  Stack based buffer overflows that need to overwrite this return
> +	  address now also overwrite the canary, which gets detected.
> +
> +	  NOTE 
> +	  This feature requires gcc version 4.2 or above, or a distribution
> +	  gcc with the feature backported. For older gcc versions, this is a NOP.

After reading this thread, I do understand why you write once 
"GCC version 4.1" and once "gcc version 4.2".

But for the normal user this will be quite confusing.

What about simply removing the first sentence of the help text since 
it's anyway handled by the NOTE?

> +config CC_STACKPROTECTOR_ALL
> +	bool "Use stack-protector for all functions"
> +	depends on CC_STACKPROTECTOR
> +	default n

You can remove the "default n".

> +	help
> +	  Normally, GCC only inserts the canary value protection for
> +	  functions that use large-ish on-stack buffers. By enabling
> +	  this option, GCC will be asked to do this for ALL functions.
> +

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

