Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265104AbUF1RxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265104AbUF1RxU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 13:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUF1RxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 13:53:20 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:642 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265104AbUF1RxR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 13:53:17 -0400
Subject: Re: nfsroot oops 2.6.7-current
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andre Noll <noll@mathematik.tu-darmstadt.de>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <slrnce0lrs.tq5.noll@p133.mathematik.tu-darmstadt.de>
References: <slrnce0lrs.tq5.noll@p133.mathematik.tu-darmstadt.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1088445193.4394.35.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 28 Jun 2004 13:53:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, and there's probably one missing in fs/nfsctl.c:do_open() too. Al?

Cheers,
  Trond


På må , 28/06/2004 klokka 13:38, skreiv Andre Noll:
> Hi
> 
> Al's current changes to struct nameidata broke nfsroot for my discless
> clients (oops in nfs_fill_super).  The patch below fixes this problem
> for me.
> 
> Andre
> 
> diff -u -r1.19 rpc_pipe.c
> --- linux-2.5/net/sunrpc/rpc_pipe.c	31 May 2004 03:06:56 -0000	1.19
> +++ linux-2.5/net/sunrpc/rpc_pipe.c	28 Jun 2004 17:10:51 -0000
> @@ -433,6 +433,7 @@
>  	nd->dentry = dget(rpc_mount->mnt_root);
>  	nd->last_type = LAST_ROOT;
>  	nd->flags = LOOKUP_PARENT;
> +	nd->depth = 0;
>  
>  	if (path_walk(path, nd)) {
>  		printk(KERN_WARNING "%s: %s failed to find path %s\n",
