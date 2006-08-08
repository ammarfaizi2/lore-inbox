Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWHHPtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWHHPtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWHHPtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:49:53 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:20203 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964969AbWHHPtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:49:52 -0400
Subject: Re: [PATCH] sys_getppid oopses on debug kernel
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
In-Reply-To: <44D8B12C.40200@sw.ru>
References: <44D865FD.1040806@sw.ru>
	 <1155050817.19249.42.camel@localhost.localdomain>  <44D8B12C.40200@sw.ru>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 08:49:45 -0700
Message-Id: <1155052185.19249.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 19:43 +0400, Kirill Korotaev wrote:
> > Accessing freed memory is a bug, always, not just *only* when slab
> > debugging is on, right?  Doesn't this mean we could get junk, or that
> > the reader could potentially run off a bad pointer?
> no, read the comment in sys_getppid.
> It is a valid optimization. _safe_ and alowing to bypass taking the lock.
> BUT! This optimization relies on the fact that kernel memory (DMA + normal zone)
> is always mapped into virtual address space.
> Which is invalid for debug kernels only.

Actually, it might also be invalid in hypervisor environments.  s390 and
Xen use ballooning drivers to tell the hypervisor which pages are not
currently in use by the OS so that they may be used in virtual machines
elsewhere.

I'm cc'ing the s390 guys.  Will the s390 kernel oops if it accesses a
page which was ballooned back to the hypervisor?

-- Dave

