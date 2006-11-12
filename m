Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932931AbWKLP7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbWKLP7W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 10:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932940AbWKLP7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 10:59:22 -0500
Received: from pat.uio.no ([129.240.10.15]:58524 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932931AbWKLP7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 10:59:21 -0500
Subject: Re: [NFS] [RFC: 2.6 patch] include/linux/nfsd/nfsfh.h: fix a NULL
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Adrian Bunk <bunk@stusta.de>
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061112131748.GI25057@stusta.de>
References: <20061112131748.GI25057@stusta.de>
Content-Type: text/plain
Date: Sun, 12 Nov 2006 10:58:47 -0500
Message-Id: <1163347127.6612.66.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.211, required 12,
	autolearn=disabled, AWL 1.65, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 14:17 +0100, Adrian Bunk wrote:
> dereference
> Reply-To: 
> Fcc: =sent-mail
> 
> When we know fhp->fh_dentry is NULL, a code path where it's being 
> dereferenced isn't a good choice.
> 
> Spotted by the coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6/include/linux/nfsd/nfsfh.h.old	2006-11-12 14:13:34.000000000 +0100
> +++ linux-2.6/include/linux/nfsd/nfsfh.h	2006-11-12 14:13:49.000000000 +0100
> @@ -330,8 +330,7 @@ fh_unlock(struct svc_fh *fhp)
>  {
>  	if (!fhp->fh_dentry)
>  		printk(KERN_ERR "fh_unlock: fh not verified!\n");
> -
> -	if (fhp->fh_locked) {
> +	else if (fhp->fh_locked) {
>  		fill_post_wcc(fhp);
>  		mutex_unlock(&fhp->fh_dentry->d_inode->i_mutex);
>  		fhp->fh_locked = 0;
> 

This issue has come up on lkml before. Please just convert that check
for fhp->fh_dentry into a BUG_ON().

Trond

