Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWFSJe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWFSJe3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWFSJe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:34:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55249 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932273AbWFSJe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:34:28 -0400
Date: Mon, 19 Jun 2006 11:34:26 +0200
From: Jan Blunck <jblunck@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, dgc@sgi.com, balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Message-ID: <20060619093426.GC6824@hasse.suse.de>
References: <20060601095125.773684000@hasse.suse.de> <17539.35118.103025.716435@cse.unsw.edu.au> <20060616155120.GA6824@hasse.suse.de> <17555.12234.347353.670918@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17555.12234.347353.670918@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, Neil Brown wrote:

> But I cannot see that the whole LRU list needs to be scanned during
> unmount.
> The only thing that does that is shrink_dcache_sb, which is used:
>   in do_remount_sb
>   in __invalidate_device
>   in a few filesystems (autofs, coda, smbfs)
>  and not when unmounting the filesystem (despite the comment).
> 
> (This is in 2.6.17-ec6-mm2).
> 
> I can see that shrink_dcache_sb could take a long time and should be
> fixed, which should be as simple as replacing it with
> shrink_dcache_parent; shrink_dcache_anon.

I don't remember exactly, maybe it was remounting instead of
unmounting. Although I believe that we should call shrink_dcache_sb() instead
of shrink_dcache_anon()+parent() when unmounting. I don't see any reason why we
should shrink the dcache with depth-first traversal instead of just killing
every unused dentry that we find (not even talking about that DCACHE_REFERENCE
handling is nonesense in that case).

> But I'm still puzzled as to why a long dcache LRU slows down
> unmounting. 
> 
> Can you give more details?

I think David already answered that.

Jan
