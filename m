Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSLaX1d>; Tue, 31 Dec 2002 18:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbSLaX1d>; Tue, 31 Dec 2002 18:27:33 -0500
Received: from are.twiddle.net ([64.81.246.98]:898 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S264875AbSLaX1c>;
	Tue, 31 Dec 2002 18:27:32 -0500
Date: Tue, 31 Dec 2002 15:35:39 -0800
From: Richard Henderson <rth@twiddle.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] arch/alpha: Makefiles update
Message-ID: <20021231153539.A21946@twiddle.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021230115336.GA1089@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021230115336.GA1089@mars.ravnborg.org>; from sam@ravnborg.org on Mon, Dec 30, 2002 at 12:53:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 12:53:36PM +0100, Sam Ravnborg wrote:
> +# If ALPHA_GENERIC, make sure to turn off any instruction set extensions
> +# that the host compiler might have on by default. Given that EV4 and EV5
> +# have the same instruction set, prefer EV5 because an EV5 schedule is
> +# more likely to keep an EV4 processor busy than vice-versa.
> + 
> +# Default value
> +mach-yy := ev56
> +mach-$(have_mcpu_pca56)$(have_mcpu_pca56)	:= pca56
> +
> +#Machine depedent values, influenced by gcc capabilitites
> +mach-$(CONFIG_ALPHA_SX164)$(have_mcpu_pca56)	:= pca56
> +mach-$(CONFIG_ALPHA_POLARIS)$(have_mcpu_pca56)	:= pca56
> +mach-$(CONFIG_ALPHA_EV67)$(have_mcpu_ev67)	:= ev67
> +
> +mach-y				:= $(mach-yy)
> +mach-$(CONFIG_ALPHA_GENERIC)	:= ev5
> +mach-$(CONFIG_ALPHA_EV4)	:= ev4
> +mach-$(CONFIG_ALPHA_EV56)	:= ev56
> +mach-$(CONFIG_ALPHA_EV5)	:= ev5
> +mach-$(CONFIG_ALPHA_EV6)	:= ev6

This doesn't work.   For example CONFIG_ALPHA_EV67 depends on
CONFIG_ALPHA_EV6, so we'll never use the -mcpu=ev67 flag.

I'm reverting this part.  I see nothing wrong with an if/else
tree for this.  It's straightforward.  I think anything you come
up with to replace it will be harder to understand at a glance,
and therefore more fragile.


> +# My special boot (msb) writes directly to a specific disk partition,
> +# I doubt most people will want to do that without changes..
> +msb srmboot: vmlinux
> +	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(boot) $@

I've just removed these targets.

I'm testing the rest of the patch now.  Will apply if successful.


r~
