Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUCCWRI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUCCWRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:17:08 -0500
Received: from mail.kroah.org ([65.200.24.183]:41686 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261191AbUCCWRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:17:02 -0500
Date: Wed, 3 Mar 2004 14:16:46 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about (or bug in?) the kobject implementation
Message-ID: <20040303221646.GA425@kroah.com>
References: <20040303214431.GC32489@kroah.com> <Pine.LNX.4.44L0.0403031702200.890-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0403031702200.890-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 05:11:02PM -0500, Alan Stern wrote:
> On Wed, 3 Mar 2004, Greg KH wrote:
> 
> > On Fri, Feb 27, 2004 at 11:02:34PM -0500, Alan Stern wrote:
> > > We're actually discussing two different questions here.
> > > 
> > >     A.	Is it okay to call kobject_add() after calling kobject_del() -- 
> > > 	this was my original question.
> > 
> > No, this is not ok.  It might happen to work, but it is not valid.
> 
> I want to understand _why_ it is not valid.  Can you explain please?
> 
> From what you said earlier, I got the impression that calling _add() after 
> _del() is illegal because it runs the risk that the refcount may be 0 and 
> the object may be gone.

Yes, that is the risk.

> But if you have a separate valid reference, that can't happen.  Would
> it be legal then, or is there more to it?

Hm, it probably would work, hence the current working USB code :)
But I really don't want to "special case" anything here.  So it's easier
to say, "just don't do that".

thanks,

greg k-h
