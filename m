Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWFPPvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWFPPvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWFPPvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:51:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:14046 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751467AbWFPPvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:51:22 -0400
Date: Fri, 16 Jun 2006 17:51:20 +0200
From: Jan Blunck <jblunck@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, dgc@sgi.com, balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Message-ID: <20060616155120.GA6824@hasse.suse.de>
References: <20060601095125.773684000@hasse.suse.de> <17539.35118.103025.716435@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17539.35118.103025.716435@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, Neil Brown wrote:

> I understand that this is where problem is because the selected
> dentries don't stay at the end of the list very long in some
> circumstances. In particular, other filesystems' dentries get mixed
> in. 

No. The problem is that the LRU list is too long and therefore unmounting
seems to take ages.

> You have addressed this by having multiple unused lists so the
> dentries of other filesystems don't get mixed in.
> 
> It seems to me that an alternate approach would be:
> 
>   - get select_parent and shrink_dcache_anon to move the selected
>     dentries on to some new list.
>   - pass this list to prune_dcache
>   - splice any remainder back on to the global list when finished.

I had this idea too. At least select_parent could use something like that. But
that wouldn't help in the umount situation.

Jan
