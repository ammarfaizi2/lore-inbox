Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264906AbUEKQ5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbUEKQ5A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264882AbUEKQyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:54:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:38104 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264871AbUEKQsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:48:21 -0400
Date: Tue, 11 May 2004 09:48:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
Subject: Re: 2.6.6-mm1
Message-ID: <20040511094819.K21045@build.pdx.osdl.net>
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <1084286098.7460.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1084286098.7460.97.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Tue, May 11, 2004 at 10:34:58AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Mon, 2004-05-10 at 17:37, Christoph Hellwig wrote:
> > > +hugetlb_shm_group-sysctl-patch.patch
> > > 
> > >  Add /proc/sys/vm/hugetlb_shm_group: this holds the group ID of users who may
> > >  allocate hugetlb shm segments without CAP_IPC_LOCK.  For Oracle.
> > > 
> > > +mlock_group-sysctl.patch
> > > 
> > >  /proc/sys/vm/mlock_group: group ID of users who can do mlock() without
> > >  CAP_IPC_LOCK.  Not sure that we need this.
> > 
> > These two just introduced a subtile behaviour change during stable series,
> > possibly (not likely) leading to DoS opportunities from applications running
> > as gid 0.  Really, with capabilities first and now selinux we have moved
> > away from treating uid 0 special, so introducing special casing of a gid
> > now is more than just braindead.
> 
> Is there anything that would prevent these two patches from being
> re-implemented as a LSM module, replacing the can_do_mlock and
> can_do_hugetlb_shm functions with security hook calls?  They seem like
> perfect candidates for security hook calls and keeping security logic
> out of the core kernel.  Chris, what do you think?

Hrm, it's certainly doable.  Not sure if it would help or clutter the
issue.  /me ponders that one...

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
