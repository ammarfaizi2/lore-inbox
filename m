Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUGBVL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUGBVL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUGBVL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:11:57 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47632 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S264984AbUGBVLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:11:52 -0400
Date: Fri, 2 Jul 2004 17:11:52 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
cc: Duncan Sands <baldrick@free.fr>, <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       "David A. Desrosiers" <desrod@gnu-designs.com>
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
In-Reply-To: <20040702204756.GC3447@babylon.d2dc.net>
Message-ID: <Pine.LNX.4.44L0.0407021700110.21819-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2004, Zephaniah E. Hull wrote:

> On Tue, Jun 08, 2004 at 10:19:40PM +0200, Duncan Sands wrote:
> > > Great, could you send me the patch? (So I have something usable until it
> > > gets into mainline and a kernel is released with it.)
> > 
> > Sure - I just have to write it first!  It's a bit tricky to do right...
> 
> Has there been any progress on this?
> 
> I have been looking at the code in question and I am curious as to what
> events we are attempting to protect against with the serialize spinlock?
> 
> Thanks.

There has been progress.  If you start with the latest 2.6.7 kernels 
(vanilla or -mm) and apply these two patches:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108810394203966&q=raw
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108810535225278&q=raw

the deadlock problems should be solved.  Although those patches haven't 
yet been merged, I'm pretty sure they will be.

To answer your other question...  The serialize semaphore (not spinlock) 
prevents the system from trying to do several incompatible things to a USB 
device at the same time.  For example, reset the device while a driver is 
probing it.  Or reset it while it is being suspended.

Alan Stern

