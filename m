Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWJRIff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWJRIff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWJRIfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:35:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42699 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750873AbWJRIfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:35:33 -0400
Date: Wed, 18 Oct 2006 09:35:27 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       hch@infradead.org, mhalcrow@us.ibm.com, penberg@cs.helsinki.fi,
       linux-fsdevel@vger.kernel.org
Subject: Re: fsstack: struct path
Message-ID: <20061018083527.GJ29920@ftp.linux.org.uk>
References: <20061018042323.GA8537@filer.fsl.cs.sunysb.edu> <20061018013103.4ad6311a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018013103.4ad6311a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 01:31:03AM -0700, Andrew Morton wrote:
> On Wed, 18 Oct 2006 00:23:23 -0400
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> 
> > Few weeks ago, I noticed that fs/namei.c defines struct path:
> > 
> > struct path {
> > 	struct vfsmount *mnt;
> > 	struct dentry *dentry;
> > };
> > 
> > I think it would make sense to move it into include/linux/ as it is quite
> > useful (and it would discourage the (ab)use of struct nameidata.)
> > 
> > The fsstack code could benefit from it as the stackable fs dentries have to
> > keep track of the lower dentry as well as the lower vfsmount.
> > 
> > One, rather unfortunate, fact is that struct path is also defined in
> > include/linux/reiserfs_fs.h as something completely different - reiserfs
> > specific.
> > 
> > Any thoughts?
> > 
> 
> reiserfs is being bad.  s/path/reiserfs_path/g

Indeed.  That's one pending patch that never got around to be submitted
(and had bitrotten at least 3 times, IIRC).

ACK, provided that reiserfs folks are OK with the replacement name for
their struct.  Note that "path" in question has very little to do with
pathnames - it's a path in balanced tree, IIRC.  So if we get around
to renaming that sucker, it might be a good time to pick better name.

Certainly ACK for generic part.
