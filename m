Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWJ0VqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWJ0VqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWJ0VqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:46:24 -0400
Received: from mx1.cs.washington.edu ([128.208.5.52]:56788 "EHLO
	mx1.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1750701AbWJ0VqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:46:24 -0400
Date: Fri, 27 Oct 2006 14:46:03 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>,
       Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] NFS: nfsaclsvc_encode_getaclres() - Fix potential NULL
 deref and tiny optimization.
In-Reply-To: <200610272316.47089.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64N.0610271443500.31179@attu2.cs.washington.edu>
References: <200610272316.47089.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, Jesper Juhl wrote:

> In fs/nfsd/nfs2acl.c::nfsaclsvc_encode_getaclres() I see a few issues.
> 
> 1) At the top of the function we assign to the 'inode' variable by 
> dereferencing 'dentry', but further down we test 'dentry' for NULL. So, if 
> 'dentry' (which is really 'resp->fh.fh_dentry') can be NULL, then either 
> we have a potential NULL pointer deref bug or we have a superflous test.
> 

resp->fh.fh_dentry cannot be NULL on nfsaclsvc_encode_getaclres so the 
early assignment is appropriate for both *dentry and *inode.  *inode will 
need to be checked for NULL in the conditional, however, and return 0 on 
true.

> 3) There are two locations in the function where we may return before we 
> use the value of the variable 'w', but we compute it at the very top of the 
> function. So in the case where we return early we have wasted a few cycles 
> computing a value that was never used.
> 

w should be an unsigned int.

		David
