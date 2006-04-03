Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWDCHuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWDCHuA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 03:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWDCHuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 03:50:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12641 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932355AbWDCHt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 03:49:59 -0400
Date: Mon, 3 Apr 2006 09:50:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: Nathan Scott <nathans@sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com, mtk-manpages@gmx.net,
       nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
Message-ID: <20060403074959.GG3770@suse.de>
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net> <17451.36790.450410.79788@cse.unsw.edu.au> <20060331071736.K921158@wobbly.melbourne.sgi.com> <17456.31028.173800.615259@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17456.31028.173800.615259@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03 2006, Neil Brown wrote:
> On Friday March 31, nathans@sgi.com wrote:
> > On Thu, Mar 30, 2006 at 06:58:46PM +1100, Neil Brown wrote:
> > > On Wednesday March 29, akpm@osdl.org wrote:
> > > > Remove the recently-added LINUX_FADV_ASYNC_WRITE and LINUX_FADV_WRITE_WAIT
> > > > fadvise() additions, do it in a new sys_sync_file_range() syscall
> > > > instead. 
> > > 
> > > Hmmm... any chance this could be split into a sys_sync_file_range and
> > > a vfs_sync_file_range which takes a 'struct file*' and does less (or
> > > no) sanity checking, so I can call it from nfsd?
> > > 
> > > Currently I implement COMMIT (which has a range) with a by messing
> > > around with filemap_fdatawrite and filemap_fdatawait (ignoring the
> > > range) and I'd rather than a vfs helper.
> > 
> > I'm not 100% sure, but it looks like the PF_SYNCWRITE process flag
> > should be set on the nfsd's while they're doing that, which doesn't
> > seem to be happening atm.  Looks like a couple of the IO schedulers
> > will make use of that knowledge now.  All the more reason for a VFS
> > helper here I guess. ;)
> 
> PF_SYNCWRITE? What's that???
> 
> (find | xargs grep ...)
> Oh.  The block device schedulers like to know if a request is sync or
> async (and all reads are assumed to be sync) - which is reasonable -
> and so have a per-task flag to tell them - which isn't (IMO).
> 
> md/raid (particularly raid5) often does the write from a different
> process than generated the original request, so that will break
> completely. 

I don't think any disagrees with you, the sync-write process flag is
indeed an atrocious beast...

> What is wrong with a bio flag I wonder....

Nothing, in fact I would love for it to be changed. I'm sure such a
patch would be accepted with open arms! :-)

-- 
Jens Axboe

