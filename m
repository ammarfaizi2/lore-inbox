Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUDGVlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUDGVlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:41:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:47821 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264183AbUDGVlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:41:21 -0400
Subject: Re: NUMA API for Linux
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040407232712.2595ac16.ak@suse.de>
References: <1081373058.9061.16.camel@arrakis>
	 <20040407232712.2595ac16.ak@suse.de>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1081374061.9061.26.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Apr 2004 14:41:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 14:27, Andi Kleen wrote:
> On Wed, 07 Apr 2004 14:24:19 -0700
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
> > 	I must be missing something here, but did you not include mempolicy.h
> > and policy.c in these patches?  I can't seem to find them anywhere?!? 
> > It's really hard to evaluate your patches if the core of them is
> > missing!
> 
> It was in the core patch and also in the last patch I sent Andrew.
> See ftp://ftp.suse.com/pub/people/ak/numa/* for the full patches

Ok.. I'll check that link, but what you posted didn't have the files
(mempolicy.h & policy.c) in the patch:

[mcd@arrakis numa_api]$ diffstat numa_api-01-core.patch
 include/linux/gfp.h   |   25 +++++++++++++++++++++++--
 include/linux/mm.h    |   17 +++++++++++++++++
 include/linux/sched.h |    4 ++++
 kernel/sys.c          |    3 +++
 mm/Makefile           |    1 +
 5 files changed, 48 insertions(+), 2 deletions(-)

Maybe it got lost somewhere between your mailer and mine?  The patch you
posted to LKML yesterday was clearly done without the -N option to diff:

diff -u linux-2.6.5-numa/kernel/sys.c-o linux-2.6.5-numa/kernel/sys.c


> > 
> > Andrew already mentioned your mistake on the i386 syscalls which needs
> > to be fixed.
> 
> That's already fixed

Good.

 
> > Also, this snippet of code is in 2 of your patches (#1 and #6) causing
> > rejects:
> > 
> > @@ -435,6 +445,8 @@
> >  
> >  struct page *shmem_nopage(struct vm_area_struct * vma,
> >                          unsigned long address, int *type);
> > +int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy
> > *new);
> > +struct mempolicy *shmem_get_policy(struct vm_area_struct *vma, unsigned
> > long addr);
> >  struct file *shmem_file_setup(char * name, loff_t size, unsigned long
> > flags);
> >  void shmem_lock(struct file * file, int lock);
> >  int shmem_zero_setup(struct vm_area_struct *);
> 
> 
> It didn't reject for me. 

I don't know why.  The same code addition is in both the 'core' patch
and the 'shm' patch.  Adding it twice causes patch throw a reject.


> > Just from the patches you posted, I would really disagree that these are
> > ready for merging into -mm.
> 
> Why so? 
> 
> -Andi


Well, if for no other reason than all the code isn't posted!

-Matt

