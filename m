Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVBYXEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVBYXEc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 18:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVBYXC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 18:02:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:58845 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262789AbVBYXCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 18:02:09 -0500
Date: Fri, 25 Feb 2005 15:00:14 -0800
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] I2C patch 2 - break up the SMBus formatting
Message-ID: <20050225230014.GB28235@kroah.com>
References: <421E62DD.5030608@acm.org> <20050225214439.GC27270@kroah.com> <421FAACB.4080207@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421FAACB.4080207@acm.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 04:46:35PM -0600, Corey Minyard wrote:
> Greg KH wrote:
> 
> >On Thu, Feb 24, 2005 at 05:27:25PM -0600, Corey Minyard wrote:
> > 
> >
> >>+
> >>+	/* It's wierd, but we use a usecount to track if an q entry is
> >>+	   in use and when it should be reported back to the user. */
> >>+	atomic_t usecount;
> >>   
> >>
> >
> >Please use a kref here instead of rolling your own.
> > 
> >
> There's a trick I'm playing to avoid having to use a lock on the normal 
> entry_put() case.  It let's the entry_get() routine detect that the 
> object is about to be destroyed.  You can't do it with the current kref, 
> but you could easily extend kref to allow it.

No, kref is ment to have an external lock protect it from this kind of
race.  That's documented.

> It's simple to implement, but the documentation on how to use it will
> be 10 times larger than the code :).
> 
> I'll work on a patch to kref to add that, if you don't mind.

I'll always look at patches :)

thanks,

greg k-h
