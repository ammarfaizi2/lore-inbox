Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267486AbUGNRuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267486AbUGNRuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 13:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267488AbUGNRuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 13:50:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:52354 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267486AbUGNRuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 13:50:06 -0400
Date: Wed, 14 Jul 2004 23:19:49 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040714174948.GA3935@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714082621.GA4291@in.ibm.com> <20040714142614.GA15742@kroah.com> <20040714152235.GA5956@in.ibm.com> <20040714170336.GB4636@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714170336.GB4636@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 10:03:37AM -0700, Greg KH wrote:
> On Wed, Jul 14, 2004 at 08:52:35PM +0530, Dipankar Sarma wrote:
> > And I suspect that Andrew thwak me for trying to increase dentry size :)
> > Anyway, the summary is this - Kiran is not trying to introduce
> > a new refcounting API.
> 
> Yes he is.  He's calling it refcount.h, and creating a typedef called
> refcount_t.  Sure looks like a new refcount API to me :)

OK, in terms of code, it is new API. Just the refcounting mechanism
is same as existing non-kref refcounts.

> > He is just adding lock-free support from an existing refcounting
> > mechanism that is used in VFS.
> 
> If this is true, then I strongly object to the naming of this file, and
> the name of the typedef (which shouldn't be a typedef at all) and this
> should be made a private data structure to the vfs so no one else tries
> to use it.  Otherwise it will be used.

I am reasonably sure that when that patch was done (months ago) kref wasn't
there. Now that kref.[ch] is around, everything can be put there.

Now, if struct kref is shrinked (want patch ? ;-), all this 
can possibly be nicely collapsed into one set of APIs for refcounting.
There aren't many users of kref yet, so this seems like a good
time to do it. Was there any objection to shrinking it ?


Thanks
Dipankar
