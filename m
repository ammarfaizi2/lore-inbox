Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVCNWYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVCNWYE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVCNWV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:21:26 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:13451 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262029AbVCNWPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:15:54 -0500
Date: Mon, 14 Mar 2005 23:16:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "Justin M. Forbes" <jmforbes@linuxtx.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.Stable and EXTRAVERSION
Message-ID: <20050314221606.GA31437@mars.ravnborg.org>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	"Justin M. Forbes" <jmforbes@linuxtx.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20050309185331.GB19306@linuxtx.org> <1110443153.25570.7.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110443153.25570.7.camel@winden.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 09:25:54AM +0100, Andreas Gruenbacher wrote:
> On Wed, 2005-03-09 at 19:53, Justin M. Forbes wrote:
> > With the new stable series kernels, the .x versioning is being added to
> > EXTRAVERSION.  This has traditionally been a space for local modification.
> > I know several distributions are using EXTRAVERSION for build numbers,
> > platform and assorted other information to differentiate their kernel
> > releases.
> 
> It's no issue for us. We're using this patch to add in the RPM release
> number:
> 
> Index: linux-2.6.10/Makefile
> ===================================================================
> --- linux-2.6.10.orig/Makefile
> +++ linux-2.6.10/Makefile
> @@ -158,8 +158,11 @@ endif
>  LOCALVERSION = $(subst $(space),, \
>  	       $(shell cat /dev/null $(localversion-files:%~=)) \
>  	       $(patsubst "%",%,$(CONFIG_LOCALVERSION)))
> +ifneq ($(wildcard $(srctree)/rpm-release),)
> +RPM_RELEASE := -$(shell cat $(srctree)/rpm-release)
> +endif
>  
> -KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCALVERSION)
> +KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(RPM_RELEASE)$(LOCALVERSION)
>  
>  # SUBARCH tells the usermode build what the underlying arch is.  That is set
>  # first, and if a usermode build is happening, the "ARCH=um" on the command

Naming your rpm-release file: localversion00-rpm would do the same
without the need to patch the kernel.

	Sam
