Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268165AbUHFP5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268165AbUHFP5V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268158AbUHFPtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:49:45 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:16399 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268140AbUHFPki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:40:38 -0400
Date: Fri, 6 Aug 2004 17:42:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Hollis Blanchard <hollisb@us.ibm.com>, rusty@rustcorp.com.au
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: cross-depmod?
Message-ID: <20040806154211.GB7331@mars.ravnborg.org>
Mail-Followup-To: Hollis Blanchard <hollisb@us.ibm.com>,
	rusty@rustcorp.com.au, Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
References: <1091742716.28466.27.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091742716.28466.27.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 04:51:56PM -0500, Hollis Blanchard wrote:
> Hi Sam, would you take a patch like this:
> 
> --- 1.509/Makefile      Tue Aug  3 16:11:35 2004
> +++ edited/Makefile     Thu Aug  5 17:12:07 2004
> @@ -790,7 +790,11 @@
>  endif
>  .PHONY: _modinst_post
>  _modinst_post: _modinst_
> -       if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
> +       if [ -z "$(CROSS_COMPILE)" -o "$(DEPMOD)" != "/sbin/depmod" ] ; then \
> +               if [ -r System.map ]; then \
> +                       $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); \
> +               fi \
> +       fi
> 
>  else # CONFIG_MODULES
> 
> (I don't like hardcoding /sbin/depmod; this is just for conversation.)
> 
> My problem is that I cross-build my kernels, and 'make rpm' is very
> unhappy when it can't use depmod. I know that I can do 'make
> DEPMOD=/bin/true rpm', but can't we figure that out automatically?

I assume the problem arises from the fact that depmod are only capable of
reading elf files for the host it is compiled for.
OK, took a look at depmod.
It handles both 32 and 64 bit but assumes same endian.

Rusty: Would it make sense to extend module-init-tools to support
endian as specified in elf file?

	Sam
