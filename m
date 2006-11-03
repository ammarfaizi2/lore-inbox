Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWKCUst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWKCUst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWKCUss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:48:48 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:45218 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932107AbWKCUsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:48:45 -0500
Date: Fri, 3 Nov 2006 15:47:43 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fsstack: Generic get/set lower object functions
Message-ID: <20061103204743.GC16506@filer.fsl.cs.sunysb.edu>
References: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu> <20061102035928.679.5819.stgit@thor.fsl.cs.sunysb.edu> <1162483565.6299.98.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162483565.6299.98.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 11:06:05AM -0500, Trond Myklebust wrote:
> On Wed, 2006-11-01 at 22:59 -0500, Josef Jeff Sipek wrote:
...
> > +static inline struct inode *
> > +__fsstack_lower_inode(struct inode *inode, unsigned long branch_idx)
> > +{
> > +	struct fsstack_inode_info *info = fsstack_inode_data(inode);
> > +		
> > +	return info->inodes[branch_idx];
> > +}
> 
> What is the value of "functions" like the above? They appear just to
> obfuscate the code. Unless your aim is to hide the internals of the
> struct __fsstack_inode_generic_info (sort of futile, since you are
> asking users to include that structure in their private inode structs)
> then it is much more obvious to see what is going on when you write
> 
> 	inode = FSSTACK_I(inode)->inodes[branch];
> 
> rather than
> 
> 	inode = __fsstack_lower_inode(inode, branch);
 
I was thinking about this a bit, and it would seem that not having get/set
function pretty much kills the reson to have generic pointer structures at
all.

Would it make sense to change filesystems like ecryptfs to open-code all
these things instead of using _their own_ get/set functions (e.g.,
ecryptfs_inode_to_lower)?

Other posibility is to move the lower pointers into generic VFS objects in
some clever way (not to waste memory on regular filesystems) - this way, the
stackable filesystems can still share some parts.

Josef "Jeff" Sipek.

-- 
A computer without Microsoft is like chocolate cake without mustard.
