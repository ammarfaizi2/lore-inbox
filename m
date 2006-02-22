Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWBVCKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWBVCKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWBVCKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:10:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932532AbWBVCKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:10:32 -0500
Date: Tue, 21 Feb 2006 18:08:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: clameter@engr.sgi.com, kiran@scalex86.org, linux-kernel@vger.kernel.org,
       shai@scalex86.org
Subject: Re: [patch] Cache align futex hash buckets
Message-Id: <20060221180845.79a44449.akpm@osdl.org>
In-Reply-To: <43FBB2E8.2020300@yahoo.com.au>
References: <20060220233242.GC3594@localhost.localdomain>
	<43FA8938.70006@yahoo.com.au>
	<Pine.LNX.4.64.0602211030240.20166@schroedinger.engr.sgi.com>
	<43FBB2E8.2020300@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Christoph Lameter wrote:
> > On Tue, 21 Feb 2006, Nick Piggin wrote:
> > 
> > 
> >>Ravikiran G Thirumalai wrote:
> >>
> >>>Following change places each element of the futex_queues hashtable on a
> >>>different cacheline.  Spinlocks of adjacent hash buckets lie on the same
> >>>cacheline otherwise.
> >>>
> >>
> >>It does not make sense to add swaths of unused memory into a hashtable for
> >>this purpose, does it?
> > 
> > 
> > It does if you essentially have a 4k cacheline (because you are doing NUMA 
> > in software with multiple PCs....) and transferring control of that 
> > cacheline is comparatively expensive.
> > 
> 
> Instead of 1MB hash with 256 entries in it covering 256 cachelines, you
> have a 1MB hash with 65536(ish) entries covering 256 cachelines.
> 

Good (if accidental point).  Kiran, if you're going to gobble a megabyte,
you might as well use all of it and make the hashtable larger, rather than
just leaving 99% of that memory unused...
