Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUCCWNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUCCWM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:12:28 -0500
Received: from ida.rowland.org ([192.131.102.52]:38660 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261211AbUCCWLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:11:03 -0500
Date: Wed, 3 Mar 2004 17:11:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about (or bug in?) the kobject implementation
In-Reply-To: <20040303214431.GC32489@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0403031702200.890-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Greg KH wrote:

> On Fri, Feb 27, 2004 at 11:02:34PM -0500, Alan Stern wrote:
> > We're actually discussing two different questions here.
> > 
> >     A.	Is it okay to call kobject_add() after calling kobject_del() -- 
> > 	this was my original question.
> 
> No, this is not ok.  It might happen to work, but it is not valid.

I want to understand _why_ it is not valid.  Can you explain please?

>From what you said earlier, I got the impression that calling _add() after 
_del() is illegal because it runs the risk that the refcount may be 0 and 
the object may be gone.  But if you have a separate valid reference, that 
can't happen.  Would it be legal then, or is there more to it?


> >     B.	Can we prevent people from doing kobject_get() after the kobject's
> > 	refcount has dropped to 0?
> 
> By saying, "you can not call kobject_get() on a object that you know is
> released with kobject_del()".  If you already have a valid reference,
> you can always call kobject_get().  But once you call kobject_del() that
> pointer you passed should not be passed to kobject_get() as it may now
> be gone.
> 
> Does that help?
> 
> thanks,
> 
> greg k-h

Alan Stern

