Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUD1XL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUD1XL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUD1XL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:11:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261602AbUD1XL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:11:27 -0400
Date: Wed, 28 Apr 2004 19:11:18 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 18 i_mmap_nonlinear
In-Reply-To: <Pine.LNX.4.44.0404280103350.2444-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404281909310.19633-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Hugh Dickins wrote:

> are some nonlinears; but really, we'd do best to take them out of the
> prio_tree altogether, into a list of their own - i_mmap_nonlinear.

Agreed, though on a related issue ...

> +++ rmap18/fs/inode.c	2004-04-27 19:19:05.866225752 +0100
> @@ -190,6 +190,7 @@ void inode_init_once(struct inode *inode
>  	spin_lock_init(&inode->i_data.private_lock);
>  	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
>  	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap_shared);
> +	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);

... do we still need both i_mmap and i_mmap_shared?
Is there a place left where we're using both trees in
a different way, or are we just walking both trees
anyway in all places where they're referenced ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

