Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbTJXVCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 17:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTJXVCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 17:02:20 -0400
Received: from [63.226.249.57] ([63.226.249.57]:14526 "EHLO nymph.dleonard.net")
	by vger.kernel.org with ESMTP id S262626AbTJXVCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 17:02:12 -0400
Date: Fri, 24 Oct 2003 14:27:32 -0700 (PDT)
From: <dleonard@dleonard.net>
To: Pavel Roskin <proski@gnu.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Copying .config to /lib/modules/`uname -r`/kernel
In-Reply-To: <Pine.LNX.4.58.0310240406230.17536@portland.hansa.lan>
Message-ID: <Pine.LNX.4.31.0310241423120.24862-100000@nymph.dleonard.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Personally I like to put it in the same place as the kernel itself and the
System.map.  Then I tack the full version number on the end just like I do
with System.map.  Even for non-modular kernels it is frequently convenient
to have access to the .config so when you boot up a random isolinux CD you
know exactly what support you are going to have.

-- 

<Douglas Leonard>
<dleonard@dleonard.net>

On Fri, 24 Oct 2003, Pavel Roskin wrote:

> Hello!
>
> Many drivers are developed outside the kernel tree.  Many drivers start
> their existence as separate projects.  It's essential that they are tested
> by the users of particular hardware, even if those users don't want to
> recompile their kernels.
>
> There should be a standard place for .config in kernel packages.
> /proc/config.gz may or may not be popular with distributors.  Besides, it
> only gives information for the currently running kernel, but not for e.g.
> newly upgraded kernel before the reboot.
>
> Cannot we just install .config to the same directory as modules?  If the
> kernel doesn't support modules, then there is no point to compile any new
> modules against it.  But if it does, then we can be sure that the modules
> correspond to that configuration file, because the modules and .config
> would be installed by the same command.
>
> That's why I prefer the "kernel" subdirectory.  It's fully replaced by
> "make modules_install", so that the old .config will go away for sure.
>
> Patch against 2.6.0-test8
> =====================
> --- Makefile
> +++ Makefile
> @@ -690,6 +690,7 @@
>  	@rm -rf $(MODLIB)/kernel
>  	@rm -f $(MODLIB)/build
>  	@mkdir -p $(MODLIB)/kernel
> +	@cp -f .config $(MODLIB)/kernel
>  	@ln -s $(TOPDIR) $(MODLIB)/build
>  	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
>
> =====================
>
> --
> Regards,
> Pavel Roskin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

