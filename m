Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWBOWYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWBOWYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWBOWYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:24:40 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:920 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751333AbWBOWYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:24:39 -0500
Date: Wed, 15 Feb 2006 17:24:38 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
In-Reply-To: <1140033491.2883.11.camel@mulgrave.il.steeleye.com>
Message-ID: <Pine.LNX.4.44L0.0602151722250.4817-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006, James Bottomley wrote:

> On Wed, 2006-02-15 at 11:07 -0500, Alan Stern wrote:
> > Could we perhaps make this safer and more general?
> > 
> > For instance, add to struct device a "pending puts" counter and a list
> > header (both protected by a global spinlock), and have a kernel thread
> > periodically check the list, doing put_device wherever needed.  How does
> > that sound?
> 
> That's what I've been discussing with Jens elsewhere on this list.
> However, I think what you're proposing is overly complex.  All we really
> need is for a way of flagging a kobject (or kref) so the final put will
> be in user context.  Then we can use storage within the kobject or
> device (or something else) for the purpose.

That's more or less what I was suggesting.  The problems are: How do you 
know which put is the last?  (Answer: you don't.  So every put has to be 
done in process context.)  And how do you flag the data structure and tell 
some process thread to do the put?  (Answer: by putting the object on a 
list, as in my suggestion.)

Alan Stern

