Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267465AbUGNRJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267465AbUGNRJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 13:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267468AbUGNRJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 13:09:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:46244 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267465AbUGNRJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 13:09:56 -0400
Date: Wed, 14 Jul 2004 10:08:00 -0700
From: Greg KH <greg@kroah.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040714170800.GC4636@kroah.com>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714085758.GA4165@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714085758.GA4165@obelix.in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 02:27:58PM +0530, Ravikiran G Thirumalai wrote:
> On Wed, Jul 14, 2004 at 12:07:00AM -0700, Greg KH wrote:
> > On Wed, Jul 14, 2004 at 10:23:50AM +0530, Ravikiran G Thirumalai wrote:
> > > 
> > > The attatched patch provides infrastructure for refcounting of objects
> > > in a rcu protected collection.
> > 
> > This is really close to the kref implementation.  Why not just use that
> > instead?
> 
> Close, but not the same.  I just had a quick look at krefs.
> Actually, this refrerence count infrastructure I am proposing is not for 
> traditional refcounting.

But you are advertising it as such by calling it a refcount_t and
putting it in a file called refcount.h.

> > Oh, and I think you need to use atomic_set() instead of initializing the
> > atomic_t by hand.
> 
> I have used atomic_set for the case where arch has cmpxchg.  But for 
> arches lacking cmpxchg, I need to use hashed spinlocks to implement 
> the ref_count_get_rcu.
> No point in having more atomic operations when I hold spinlocks.  Admittedly,
> might be a bit yucky to assume atomic_t internals, but it is just one header
> file :) <ducks>

I still think you need to fix this, manipulating atomic_t variables by
hand is not always guaranteed to work on all arches, from what I
remember.

And what arches do not support cmpxchg?  How does this change affect the
performance of them?

thanks,

greg k-h
