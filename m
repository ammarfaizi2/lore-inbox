Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVAKKBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVAKKBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVAKKBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:01:25 -0500
Received: from unthought.net ([212.97.129.88]:31469 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262665AbVAKKBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:01:12 -0500
Date: Tue, 11 Jan 2005 11:01:10 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Valdis.Kletnieks@vt.edu
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       Anton Blanchard <anton@samba.org>, Phy Prabab <phyprabab@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux NFS vs NetApp
Message-ID: <20050111100109.GA347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Valdis.Kletnieks@vt.edu, Joel Jaeggli <joelja@darkwing.uoregon.edu>,
	Anton Blanchard <anton@samba.org>, Phy Prabab <phyprabab@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20050111025401.48311.qmail@web51810.mail.yahoo.com> <20050111035810.GG14239@krispykreme.ozlabs.ibm.com> <Pine.LNX.4.61.0501102321490.25796@twin.uoregon.edu> <200501110920.j0B9JwAL006980@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501110920.j0B9JwAL006980@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 04:19:57AM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 10 Jan 2005 23:42:30 PST, Joel Jaeggli said:
> 
> > In actually using sfs97r1 published benchmarks to compare to hardware I 
> > was benchmarking (from emc, netapp and several roll-your own linux boxes) 
> > I found the published benchmark information alsmost entirely useless given 
> > that vendors tend to provide wildly silly hardware configurations. In the 
> > case of the openpower 720 (to use that for an example) the benchmarked 
> > machine has 70 15k rpm disks spread across 12 fibre channel controllers, 
> > 64GB of ram, 12GB of nvram and 7 network interfaces...
> 
> If you threw that much hardware at a Linux system, 

... theory ... or have you actually tried?

> and then tuned it so that it
> didn't really care about userspace performance (oh.. say.. by giving the knfsd
> thread a RT priority ;), and tuned things like the filesystem, the slab
> allocator and the networking stack to NFS requirements, it probably would be
> screaming fast too.. ;)

You'd need to run a 2.4 kernel.

Current problems with 2.6:
1 ext3 causes kjournald oops on load
2 xfs has bad NFS/SMP/dcache interactions (you end up with undeletable
  directories)
3 knfsd will give you stale handles (can be worked around by stat'ing
  all your directories constantly on the server side)

The SGI XFS kernel from CVS actually almost solved (2) above, but not
entirely - I was going to report on that again to LKML. The other
problems are still, as far as I know, unsolved.

Not trying to flame anyone here, just trying to be realistic  ;)

-- 

 / jakob

