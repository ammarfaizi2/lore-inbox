Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWH2Cqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWH2Cqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 22:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWH2Cqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 22:46:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:13512 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751076AbWH2Cqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 22:46:50 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 29 Aug 2006 12:46:44 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17651.43668.16773.512828@cse.unsw.edu.au>
Cc: v9fs-developer@lists.sourceforge.net, trond.myklebust@fys.uio.no,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 2] Invalidate_inode_pages2 changes.
In-Reply-To: message from Andrew Morton on Monday August 28
References: <20060829111641.18391.patches@notabene>
	<20060828191408.f6177de4.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 28, akpm@osdl.org wrote:
> On Tue, 29 Aug 2006 11:30:15 +1000
> NeilBrown <neilb@suse.de> wrote:
> 
> >  I'm picking up on a conversation that was started in late March
> >  this year, and which didn't get anywhere much.
> >  See
> >    http://lkml.org/lkml/2006/3/31/93
> >  and following.
> 
> Nick's "possible lock_page fix for Andrea's nopage vs invalidate race?"
> patch (linux-mm) should fix this?
> 
> If filemap_nopage() does lock_page(), invalidate_inode_pages2_range() is solid?

UHmm.... yes.  In that case we can remove lots of stuff from
invalidate_inode_pages2_range as we can be sure the page won't be
dirty or in writeback so invalidate_complete_page will be certain to
succeed. 

So if that goes ahead, these become moot.  But until it does, these
would be nice to have :-)

Also, the patch at
  http://marc.theaimsgroup.com/?l=linux-mm&m=115443228617576&w=2
appears not to set 
  +	.vm_flags	= VM_CAN_INVLD,
for nfs_fs_vm_operations, but maybe they are a later addition to
nfs...

Thinks: should I subscribe to linux-mm... only about 100 messages per
week.... maybe :-)

Thanks,
NeilBrown
