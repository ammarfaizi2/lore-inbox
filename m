Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264769AbUEKOiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264769AbUEKOiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUEKOiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:38:25 -0400
Received: from [144.51.25.10] ([144.51.25.10]:12001 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S264769AbUEKOiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:38:20 -0400
Subject: Re: 2.6.6-mm1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
In-Reply-To: <20040510223755.A7773@infradead.org>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	 <20040510223755.A7773@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1084286098.7460.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 May 2004 10:34:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-10 at 17:37, Christoph Hellwig wrote:
> > +hugetlb_shm_group-sysctl-patch.patch
> > 
> >  Add /proc/sys/vm/hugetlb_shm_group: this holds the group ID of users who may
> >  allocate hugetlb shm segments without CAP_IPC_LOCK.  For Oracle.
> > 
> > +mlock_group-sysctl.patch
> > 
> >  /proc/sys/vm/mlock_group: group ID of users who can do mlock() without
> >  CAP_IPC_LOCK.  Not sure that we need this.
> 
> These two just introduced a subtile behaviour change during stable series,
> possibly (not likely) leading to DoS opportunities from applications running
> as gid 0.  Really, with capabilities first and now selinux we have moved
> away from treating uid 0 special, so introducing special casing of a gid
> now is more than just braindead.

Is there anything that would prevent these two patches from being
re-implemented as a LSM module, replacing the can_do_mlock and
can_do_hugetlb_shm functions with security hook calls?  They seem like
perfect candidates for security hook calls and keeping security logic
out of the core kernel.  Chris, what do you think?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

