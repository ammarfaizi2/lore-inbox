Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbUKWW7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbUKWW7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUKWW6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:58:31 -0500
Received: from unthought.net ([212.97.129.88]:10194 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261517AbUKWW4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:56:51 -0500
Date: Tue, 23 Nov 2004 23:56:50 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Christoph Hellwig <hch@infradead.org>, Phil Dier <phil@dier.us>,
       linux-kernel@vger.kernel.org, Scott Holdren <scott@icglink.com>,
       ziggy <ziggy@icglink.com>, Jack Massari <webmaster@icglink.com>
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm, and xfs
Message-ID: <20041123225650.GT4469@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Christoph Hellwig <hch@infradead.org>, Phil Dier <phil@dier.us>,
	linux-kernel@vger.kernel.org, Scott Holdren <scott@icglink.com>,
	ziggy <ziggy@icglink.com>, Jack Massari <webmaster@icglink.com>
References: <20041122130622.27edf3e6.phil@dier.us> <20041122161725.21adb932.akpm@osdl.org> <20041123093744.25c09245.phil@dier.us> <20041123170222.GS4469@unthought.net> <20041123223935.GA1889@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123223935.GA1889@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 10:39:35PM +0000, Christoph Hellwig wrote:
> On Tue, Nov 23, 2004 at 06:02:23PM +0100, Jakob Oestergaard wrote:
> > With SMP, what I see is that sometimes a directory might decide that
> > it's a file - but I can't delete it, becuase it isn't 'empty' (it's
> > still somehow a directory).  Waiting a day or two, the system will
> > change its mind back to letting the directory be a directory. Sometimes
> > modes will be fscked up as well - a regular file can change owner, or it
> > can change modes from '-rw-rw---' to '?---------'.    Weird stuff, no
> > way to reproduce it reliably.
> 
> Actually I can reproduce it reliably by running nfs_fsstress.sh for a
> looong time.  The problem is that in the current XFS code the inode
> generation counter starts at 0, but higher level code uses that as
> a wildcard for any possible generation, so you may get a newly created
> file for a stale nfs file handler of an deleted file with the same inode
> number.
> 
> The patch below fixes it for me:

Very nice!

Is that patch on its way into mainline kernels, or is it waiting for
more test data ?

I could apply it and test it here if that would help (?)

-- 

 / jakob

