Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTLYEMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 23:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTLYEMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 23:12:21 -0500
Received: from havoc.gtf.org ([63.247.75.124]:34013 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261775AbTLYEMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 23:12:19 -0500
Date: Wed, 24 Dec 2003 23:12:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix make kernel rpm bug
Message-ID: <20031225041218.GA7533@gtf.org>
References: <Pine.LNX.4.44.0312101340050.19835-100000@mazda.sh.intel.com> <Pine.LNX.4.44.0312251035320.16217-100000@mazda.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312251035320.16217-100000@mazda.sh.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 10:43:52AM +0800, Zhu, Yi wrote:
> Hi Andrew,
> 
> Below two lines patch makes the rpm rule in top Makefile be aware of
> $(ARCH). The old rule will make wrong rpm if ARCH is not the same as
> the build machine.
> 
> 
> diff -Nru a/Makefile b/Makefile
> --- a/Makefile	Wed Dec 10 13:47:52 2003
> +++ b/Makefile	Wed Dec 10 13:47:52 2003
> @@ -872,7 +872,7 @@
>  	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > $(objtree)/.tmp_version;\
>  	mv -f $(objtree)/.tmp_version $(objtree)/.version;
>  
> -	$(RPM) -ta ../$(KERNELPATH).tar.gz
> +	$(RPM) --target $(ARCH) -ta ../$(KERNELPATH).tar.gz
>  	rm ../$(KERNELPATH).tar.gz
>  
>  # Brief documentation of the typical targets used
> diff -Nru a/scripts/mkspec b/scripts/mkspec
> --- a/scripts/mkspec	Wed Dec 10 13:47:52 2003
> +++ b/scripts/mkspec	Wed Dec 10 13:47:52 2003
> @@ -9,7 +9,7 @@
>  #	Patched for non-x86 by Opencon (L) 2002 <opencon@rio.skydome.net>
>  #
>  # That's the voodoo to see if it's a x86.
> -ISX86=`arch | grep -ie i.86`
> +ISX86=`echo ${ARCH:=\`arch\`} | grep -ie i.86`

hmmm, I don't think $(ARCH) makes the rpm --target strings in all
cases..

	Jeff



