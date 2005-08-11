Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVHKTnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVHKTnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVHKTnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:43:40 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:64987 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932387AbVHKTnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:43:39 -0400
Date: Thu, 11 Aug 2005 15:43:36 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Christoph Hellwig <hch@infradead.org>
cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't use a klist for drivers' set-of-devices
In-Reply-To: <20050811185332.GA6870@infradead.org>
Message-ID: <Pine.LNX.4.44L0.0508111540420.6745-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Christoph Hellwig wrote:

> On Thu, Aug 11, 2005 at 11:24:23AM -0700, Greg KH wrote:
> > > This patch (as536) simplifies the driver-model core by replacing the klist 
> > > used to store the set of devices bound to a driver with a regular list 
> > > protected by a mutex.  It turns out that even with a klist, there are too 
> > > many opportunities for races for the list to be used safely by more than 
> > > one thread at a time.  And given that only one thread uses the list at any 
> > > moment, there's no need to add all the extra overhead of making it a 
> > > klist.
> > 
> > Hm, but that was the whole reason to go to a klist in the first place.
> 
> And shows once more that the klist approach was totally misguided.

I'll let Pat answer Christoph's comment.

Do note that the bus's list of devices and the bus's list of registered
drivers are still klists.  Only the driver's list of bound devices gets
reverted to a normal list.

Alan Stern

