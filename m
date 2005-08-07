Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752474AbVHGSAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbVHGSAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 14:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbVHGSAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 14:00:41 -0400
Received: from mail.autoweb.net ([198.172.237.26]:7069 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1752474AbVHGSAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 14:00:41 -0400
Date: Sun, 7 Aug 2005 14:00:35 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.6.13-rc5-git-current (0d317fb72fe3cf0f611608cf3a3015bbe6cd2a66)
Message-ID: <20050807180035.GC5271@mythryan2.michonline.com>
References: <20050807035630.GA5271@mythryan2.michonline.com> <20050807170805.GA14289@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807170805.GA14289@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Snipping the oops down a bit in size)

On Sun, Aug 07, 2005 at 07:08:05PM +0200, Alexander Nyberg wrote:
> On Sat, Aug 06, 2005 at 11:56:30PM -0400 Ryan Anderson wrote:
> > Unable to handle kernel paging request at virtual address 6b6b6b6b

> > EIP is at inotify_inode_queue_event+0x55/0x150

> > Call Trace:
> >  [vfs_unlink+358/560] vfs_unlink+0x166/0x230
> >  [pg0+544348580/1067586560] nfsd_unlink+0x104/0x230 [nfsd]
> >  [pg0+544361268/1067586560] nfsd_cache_lookup+0x1c4/0x3c0 [nfsd]
> >  [pg0+544371728/1067586560] nfsd3_proc_remove+0x80/0xc0 [nfsd]
> >  [pg0+544381018/1067586560] nfs3svc_decode_diropargs+0x8a/0x100 [nfsd]
> >  [pg0+544380880/1067586560] nfs3svc_decode_diropargs+0x0/0x100 [nfsd]
> >  [pg0+544321698/1067586560] nfsd_dispatch+0x82/0x1f0 [nfsd]
> >  [svc_authenticate+112/336] svc_authenticate+0x70/0x150
> >  [svc_process+960/1648] svc_process+0x3c0/0x670
> >  [pg0+544323105/1067586560] nfsd+0x1a1/0x350 [nfsd]
> >  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
> >  [pg0+544322688/1067586560] nfsd+0x0/0x350 [nfsd]
> >  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
> 
> (the long-aged vfs veteran steps into the picture...)
> 
> It looks like the following sequence is done in the wrong order.
> When vfs_unlink() is called from sys_unlink() it has taken a ref
> on the inode and sys_unlink() does the last iput() but when called
> from other callsites vfs_unlink() might do the last iput()
> 
> Can you reproduce with this patch? It should happen with some nfs
> activity, I'll try to set up a scenario myself.

I'll try after I get a new hard drive in and let the RAID rebuild.

It seems like a very big coincidence that this happened *right* as a
drive was failing though - or is that just a bizarre coincidence?

-- 

Ryan Anderson
  sometimes Pug Majere
