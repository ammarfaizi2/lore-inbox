Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265293AbUGSRYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUGSRYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 13:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUGSRYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 13:24:12 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:13457 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265293AbUGSRYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 13:24:05 -0400
Date: Mon, 19 Jul 2004 21:24:30 +0200
From: sam@ravnborg.org
To: "George G. Davis" <gdavis@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow `make O=<obj> {cscope,tags}` to work
Message-ID: <20040719192430.GA7522@mars.ravnborg.org>
Mail-Followup-To: "George G. Davis" <gdavis@mvista.com>,
	linux-kernel@vger.kernel.org
References: <20040719171759.GA1890@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719171759.GA1890@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 01:17:59PM -0400, George G. Davis wrote:
> Greetings,
> 
> Here's a trivial fix to allow `make O=<obj> {cscope,tags}` to work:
> 
> 
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2004/07/19 12:49:14-04:00 gdavis@davisg.ne.client2.attbi.com 
> #   Makefile:
> #     Allow `make O=<obj> {cscope,tags}` to work
> # 
> # Makefile
> #   2004/07/19 12:28:02-04:00 gdavis@davisg.ne.client2.attbi.com +9 -9
> #   Allow `make O=<obj> {cscope,tags}` to work
> # 
> diff -Nru a/Makefile b/Makefile
> --- a/Makefile	2004-07-19 13:00:49 -04:00
> +++ b/Makefile	2004-07-19 13:00:49 -04:00
> @@ -1009,26 +1009,26 @@
>  # ---------------------------------------------------------------------------
>  
>  define all-sources
> -	( find . $(RCS_FIND_IGNORE) \
> +	( find $(srctree) $(RCS_FIND_IGNORE) \
>  	       \( -name include -o -name arch \) -prune -o \
>  	       -name '*.[chS]' -print; \
> -	  find arch/$(ARCH) $(RCS_FIND_IGNORE) \
> +	  find $(srctree)/arch/$(ARCH) $(RCS_FIND_IGNORE) \
>  	       -name '*.[chS]' -print; \
> -	  find security/selinux/include $(RCS_FIND_IGNORE) \
> +	  find $(srctree)/security/selinux/include $(RCS_FIND_IGNORE) \
>  	       -name '*.[chS]' -print; \
> -	  find include $(RCS_FIND_IGNORE) \
> +	  find $(srctree)/include $(RCS_FIND_IGNORE) \
>  	       \( -name config -o -name 'asm-*' \) -prune \
>  	       -o -name '*.[chS]' -print; \
> -	  find include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
> +	  find $(srctree)/include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
>  	       -name '*.[chS]' -print; \
> -	  find include/asm-generic $(RCS_FIND_IGNORE) \
> +	  find $(srctree)/include/asm-generic $(RCS_FIND_IGNORE) \
>  	       -name '*.[chS]' -print )

OK so far.

>  endef
>  
> -quiet_cmd_cscope-file = FILELST cscope.files
> -      cmd_cscope-file = $(all-sources) > cscope.files
> +quiet_cmd_cscope-file = FILELST $(obj)/cscope.files
> +      cmd_cscope-file = $(all-sources) > $(obj)/cscope.files
The $(obj) in this line should not be needed. Current directory
defaults to $(obj) equals $(objtree) when executing make cscope.


	Sam
