Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268255AbTBYWgQ>; Tue, 25 Feb 2003 17:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268298AbTBYWgQ>; Tue, 25 Feb 2003 17:36:16 -0500
Received: from mail.williamewood.com ([63.98.123.93]:1453 "EHLO
	mail.williamewood.com") by vger.kernel.org with ESMTP
	id <S268255AbTBYWgP>; Tue, 25 Feb 2003 17:36:15 -0500
From: Emmett Pate <emmett@epate.com>
Organization: EPate & Associates, Inc.
To: linux-kernel@vger.kernel.org
Subject: Re: rootfs on nfs : oops 2.5.63
Date: Tue, 25 Feb 2003 17:46:30 -0500
User-Agent: KMail/1.5
References: <20030225151337.358a6ee6.bert@ovh.net> <200302251622.55217.emmett@epate.com> <20030225141134.3778b199.akpm@digeo.com>
In-Reply-To: <20030225141134.3778b199.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302251746.30912.emmett@epate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works like a champ!  I really appreciate your help.

Emmett Pate


On Tuesday 25 February 2003 05:11 pm, Andrew Morton wrote:
> Emmett Pate <emmett@epate.com> wrote:
> > I'm having the same problem.
> >
> > On my notebook (wireless PCMCIA, D-Link DWL650), 2.5.63 oopses
> > immediately on trying to mount an NFS filesystem.
>
> Trond quietly sent out the below patch a while back.  Could you please see
> if this fixes things up?
>
>
> --- 25/net/sunrpc/clnt.c~rpc_rmdir-fix	Mon Feb 24 15:47:53 2003
> +++ 25-akpm/net/sunrpc/clnt.c	Mon Feb 24 15:47:53 2003
> @@ -208,7 +208,8 @@ rpc_destroy_client(struct rpc_clnt *clnt
>  		rpcauth_destroy(clnt->cl_auth);
>  		clnt->cl_auth = NULL;
>  	}
> -	rpc_rmdir(clnt->cl_pathname);
> +	if (clnt->cl_pathname[0])
> +		rpc_rmdir(clnt->cl_pathname);
>  	if (clnt->cl_xprt) {
>  		xprt_destroy(clnt->cl_xprt);
>  		clnt->cl_xprt = NULL;
>
> _

-- 
Emmett M. Pate, Jr.
EPate & Associates, Inc.
emmett@epate.com

