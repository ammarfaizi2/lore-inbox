Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUIWNTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUIWNTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268446AbUIWNTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:19:17 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:8109 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S268440AbUIWNTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:19:08 -0400
Date: Thu, 23 Sep 2004 09:19:06 -0400
To: Mark Goodman <mgoodman@CSUA.Berkeley.EDU>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Let NFS3 krb5 mounts survive a krb5 ticket expiration
Message-ID: <20040923131906.GB15809@fieldses.org>
References: <415278CF.6010505@csua.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415278CF.6010505@csua.berkeley.edu>
User-Agent: Mutt/1.5.6+20040818i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 12:18:39AM -0700, Mark Goodman wrote:
> In my environment, this patch lets NFS3 krb5 mounts survive a krb5 
> ticket expiration. It applies to 2.6.9-rc2. Please consider applying.

See patches 2, 3, and 4 at
http://www.citi.umich.edu/projects/nfsv4/linux/kernel-patches/2.6.9-rc2-1/
which should make it to mainline soon.

--Bruce Fields

> Signed-off-by: Mark Goodman <mgoodman@csua.berkeley.edu>
> 
> --- linux-2.6.9-rc2/net/sunrpc/auth_gss/auth_gss.c.orig    2004-09-23 
> 00:07:28.891626224 -0700
> +++ linux-2.6.9-rc2/net/sunrpc/auth_gss/auth_gss.c    2004-09-23 
> 00:06:56.159602248 -0700
> @@ -742,6 +742,9 @@ gss_marshal(struct rpc_task *task, u32 *
>                    &verf_buf, &mic);
>     if(maj_stat != 0){
>         printk("gss_marshal: gss_get_mic FAILED (%d)\n", maj_stat);
> +        if (maj_stat == GSS_S_CONTEXT_EXPIRED) {
> +            cred->cr_flags |= RPCAUTH_CRED_DEAD;
> +        }
>         goto out_put_ctx;
>     }
>     p = xdr_encode_opaque(p, NULL, mic.len);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
