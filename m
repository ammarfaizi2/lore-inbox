Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWFNVuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWFNVuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 17:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWFNVuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 17:50:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13220 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932380AbWFNVuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 17:50:55 -0400
Date: Thu, 15 Jun 2006 07:50:19 +1000
From: Nathan Scott <nathans@sgi.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060615075018.B884384@wobbly.melbourne.sgi.com>
References: <20060613143230.A867599@wobbly.melbourne.sgi.com> <448EC51B.6040404@argo.co.il> <20060614084155.C888012@wobbly.melbourne.sgi.com> <17551.58643.704359.815153@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17551.58643.704359.815153@gargle.gargle.HOWL>; from nikita@clusterfs.com on Wed, Jun 14, 2006 at 02:29:39PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Wed, Jun 14, 2006 at 02:29:39PM +0400, Nikita Danilov wrote:
> Sorry, but why this operation is needed? Generic code (in fs/*.c)
> doesn't use ->i_blksize at all. If XFS wants to provide per-inode
> st_blksize, all it has to do is to store preferred buffer size in its
> file system specific inode (struct xfs_inode), and use something
> different from generic_fillattr() as its ->i_op->getattr() callback
> (xfs_vn_getattr()).

We already do this.  The original questions were related to whether
i_blksize and i_blkbits need to be per-inode or per-filesystem, and
thats what I was trying to answer...

| 1) Move i_blksize (optimal size for I/O, reported by the stat system
|   call).  Is there any reason why this needs to be per-inode, instead
|   of per-filesystem?
| 2) Move i_blkbits (blocksize for doing direct I/O in bits) to struct
|    super.  Again, why is this per-inode?

As to whether a new inode operation is useful/needed - *shrug* - not
really my call, I was saying we can work with whatever ends up being
the final solution, provided it keeps per-inode granularity.

cheers.

-- 
Nathan
