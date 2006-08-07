Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWHGP4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWHGP4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWHGP4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:56:45 -0400
Received: from xenotime.net ([66.160.160.81]:52376 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932191AbWHGP4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:56:44 -0400
Date: Mon, 7 Aug 2006 08:59:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Message-Id: <20060807085924.72f832af.rdunlap@xenotime.net>
In-Reply-To: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2006 09:26:21 -0600 Eric W. Biederman wrote:

> Currrently on a SMP system we can theoretically support
> NR_CPUS*224 irqs.  Unfortunately our data structures
> don't cope will with that many irqs, nor does hardware
> typically provide that many irq sources.
> 
> With the number of cores starting to follow Moores
> law, and the apicid limits being raised beyond an 8bit
> number trying to track our current maximum with our
> current data structures would be fatal and wasteful.
> 
> So this patch decouples the number of irqs we support
> from the number of cpus.  We can revisit this decision
> once someone reworks the current data structures.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  arch/x86_64/Kconfig      |   13 +++++++++++++
>  include/asm-x86_64/irq.h |    3 ++-
>  2 files changed, 15 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
> index 7598d99..d744e5b 100644
> --- a/arch/x86_64/Kconfig
> +++ b/arch/x86_64/Kconfig
> @@ -384,6 +384,19 @@ config NR_CPUS
>  	  This is purely to save memory - each supported CPU requires
>  	  memory in the static kernel configuration.
>  
> +config NR_IRQS
> +	int "Maximum number of IRQs (224-4096)"
> +	range 256 4096
> +	depends on SMP
> +	default "4096"
> +	help
> +	  This allows you to specify the maximum number of IRQs which this
> +	  kernel will support. Current maximum is 4096 IRQs as that
> +	  is slightly larger than has observed in the field.
> +
> +	  This is purely to save memory - each supported IRQ requires
> +	  memory in the static kernel configuration.

If (a) "nor does hardware typically provide that many irq sources"
and (b) "This is purely to save memory", why is the default
4096 instead of something smaller?

---
~Randy
