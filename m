Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWJEQVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWJEQVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWJEQVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:21:51 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51984 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751514AbWJEQVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:21:50 -0400
Date: Thu, 5 Oct 2006 12:21:45 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] error to be returned while suspended
In-Reply-To: <200610050907.27035.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0610051219500.6596-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Oliver Neukum wrote:

> > > > If you are talking runtime suspend, you should probably just wake the
> > > > device up on first access.
> > > 
> > > Do you really think a device driver should override an explicitely
> > > selected power state?
> > 
> > (So we are talking runtime suspend?)
> 
> Yes. Otherwise the patch would have been ready two days ago.
> But if I am implenting this, I'll do a full implementation.
> 
> > No, I do not know what the right interface is. I started to suspect
> > that drivers should suspend/resume devices automatically, without
> > userland help. Maybe having autosuspend_timeout in sysfs is enough.
> 
> If you do this at kernel level, you'll screw up any demon implementing
> a power policy to stay within the budget.

Currently we don't have any userspace APIs for such a daemon to use.  The 
only existing API is deprecated and will go away soon.

Current thinking is that a driver will suspend its device whenever the 
device isn't in use.  With usblp, that would be whenever the device file 
isn't open.  See the example code in usb-skeleton.c.

Alan Stern

