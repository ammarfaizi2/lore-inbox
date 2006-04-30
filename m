Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWD3Vtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWD3Vtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 17:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWD3Vtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 17:49:50 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:57359 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751224AbWD3Vtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 17:49:49 -0400
Date: Sun, 30 Apr 2006 23:49:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adjust outputmakefile rule
Message-ID: <20060430214951.GA22935@mars.ravnborg.org>
References: <444F9814.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444F9814.76E4.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 03:56:04PM +0200, Jan Beulich wrote:
> Change the conditional of the outputmakefile rule to be evaluated entirely
> in make, and to not touch the generated makefile when e.g. running
> 'make install' as root while the build was done as non-root. Also adjust
> the comment describing this.

Can I request you to redo this patch.
Move all logic (including print-out) to mkmakefile
And only let it print out "GEN   ...." when it actttttttually generate
the Makefile.

Thanks,
	Sam

> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> 
> diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/Makefile 2.6.17-rc2-mkmakefile/Makefile
> --- /home/jbeulich/tmp/linux-2.6.17-rc2/Makefile	2006-04-26 11:50:05.516723552 +0200
> +++ 2.6.17-rc2-mkmakefile/Makefile	2006-04-24 12:28:36.000000000 +0200
> @@ -344,16 +344,18 @@ scripts_basic:
>  scripts/basic/%: scripts_basic ;
>  
>  PHONY += outputmakefile
> -# outputmakefile generate a Makefile to be placed in output directory, if
> -# using a seperate output directory. This allows convinient use
> -# of make in output directory
> +# outputmakefile generates a Makefile in the output directory, if
> +# using a separate output directory. This allows convenient use
> +# of make in the output directory.
>  outputmakefile:
> -	$(Q)if test ! $(srctree) -ef $(objtree); then \
> -	$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile              \
> -	    $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)         \
> -	    > $(objtree)/Makefile;                                 \
> -	    echo '  GEN    $(objtree)/Makefile';                   \
> +ifneq ($(KBUILD_SRC),)
> +	$(Q)if [ ! -r $(objtree)/Makefile -o -O $(objtree)/Makefile ]; then \
> +	    echo '  GEN     $(objtree)/Makefile';                           \
> +	    $(CONFIG_SHELL) $(srctree)/scripts/mkmakefile                   \
> +		$(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)              \
> +		> $(objtree)/Makefile;                                      \
>  	fi
> +endif
>  
>  # To make sure we do not include .config for any of the *config targets
>  # catch them early, and hand them over to scripts/kconfig/Makefile
> 
> 
