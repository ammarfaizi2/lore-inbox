Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWCGXHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWCGXHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWCGXHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:07:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:33445 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964856AbWCGXHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:07:38 -0500
From: Neil Brown <neilb@suse.de>
To: Eric Sesterhenn <snakebyte@gmx.de>,
       "J. Bruce Fields" <bfields@fieldses.org>
Date: Wed, 8 Mar 2006 10:06:35 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17422.4603.950948.166039@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Wrong error handling in nfs4acl
In-Reply-To: message from Eric Sesterhenn on Tuesday March 7
References: <1141761420.7561.7.camel@alice>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 7, snakebyte@gmx.de wrote:
> hi,
> 
> this fixes coverity id #3. Coverity detected dead code,
> since the == -1 comparison only returns 0 or 1 to error.
> Therefore the if ( error < 0 ) statement was always false.
> Seems that this was an if( error = nfs4... ) statement some time
> ago, which got broken during cleanup.
> Just compile tested.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> 
> --- linux-2.6.16-rc5-mm1/fs/nfsd/nfs4acl.c.orig	2006-03-07 20:52:34.000000000 +0100
> +++ linux-2.6.16-rc5-mm1/fs/nfsd/nfs4acl.c	2006-03-07 20:53:08.000000000 +0100
> @@ -790,7 +790,7 @@ nfs4_acl_split(struct nfs4_acl *acl, str
>  			continue;
>  
>  		error = nfs4_acl_add_ace(dacl, ace->type, ace->flag,
> -				ace->access_mask, ace->whotype, ace->who) == -1;
> +				ace->access_mask, ace->whotype, ace->who);
>  		if (error < 0)
>  			goto out;
>  
> 

Yeh, thanks....
I think we want to change nfs4_acl_add_ace to return -ENOMEM rather
than -1 too.

Bruce?

