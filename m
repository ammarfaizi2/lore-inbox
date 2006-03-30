Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWC3IA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWC3IA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWC3IA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:00:27 -0500
Received: from mx1.suse.de ([195.135.220.2]:52670 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932090AbWC3IA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:00:27 -0500
From: Neil Brown <neilb@suse.de>
To: akpm@osdl.org
Date: Thu, 30 Mar 2006 18:58:46 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17451.36790.450410.79788@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, mtk-manpages@gmx.net,
       nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
In-Reply-To: message from akpm@osdl.org on Wednesday March 29
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday March 29, akpm@osdl.org wrote:
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> Remove the recently-added LINUX_FADV_ASYNC_WRITE and LINUX_FADV_WRITE_WAIT
> fadvise() additions, do it in a new sys_sync_file_range() syscall
> instead. 

Hmmm... any chance this could be split into a sys_sync_file_range and
a vfs_sync_file_range which takes a 'struct file*' and does less (or
no) sanity checking, so I can call it from nfsd?

Currently I implement COMMIT (which has a range) with a by messing
around with filemap_fdatawrite and filemap_fdatawait (ignoring the
range) and I'd rather than a vfs helper.

And in nfsd I call filp->f_op->fsync between the two.  Doesn't
sys_sync_file_range need to call into the filesystem at all?

NeilBrown
