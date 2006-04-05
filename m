Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWDEWMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWDEWMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWDEWMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:12:35 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:4868 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932105AbWDEWMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:12:34 -0400
Date: Thu, 6 Apr 2006 00:12:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modules_install must not remove existing modules
Message-ID: <20060405221229.GA8972@mars.ravnborg.org>
References: <200604052333.51085.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604052333.51085.agruen@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 11:33:50PM +0200, Andreas Gruenbacher wrote:
> When installing external modules with `make modules_install', the
> first thing that happens is a rm -rf of the target directory. This
> works only once, and breaks when installing more than one (set of)
> external module(s). Bug introduced in:
>   http://www.kernel.org/hg/linux-2.6/?cs=bbb3915836f5
> 
> Sam, is this fix okay with you?
The removal was introduced to get rid of old modules from an earlier
build of the same kernel with potential more modules.
I was obvious when I played with an allmodconfig kernel IIRC.

The usecase you have in mind is with external modules only?
We could special case in that suation and avoid the removal.

I see no way to detect when it is OK to remove or not, so in the
principle of least suprise I prefer having the removal unconditional for
normal kernel builds, and no removal for external modules.

OK?

	Sam


> 
> Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
> 
> Index: linux-2.6.16/Makefile
> ===================================================================
> --- linux-2.6.16.orig/Makefile
> +++ linux-2.6.16/Makefile
> @@ -1131,7 +1131,6 @@ modules_install: _emodinst_ _emodinst_po
>  install-dir := $(if $(INSTALL_MOD_DIR),$(INSTALL_MOD_DIR),extra)	
>  .PHONY: _emodinst_
>  _emodinst_:
> -	$(Q)rm -rf $(MODLIB)/$(install-dir)
>  	$(Q)mkdir -p $(MODLIB)/$(install-dir)
>  	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
> 
> -- 
> Andreas Gruenbacher <agruen@suse.de>
> Novell / SUSE Labs
