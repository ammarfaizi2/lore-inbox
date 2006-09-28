Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751715AbWI1HO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWI1HO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWI1HO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:14:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751439AbWI1HOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:14:55 -0400
Date: Thu, 28 Sep 2006 00:05:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 perfmon new code base + libpfm + pfmon
Message-Id: <20060928000516.1a0aaca0.akpm@osdl.org>
In-Reply-To: <20060928064949.GA18245@frankl.hpl.hp.com>
References: <20060926143420.GF14550@frankl.hpl.hp.com>
	<20060926220951.39bd344f.akpm@osdl.org>
	<20060927224832.GA17883@frankl.hpl.hp.com>
	<20060927163100.e83a1f79.akpm@osdl.org>
	<20060928064949.GA18245@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 23:49:49 -0700
Stephane Eranian <eranian@hpl.hp.com> wrote:

> Andrew,
> 
> On Wed, Sep 27, 2006 at 04:31:00PM -0700, Andrew Morton wrote:
> > > 
> > > Here is the summary of the various point raised by your review and the current
> > > status. I am hoping to close all points by next release.
> > > 
> > > ...
> > > 
> > > [akpm]: use fget_light() in some place instead of fget()
> > > 	- not sure understand when to use one versus the other
> > >
> > 
> > They are always interchangeable.  fget_light() is simply an optimised,
> > messier-to-use version.
> 
> What are exactly the assumptions of fget_light()?

Just the ones in the comment, really - it assumes that the caller has a
single ref on the file.  ie: we're within a system call which passed in an
fd, or within a pagefault and this file* is current->mm->some_vma->vm_file.

You _might_ get into trouble if using it against some file* which belongs
to a different process, and if you don't already have a ref on that file*. 
But that's usually a bug anyway, unless the code is aware of and is
exploiting the RCU management of these things.

There are lots of example usages around the place.

> > 
> > >
> > > ..
> > >
> > > [akpm]: carta_random32() should be in another header file
> > > 	- yes, I know. Should I create a specific header file? I don't think random.h
> > > 	  is meant for this.
> > 
> > I suppose so.  Or just stick the declaration into kernel.h.
> > 
> > I had a patch go past the other day which had a hand-rolled
> > fast-but-not-very-good pseudo random number generator in it.  I couldn't
> > remember where I'd seen one, and now I can't remember what patch it was
> > that needed it.  Sigh.
> > 
> > Anyway, a standalone patch which adds that function into lib/whatever.c
> > would be nice.
> 
> I will post a standalone patch for carta random. I can provide a standalone header
> file in include/linux/carta_random.h. 

Thanks.
