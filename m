Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWC3I5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWC3I5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWC3I5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:57:34 -0500
Received: from cantor2.suse.de ([195.135.220.15]:9905 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932117AbWC3I5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:57:34 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 30 Mar 2006 19:55:54 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17451.40218.486773.429315@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, mtk-manpages@gmx.net,
       nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
In-Reply-To: message from Andrew Morton on Thursday March 30
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
	<17451.36790.450410.79788@cse.unsw.edu.au>
	<20060330003246.31216ff2.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 30, akpm@osdl.org wrote:
> Neil Brown <neilb@suse.de> wrote:
> >
> > Hmmm... any chance this could be split into a sys_sync_file_range and
> >  a vfs_sync_file_range which takes a 'struct file*' and does less (or
> >  no) sanity checking, so I can call it from nfsd?
> 
> Problem is, we don't appear to have a way of syncing the file's metadata
> without also syncing all of its pagecache.
> 
> For example, ext3_sync_file() will run a commit, which will sync all data
> and metadata.
> 
> ext2_sync_file() will also sync all pagecache as well as metadata.  Even
> though do_fsync() already synced the file data (!).
> 
> 
> Is the below still useful?

Yes.  A COMMIT can say NFS_DATA_SYNC or NFS_FILE_SYNC.  I can skip the
->fsync call for NFS_DATA_SYNC which is hopefully the more common.
I didn't before because when I was righting that (2.4 days) there were
a lot fewer options on how to sync things.

So yes, that will be perfect, thanks.

NeilBrown

