Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752383AbWJ0S0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbWJ0S0a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 14:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385AbWJ0S0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 14:26:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29839 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752372AbWJ0S03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 14:26:29 -0400
Date: Fri, 27 Oct 2006 11:26:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       proski@gnu.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, cate@debian.org,
       gianluca@abinetworks.biz
Subject: Re: [PATCH ??] Re: incorrect taint of ndiswrapper
Message-Id: <20061027112601.dbd83c32.akpm@osdl.org>
In-Reply-To: <20061027082741.8476024a.randy.dunlap@oracle.com>
References: <1161807069.3441.33.camel@dv>
	<1161808227.7615.0.camel@localhost.localdomain>
	<20061025205923.828c620d.akpm@osdl.org>
	<20061026102630.ad191d21.randy.dunlap@oracle.com>
	<1161959020.12281.1.camel@laptopd505.fenrus.org>
	<20061027082741.8476024a.randy.dunlap@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 08:27:41 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> For ndiswrapper, don't set the module->taints flags,
> just set the kernel global tainted flag.
> This should allow ndiswrapper to continue to use GPL symbols.
> Not tested.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  kernel/module.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2619-rc3-pv.orig/kernel/module.c
> +++ linux-2619-rc3-pv/kernel/module.c
> @@ -1718,7 +1718,7 @@ static struct module *load_module(void _
>  	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
>  
>  	if (strcmp(mod->name, "ndiswrapper") == 0)
> -		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
> +		add_taint(TAINT_PROPRIETARY_MODULE);
>  	if (strcmp(mod->name, "driverloader") == 0)
>  		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
>  

Could someone please test this for us?
