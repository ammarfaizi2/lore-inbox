Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWCJBDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWCJBDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWCJBDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:03:20 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:30638 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1422672AbWCJBDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:03:18 -0500
Message-ID: <4410D053.1000303@vilain.net>
Date: Fri, 10 Mar 2006 14:03:15 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horms <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] NFS Client: remove supurflous goto from nfs_create_client()
References: <20060309092341.GA26949@verge.net.au>
In-Reply-To: <20060309092341.GA26949@verge.net.au>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms wrote:

>--- a/fs/nfs/inode.c
>+++ b/fs/nfs/inode.c
>@@ -408,16 +408,13 @@ nfs_create_client(struct nfs_server *ser
> 	if (IS_ERR(clnt)) {
> 		dprintk("%s: cannot create RPC client. Error = %ld\n",
> 				__FUNCTION__, PTR_ERR(xprt));
>-		goto out_fail;
>+		return clnt;
> 	}
> 
> 	clnt->cl_intr     = 1;
> 	clnt->cl_softrtry = 1;
> 
> 	return clnt;
>-
>-out_fail:
>-	return clnt;
> }
>  
>

Why not just move the label?

I think it is nicer if all of the exit points of a function are at the
end, I've observed this to be a common convention and its success has
actually made me jump off the 'goto=hell' bandwagon.

gcc might even be optimising those duplicate instructions to a single
one, so the duplication would be good documentation.

Sam.
