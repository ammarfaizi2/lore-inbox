Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUEKFQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUEKFQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 01:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUEKFQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 01:16:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:3222 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262062AbUEKFQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 01:16:53 -0400
Date: Tue, 11 May 2004 10:47:57 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, wli@holomorphy.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dentry bloat.
Message-ID: <20040511104757.E31521@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com> <409DDDAE.3090700@colorfullife.com> <20040509153316.GE4007@in.ibm.com> <20040509221712.GA17014@parcelfarce.linux.theplanet.co.uk> <20040510183925.GB4813@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040510183925.GB4813@in.ibm.com>; from dipankar@in.ibm.com on Tue, May 11, 2004 at 12:09:25AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 12:09:25AM +0530, Dipankar Sarma wrote:
> On Sun, May 09, 2004 at 11:17:12PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Sun, May 09, 2004 at 09:03:16PM +0530, Dipankar Sarma wrote:
> >  
> > > Actually, what may happen is that since the dentries are added
> > > in the front, a double move like that would result in hash chain
> > > traversal looping. Timing dependent and unlikely, but d_move_count
> > > avoided that theoritical possibility. It is not about skipping
> > > dentries which is safe because a miss would result in a real_lookup()
> > 
> > Not really.  A miss could result in getting another dentry allocated
> > for the same e.g. directory, which is *NOT* harmless at all.
> 
> AFAICS, a miss in __d_lookup would result in a repeat lookup
> under dcache_lock in which case we are safe or real_lookup()
> which in turn does another lookup with dcache_lock. Is there
> a path that I am missing here ?


Actually, real_lookup is done with parent's i_sem (avoiding rename is the
same directory) and it also uses rename_lock (seqence lock) which provides
protection against d_move. (real_lookup() --> d_lookup() --> __d_lookup()). 

So as real_lookup() does repeat the cached lookup, I don't see any chance
of missing a hashed dentry and allocating one more dentry with the same name.

Thanks
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
