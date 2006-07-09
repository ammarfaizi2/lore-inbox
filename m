Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWGIBFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWGIBFe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 21:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGIBFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 21:05:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36833 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751321AbWGIBFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 21:05:33 -0400
Date: Sun, 9 Jul 2006 11:04:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [xfs-masters] Re: fs/xfs/xfs_vnodeops.c:xfs_readdir(): NULL variable dereferenced
Message-ID: <20060709110459.F1640104@wobbly.melbourne.sgi.com>
References: <20060706211320.GW26941@stusta.de> <20060706233246.GB15160733@melbourne.sgi.com> <20060708194609.GB5020@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060708194609.GB5020@stusta.de>; from bunk@stusta.de on Sat, Jul 08, 2006 at 09:46:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 09:46:09PM +0200, Adrian Bunk wrote:
> On Fri, Jul 07, 2006 at 09:32:46AM +1000, David Chinner wrote:
> > > Coverity checker found a way how tp might be dereferenced four function 
> > > calls later).

Keyword being "might". ;)

> > Then the bug is probably in the function call that uses tp without
> > first checking whether it's null. Can you tell us where that dereference
> > occurs?
> 
> xfs_readdir()
>   xfs_dir_getdents()
>     xfs_dir2_leaf_getdents()
>       xfs_bmapi()
>         xfs_trans_log_inode()
>           tp->t_flags |= XFS_TRANS_DIRTY;

This actually cant happen due to the flags passed into xfs_bmapi (ie.
request for a extent map _read_, which wont result in the inode being
logged, which means no transaction dirtying).

That suggestion to remove the local "tp" variable was valid though,
we may as well do that (will do).

cheers.

-- 
Nathan
