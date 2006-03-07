Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752169AbWCGLfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbWCGLfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbWCGLfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:35:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15782 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752166AbWCGLfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:35:21 -0500
Date: Tue, 7 Mar 2006 06:35:14 -0500
From: Alexander Viro <aviro@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix multiple blockdev-based filesystem mounts
Message-ID: <20060307113514.GX20691@devserv.devel.redhat.com>
References: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> <15962.1141729721@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15962.1141729721@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 11:08:41AM +0000, David Howells wrote:
> 
> The attached patch fixes multiple mounts of the same blockdev-based filesystem
> (such as EXT3). The problem is that the path through the function that deals
> with a second mount of an already extant superblock is going out through the
> error path and not the success path that sets up the vfsmount.
> 
> The error can be checked by doing something like:
> 
> 	mount /dev/hda6 /a
> 	mount /dev/hda6 /b
> 
> Where /dev/hda6 has something like an EXT3 filesystem on it. The second mount
> should succeed, but doesn't without this patch.
> 
> This patch is dependent on the getsb patch submitted earlier.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>

Please, merge them in one; this one fixes a bug in ->get_sb() patch and since
it wasn't merged in mainline yet, there's no reason to keep them separate.
