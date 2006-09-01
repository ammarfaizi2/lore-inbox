Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWIAQGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWIAQGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWIAQGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:06:13 -0400
Received: from pat.uio.no ([129.240.10.4]:6080 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932374AbWIAQGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:06:11 -0400
Subject: Re: [NFS] [PATCH 018 of 19] knfsd: lockd: fix use of h_nextrebind
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1060901043943.27665@suse.de>
References: <20060901141639.27206.patches@notabene>
	 <1060901043943.27665@suse.de>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 12:05:51 -0400
Message-Id: <1157126751.5632.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.023, required 12,
	autolearn=disabled, AWL 1.98, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 14:39 +1000, NeilBrown wrote:
> From: Olaf Kirch <okir@suse.de>
> 
>   nlmclnt_recovery would try to force a portmap rebind by setting
>   host->h_nextrebind to 0. The right thing to do here is to set it
>   to the current time.

Could we instead just add a routine nlm_force_rebind_host() into host.c?

> Signed-off-by: okir@suse.de
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./fs/lockd/clntlock.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff .prev/fs/lockd/clntlock.c ./fs/lockd/clntlock.c
> --- .prev/fs/lockd/clntlock.c	2006-08-31 17:02:23.000000000 +1000
> +++ ./fs/lockd/clntlock.c	2006-09-01 12:19:55.000000000 +1000
> @@ -184,7 +184,7 @@ restart:
>  	/* Force a portmap getport - the peer's lockd will
>  	 * most likely end up on a different port.
>  	 */
> -	host->h_nextrebind = 0;
> +	host->h_nextrebind = jiffies;
>  	nlm_rebind_host(host);
>  
>  	/* First, reclaim all locks that have been granted. */
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nfs

