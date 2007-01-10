Return-Path: <linux-kernel-owner+w=401wt.eu-S964867AbXAJORk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbXAJORk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 09:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbXAJORk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 09:17:40 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:33175 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S964867AbXAJORj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 09:17:39 -0500
Message-ID: <368438638.13038@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Wed, 10 Jan 2007 22:17:56 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
Message-ID: <20070110141756.GA5572@mail.ustc.edu.cn>
Mail-Followup-To: Neil Brown <neilb@suse.de>,
	linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <367964923.02447@ustc.edu.cn> <20070105024226.GA6076@mail.ustc.edu.cn> <17828.33075.145986.404400@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17828.33075.145986.404400@notabene.brown>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 05:01:23PM +1100, Neil Brown wrote:
> On Friday January 5, fengguang.wu@gmail.com wrote:
> > Hi Neil,
> > 
> > NFS mounting succeeded, but the kernel gives a warning.
> > I'm running 2.6.20-rc2-mm1.
> > 
> > # mount -o vers=3 localhost:/suse /mnt
> > [  689.651606] svc: unknown version (3)
> > # mount | grep suse
> > localhost:/suse on /mnt type nfs (rw,nfsvers=3,addr=127.0.0.1)
> > 
> > Any clues about it?
> 
> Weird.
> 
> Please try this patch.  It should provide more useful information.
> 
> NeilBrown
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./net/sunrpc/svc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
> --- .prev/net/sunrpc/svc.c	2007-01-10 16:58:14.000000000 +1100
> +++ ./net/sunrpc/svc.c	2007-01-10 16:59:55.000000000 +1100
> @@ -910,7 +910,8 @@ err_bad_prog:
>  
>  err_bad_vers:
>  #ifdef RPC_PARANOIA
> -	printk("svc: unknown version (%d)\n", vers);
> +	printk("svc: unknown version (%d for prog %d, %s)\n", 
> +	       vers, prog, progp->pg_name);
>  #endif
>  	serv->sv_stats->rpcbadfmt++;
>  	svc_putnl(resv, RPC_PROG_MISMATCH);

root ~# mount localhost:/suse /mnt
[  132.678204] svc: unknown version (3 for prog 100227, nfsd)

I've confirmed that 2.6.20-rc2-mm1, 2.6.20-rc3-mm1, 2.6.19-rc6-mm1 all
have this warning, while 2.6.17-2-amd64 is good.

Thanks,
Wu
