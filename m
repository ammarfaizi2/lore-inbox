Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVCPVrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVCPVrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVCPVra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:47:30 -0500
Received: from ida.rowland.org ([192.131.102.52]:7940 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262813AbVCPVgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:36:44 -0500
Date: Wed, 16 Mar 2005 16:36:43 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: linux-os <linux-os@analogic.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Locking changes to the driver-model core
In-Reply-To: <Pine.LNX.4.61.0503161602530.6525@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44L0.0503161629550.639-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005, linux-os wrote:

> Thought experiment:
> Suppose you had a kernel-thread whos duty it was to handle the
> shutdown and restarting of devices on such busses. Since it
> is the only thing that would touch such code, wouldn't things
> be a lot simpler and not subject to deadlocks?
> 
> Code calls something that puts the stuff the kernel thread is
> supposed to do, in a queue. The daemon handles it and wakes
> up the caller when it's done, or it failed.
> 
> Queues are easy and they don't deadlock.

While this might work, it has the disadvantage of funnelling everything 
through a single thread.  Operations on different buses couldn't take 
place simultaneously the way they can even now.  My proposal would allow 
even more parallelism than there is currently.

Also there are more code regions that need protection against simultaneous
device access than just the parts involved in registering and
unregistering devices and drivers.  So the semaphores would still be
necessary, and with them comes the possibility of deadlocks.  (Such 
semaphores already exist in the USB subsystem; a large part of my proposal 
involves moving them out to the entire driver model.)

Alan Stern

