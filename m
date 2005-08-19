Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVHSQSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVHSQSa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbVHSQSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:18:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24793 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964984AbVHSQS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:18:29 -0400
Date: Fri, 19 Aug 2005 17:21:21 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and mmap
Message-ID: <20050819162121.GC29811@parcelfarce.linux.theplanet.co.uk>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk> <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 09:07:35AM -0700, Linus Torvalds wrote:
> Hmm.. NFS _does_ use the page cache for symlinks, but uses it slightly 
> differently: instead of relying on the page cache entry being the same 
> when freeing the page, it just caches the page it looked up in the page 
> cache (ie "nfs_follow_link()" does look up the page cache, but then hides 
> the page pointer inside the page data itself (uglee), and thus does not 
> depend on the mapping staying the same (nfs_put_link() just takes the page 
> from the symlink data).

For NFS that was done exactly to deal with cache invalidation.  IIRC, I've
convinced myself that it wasn't going to happen on ncpfs and happily
abstained from duplicating the NFS variant.
