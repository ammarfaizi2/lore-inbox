Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbTB1FXn>; Fri, 28 Feb 2003 00:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbTB1FXn>; Fri, 28 Feb 2003 00:23:43 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48807 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267473AbTB1FXm>; Fri, 28 Feb 2003 00:23:42 -0500
Date: Thu, 27 Feb 2003 21:33:53 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: maneesh@in.ibm.com
cc: Andrew Morton <akpm@digeo.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       trond.myklebust@fys.uio.no, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops in rpc_depopulate with 2.5.62
Message-ID: <2160000.1046410432@[10.10.2.4]>
In-Reply-To: <20030228050700.GA1134@in.ibm.com>
References: <25140000.1045901377@[10.10.2.4]>
 <20030222004930.0240738b.akpm@digeo.com> <20030224121442.GA1103@in.ibm.com>
 <7620000.1046277387@[10.10.2.4]> <20030228050700.GA1134@in.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Martin,
> 
> Trond has the correct fix for this. The patch is as follows:
> 
> --- linux-2.5.61-up/net/sunrpc/clnt.c.orig      2003-02-15
> 21:05:02.000000000 ++0100
> +++ linux-2.5.61-up/net/sunrpc/clnt.c   2003-02-17 19:39:20.000000000
> +0100 @@ -208,7 +208,8 @@
>                 rpcauth_destroy(clnt->cl_auth);
>                 clnt->cl_auth = NULL;
>         }
> -       rpc_rmdir(clnt->cl_pathname);
> +       if (clnt->cl_pathname[0])
> +               rpc_rmdir(clnt->cl_pathname);
>         if (clnt->cl_xprt) {
>                 xprt_destroy(clnt->cl_xprt);
>                 clnt->cl_xprt = NULL;

Cool - I picked this up from LKML, it's in 63-mjb1 ...

Thanks to everyone for the help with this one.

M.

