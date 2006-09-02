Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWIBCsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWIBCsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 22:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWIBCsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 22:48:21 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:33937 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750719AbWIBCsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 22:48:20 -0400
Date: Fri, 1 Sep 2006 22:47:47 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 04/22][RFC] Unionfs: Common file operations
Message-ID: <20060902024747.GA11964@filer.fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014138.GE5788@fsl.cs.sunysb.edu> <1157149200.5628.38.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157149200.5628.38.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 06:20:00PM -0400, Trond Myklebust wrote:
> On Thu, 2006-08-31 at 21:41 -0400, Josef Sipek wrote:
...
> > +	for (bindex = bstart; bindex <= bend; bindex++) {
> > +		hidden_dentry = dtohd_index(file->f_dentry, bindex);
> > +		if (!hidden_dentry)
> > +			continue;
> > +
> > +		dget(hidden_dentry);
> > +		mntget(stohiddenmnt_index(inode->i_sb, bindex));
> > +		hidden_file = dentry_open(hidden_dentry,
> > +					stohiddenmnt_index(inode->i_sb, bindex),
> > +					file->f_flags);
> 
> Race! You cannot open an underlying NFS file by name after it has been
> looked up: you have no guarantee that it hasn't been renamed.

>From what I can see, the solution to this would be to pass the lookup
intents in unionfs_lookup down to the lower filesystem (the way it should be
done in the first place). Then, we could use the dentry here without any
problems. Is that all that needs to be done or am I forgetting something?

Thanks,

Josef "Jeff" Sipek.

-- 
VGER BF report: H 0
