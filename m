Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUHCG5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUHCG5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 02:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUHCG5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 02:57:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:26790 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265124AbUHCG45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 02:56:57 -0400
Date: Mon, 2 Aug 2004 23:51:30 -0700
From: Greg KH <greg@kroah.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Add kref_read and kref_put_last primitives
Message-ID: <20040803065130.GA10696@kroah.com>
References: <20040726144856.GH1231@obelix.in.ibm.com> <20040726173151.A11637@infradead.org> <20040802200849.GG28374@kroah.com> <20040803054218.GA4443@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803054218.GA4443@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 11:12:18AM +0530, Dipankar Sarma wrote:
> On Mon, Aug 02, 2004 at 01:08:49PM -0700, Greg KH wrote:
> > On Mon, Jul 26, 2004 at 05:31:51PM +0100, Christoph Hellwig wrote:
> > > Why don't you simply use an atomic_t if that's what you seem to
> > > want?
> > 
> > Exactly.  In cases like this, where the user, for some reason, wants to
> > know the state of the reference count, they should not use a struct
> > kref.  I'm not going to add these functions to the kref api, sorry.
> > 
> 
> Really, there is no need to use kref in where Ravikiran is using
> them (VFS) under the current circumstances. However, if lock-free 
> lookup using RCU is to be used, Ravikiran needs to use an abstracted reference 
> counter API. This is to optimally support platforms with and without 
> cmpxchg. kref is the standard reference counter API at the moment and 
> that is where it made sense to add the abstracted lockfree reference counter
> support.

Hm, I still don't agree :)

> So, kref_read() as it is would look weird. But if we consider merging
> the rest of the kref APIs (lock-free extensions) in future, then the
> entire set including kref_read() would make sense.

No, even with rcu versions, I don't see the need for this in the api.

Sure, for this specific implementation of a atomic_t, it is useful, as
the value is checked.  But that means that you might just want to use an
atomic_t, as it doesn't fit the model of a struct kref at all (something
where you don't touch the reference count directly at all.)

Becides, I don't think that people are convinced that this code needs to
be changed anyway :)

thanks,

greg k-h
