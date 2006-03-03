Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWCCPqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWCCPqY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWCCPqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:46:23 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33734 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751138AbWCCPqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:46:23 -0500
Date: Fri, 3 Mar 2006 15:46:17 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/5] Optimise d_find_alias()
Message-ID: <20060303154617.GC27946@ftp.linux.org.uk>
References: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> <25676.1141385408@warthog.cambridge.redhat.com> <20060303034552.5fcedc49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303034552.5fcedc49.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 03:45:52AM -0800, Andrew Morton wrote:
> David Howells <dhowells@redhat.com> wrote:
> >
> >  struct dentry * d_find_alias(struct inode *inode)
> >   {
> >  -	struct dentry *de;
> >  -	spin_lock(&dcache_lock);
> >  -	de = __d_find_alias(inode, 0);
> >  -	spin_unlock(&dcache_lock);
> >  +	struct dentry *de = NULL;
> >  +	if (!list_empty(&inode->i_dentry)) {
> >  +		spin_lock(&dcache_lock);
> >  +		de = __d_find_alias(inode, 0);
> >  +		spin_unlock(&dcache_lock);
> >  +	}
> >   	return de;
> >   }
> 
> How can we get away without a barrier?

What would it buy you?
