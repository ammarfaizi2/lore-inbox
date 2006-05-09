Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWEIKFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWEIKFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 06:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWEIKFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 06:05:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5901 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751485AbWEIKFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 06:05:45 -0400
Date: Tue, 9 May 2006 12:05:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 01/35] Add XEN config options and disable unsupported config options.
Message-ID: <20060509100547.GL3570@stusta.de>
References: <20060509084945.373541000@sous-sol.org> <20060509085145.790527000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085145.790527000@sous-sol.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:00:01AM -0700, Chris Wright wrote:
>...
> --- linus-2.6.orig/arch/i386/Kconfig
> +++ linus-2.6/arch/i386/Kconfig
>...
>  config X86_IO_APIC
>  	bool
> -	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER))
> +	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER || X86_XEN))
>  	default y
>...

<nitpick>not required</nitpick>

> --- linus-2.6.orig/kernel/Kconfig.hz
> +++ linus-2.6/kernel/Kconfig.hz
> @@ -3,7 +3,7 @@
>  #
>  
>  choice
> -	prompt "Timer frequency"
> +	prompt "Timer frequency" if !XEN
>  	default HZ_250
>  	help
>  	 Allows the configuration of the timer frequency. It is customary
> @@ -40,7 +40,7 @@ endchoice
>  
>  config HZ
>  	int
> -	default 100 if HZ_100
> +	default 100 if HZ_100 || XEN
>  	default 250 if HZ_250
>  	default 1000 if HZ_1000
>...

Why?
  
cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

