Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbWJXPbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbWJXPbT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWJXPbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:31:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:54985 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965054AbWJXPbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:31:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Chinner <dgc@sgi.com>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Tue, 24 Oct 2006 17:29:59 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, xfs@oss.sgi.com
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <20061024144446.GD11034@melbourne.sgi.com>
In-Reply-To: <20061024144446.GD11034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610241730.00488.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 October 2006 16:44, David Chinner wrote:
> On Mon, Oct 23, 2006 at 12:36:53PM +0200, Rafael J. Wysocki wrote:
> > On Monday, 23 October 2006 06:12, Nigel Cunningham wrote:
> > > XFS can continue to submit I/O from a timer routine, even after
> > > freezeable kernel and userspace threads are frozen. This doesn't seem to
> > > be an issue for current swsusp code,
> > 
> > So it doesn't look like we need the patch _now_.
> > 
> > > but is definitely an issue for Suspend2, where the pages being written could
> > > be overwritten by Suspend2's atomic copy.
> > 
> > And IMO that's a good reason why we shouldn't use RCU pages for storing the
> > image.  XFS is one known example that breaks things if we do so and
> > there may be more such things that we don't know of.  The fact that they
> > haven't appeared in testing so far doesn't mean they don't exist and
> > moreover some things like that may appear in the future.
> 
> Could you please tell us which XFS bits are broken so we can get
> them fixed?  The XFS daemons should all be checking if they are
> supposed to freeze (i.e. they call try_to_freeze() after they wake
> up due to timer expiry) so I thought they were doing the right
> thing.
> 
> However, I have to say that I agree with freezing the filesystems
> before suspend - at least XFS will be in a consistent state that can
> be recovered from without corruption if your machine fails to
> resume....

Do you mean calling sys_sync() after the userspace has been frozen
may not be sufficient?

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
