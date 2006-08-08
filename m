Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWHHP6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWHHP6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWHHP6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:58:06 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:60866 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030182AbWHHP6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:58:04 -0400
Subject: Re: [PATCH] sys_getppid oopses on debug kernel
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
In-Reply-To: <1155052185.19249.54.camel@localhost.localdomain>
References: <44D865FD.1040806@sw.ru>
	 <1155050817.19249.42.camel@localhost.localdomain>  <44D8B12C.40200@sw.ru>
	 <1155052185.19249.54.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 08 Aug 2006 17:58:02 +0200
Message-Id: <1155052682.7131.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 08:49 -0700, Dave Hansen wrote:
> On Tue, 2006-08-08 at 19:43 +0400, Kirill Korotaev wrote:
> > > Accessing freed memory is a bug, always, not just *only* when slab
> > > debugging is on, right?  Doesn't this mean we could get junk, or that
> > > the reader could potentially run off a bad pointer?
> > no, read the comment in sys_getppid.
> > It is a valid optimization. _safe_ and alowing to bypass taking the lock.
> > BUT! This optimization relies on the fact that kernel memory (DMA + normal zone)
> > is always mapped into virtual address space.
> > Which is invalid for debug kernels only.
> 
> Actually, it might also be invalid in hypervisor environments.  s390 and
> Xen use ballooning drivers to tell the hypervisor which pages are not
> currently in use by the OS so that they may be used in virtual machines
> elsewhere.
> 
> I'm cc'ing the s390 guys.  Will the s390 kernel oops if it accesses a
> page which was ballooned back to the hypervisor?

Not with the ballooner, that just tells the hypervisor that it can
forget the current content. On the next access the hypervisor hands out
a zeroed page so the access will succeed. But with my guest page hinting
code the kernel will oops if a free page is accessed.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


