Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUCCVvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUCCVvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:51:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:60875 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261162AbUCCVvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:51:04 -0500
Date: Wed, 3 Mar 2004 13:44:31 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about (or bug in?) the kobject implementation
Message-ID: <20040303214431.GC32489@kroah.com>
References: <Pine.LNX.4.44L0.0402272233330.4063-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0402272233330.4063-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 11:02:34PM -0500, Alan Stern wrote:
> On Fri, 27 Feb 2004, Greg KH wrote:
> 
> > Seriously, once kobject_del() is called, you can't safely call
> > kobject_get() anymore on that object.
> > 
> > If you can think of a way we can implement this in the code to prevent
> > people from doing this, please send a patch.  We've been getting by
> > without such a "safeguard" so far...
> 
> The problem is unsolvable.  Let me explain...
> 
> We're actually discussing two different questions here.
> 
>     A.	Is it okay to call kobject_add() after calling kobject_del() -- 
> 	this was my original question.

No, this is not ok.  It might happen to work, but it is not valid.

>     B.	Can we prevent people from doing kobject_get() after the kobject's
> 	refcount has dropped to 0?

By saying, "you can not call kobject_get() on a object that you know is
released with kobject_del()".  If you already have a valid reference,
you can always call kobject_get().  But once you call kobject_del() that
pointer you passed should not be passed to kobject_get() as it may now
be gone.

Does that help?

thanks,

greg k-h
