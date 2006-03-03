Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWCCLr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWCCLr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWCCLr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:47:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34214 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750705AbWCCLrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:47:25 -0500
Date: Fri, 3 Mar 2006 03:45:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/5] Optimise d_find_alias()
Message-Id: <20060303034552.5fcedc49.akpm@osdl.org>
In-Reply-To: <25676.1141385408@warthog.cambridge.redhat.com>
References: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com>
	<25676.1141385408@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
>  struct dentry * d_find_alias(struct inode *inode)
>   {
>  -	struct dentry *de;
>  -	spin_lock(&dcache_lock);
>  -	de = __d_find_alias(inode, 0);
>  -	spin_unlock(&dcache_lock);
>  +	struct dentry *de = NULL;
>  +	if (!list_empty(&inode->i_dentry)) {
>  +		spin_lock(&dcache_lock);
>  +		de = __d_find_alias(inode, 0);
>  +		spin_unlock(&dcache_lock);
>  +	}
>   	return de;
>   }

How can we get away without a barrier?
