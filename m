Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965382AbWJ2UWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965382AbWJ2UWW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965373AbWJ2UWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:22:21 -0500
Received: from mx2.netapp.com ([216.240.18.37]:29795 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S965382AbWJ2UWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:22:20 -0500
X-IronPort-AV: i="4.09,369,1157353200"; 
   d="scan'208"; a="422613058:sNHT642694992"
Subject: Re: [PATCH 1/2] sunrpc: add missing spin_unlock
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Olaf Kirch <okir@monad.swb.de>, Neil Brown <neilb@suse.de>
In-Reply-To: <20061029133700.GA10295@localhost>
References: <20061028185554.GM9973@localhost>
	 <20061029133551.GA10072@localhost>  <20061029133700.GA10295@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Sun, 29 Oct 2006 15:21:59 -0500
Message-Id: <1162153319.5545.62.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 29 Oct 2006 20:22:00.0353 (UTC) FILETIME=[E3960110:01C6FB97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-29 at 22:37 +0900, Akinobu Mita wrote:
> auth_domain_put() forgot to unlock acquired spinlock.

ACK. (and added Neil to the CC list).

Cheers,
  Trond

> 
> Cc: Olaf Kirch <okir@monad.swb.de>
> Cc: Andy Adamson <andros@citi.umich.edu>
> Cc: J. Bruce Fields <bfields@citi.umich.edu>
> Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> Index: work-fault-inject/net/sunrpc/svcauth.c
> ===================================================================
> --- work-fault-inject.orig/net/sunrpc/svcauth.c
> +++ work-fault-inject/net/sunrpc/svcauth.c
> @@ -126,6 +126,7 @@ void auth_domain_put(struct auth_domain 
>  	if (atomic_dec_and_lock(&dom->ref.refcount, &auth_domain_lock)) {
>  		hlist_del(&dom->hash);
>  		dom->flavour->domain_release(dom);
> +		spin_unlock(&auth_domain_lock);
>  	}
>  }
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
