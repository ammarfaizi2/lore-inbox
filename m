Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266778AbUFWV2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266778AbUFWV2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUFWVXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:23:15 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:9349 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266685AbUFWVTu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:19:50 -0400
Date: Wed, 23 Jun 2004 23:32:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] consolidate in kernel configuration
Message-ID: <20040623213220.GB2750@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Andy Whitcroft <apw@shadowen.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040622111559.1fa0dc99.akpm@osdl.org> <200406231428.i5NESu5V023376@voidhawk.shadowen.org> <20040623105346.018d90db.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623105346.018d90db.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 10:53:46AM -0700, Randy.Dunlap wrote:
> 
> We also need a decent way to run scripts/extract-ikconfig and build
> scripts/binoffset.  I recall that SuSE has/had a 'make cloneconfig'
> once upon a time (in 2.4.x).  I've begun on a 'make getconfig' (but
> I can rename it to 'cloneconfig' if that's more appropriate), but
> it needs some more work (i.e., not yet working).  [patch below]
> 
> 
> Thanks,
> --
> ~Randy
> 
> 
> 
> (beginning, not working...)
> add 'getconfig' target to extract kernel config from the kernel image file
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
> 
> diffstat:=
>  Makefile         |    6 ++++++
>  scripts/Makefile |    3 ++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff -Naurp ./scripts/Makefile~getconfig ./scripts/Makefile
> --- ./scripts/Makefile~getconfig	2004-06-23 07:21:28.000000000 -0700
> +++ ./scripts/Makefile	2004-06-23 09:16:06.266845368 -0700
> @@ -5,7 +5,8 @@
>  # docproc: 	 Preprocess .tmpl file in order to generate .sgml docs
>  # conmakehash:	 Create arrays for initializing the kernel console tables
>  
> -host-progs	:= conmakehash kallsyms modpost mk_elfconfig pnmtologo bin2c
> +host-progs	:= conmakehash kallsyms modpost mk_elfconfig pnmtologo \
> +		   bin2c binoffset
>  always		:= $(host-progs) empty.o
>  
>  modpost-objs	:= modpost.o file2alias.o sumversion.o
> diff -Naurp ./Makefile~getconfig ./Makefile
> --- ./Makefile~getconfig	2004-06-23 07:21:23.000000000 -0700
> +++ ./Makefile	2004-06-23 09:22:46.571989736 -0700
> @@ -675,6 +675,11 @@ include/config/MARKER: include/linux/aut
>  	@scripts/basic/split-include include/linux/autoconf.h include/config
>  	@touch $@
>  
> +.PHONY: getconfig
> +getconfig: $(srctree)/scripts/binoffset
> +	scripts/extract-ikconfig $@


There is a conflict with what rule to select here since all *config targets are sent to
scripts/kconfig.
Since what is done here is handling the kernel config maybe everything should be
moved there?

	Sam
