Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVCaMe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVCaMe7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 07:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVCaMe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 07:34:59 -0500
Received: from pat.uio.no ([129.240.130.16]:28829 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261398AbVCaMeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 07:34:24 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1112270304.10975.41.camel@lade.trondhjem.org>
References: <1112192778.17365.2.camel@mindpipe>
	 <1112194256.10634.35.camel@lade.trondhjem.org>
	 <20050330115640.0bc38d01.akpm@osdl.org>
	 <1112217299.10771.3.camel@lade.trondhjem.org>
	 <1112236017.26732.4.camel@mindpipe> <20050330183957.2468dc21.akpm@osdl.org>
	 <1112237239.26732.8.camel@mindpipe>
	 <1112240918.10975.4.camel@lade.trondhjem.org>
	 <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org>
	 <20050331073017.GA16577@elte.hu>
	 <1112270304.10975.41.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 07:34:11 -0500
Message-Id: <1112272451.10975.72.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.465, required 12,
	autolearn=disabled, AWL 1.49, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 31.03.2005 Klokka 06:58 (-0500) skreiv Trond Myklebust:
>  
> @@ -563,11 +566,14 @@ static int
>  nfs_scan_commit(struct inode *inode, struct list_head *dst, unsigned long idx_start, unsigned int npages)
>  {
>  	struct nfs_inode *nfsi = NFS_I(inode);
> -	int	res;
> -	res = nfs_scan_list(&nfsi->commit, dst, idx_start, npages);
> -	nfsi->ncommit -= res;
> -	if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
> -		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
> +	int res;
	  ^^^^^^^ Should be "int res = 0;"
> +
> +	if (nfsi->ncommit != 0) {
> +		res = nfs_scan_list(&nfsi->commit, dst, idx_start, npages);
> +		nfsi->ncommit -= res;
> +		if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
> +			printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
> +	}
>  	return res;
>  }
>  #endif

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

