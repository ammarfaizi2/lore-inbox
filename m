Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWJESZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWJESZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWJESYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:24:49 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:32779 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751008AbWJESYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:24:21 -0400
Date: Thu, 5 Oct 2006 14:24:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] error to be returned while suspended
In-Reply-To: <200610051835.21704.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0610051418540.6897-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Oliver Neukum wrote:

> Am Donnerstag, 5. Oktober 2006 18:21 schrieb Alan Stern:
> > Currently we don't have any userspace APIs for such a daemon to use.  The 
> > only existing API is deprecated and will go away soon.
> 
> I trust it'll be replaced.

Yes.  I think Greg wants to wait until the old API is completely gone.

> > Current thinking is that a driver will suspend its device whenever the 
> > device isn't in use.  With usblp, that would be whenever the device file 
> > isn't open.  See the example code in usb-skeleton.c.
> 
> In the general case the idea seems insufficient. If I close my laptop's lid
> I want all input devices suspended, whether the corresponding files are
> opened or not. In fact, if I have port level power control I might even
> want to cut power to them.

That's a separate issue.  You were talking about runtime suspend, but 
closing the laptop's lid is a system suspend.

Assuming some sort of mechanism is in place to do a suspend-to-RAM or 
suspend-to-disk when the lid is closed, the driver's suspend and resume 
methods will be called in the normal way.  The driver doesn't need to do 
anything special to accomodate it.

The only special thing you need to do is autosuspend when the device isn't
in use, so that even when the laptop's lid is open you can still avoid
using unnecessary power.

Alan Stern

P.S.: Cutting off port power is yet another issue.  It isn't a suspend in 
the strict sense, because it will break an existing power session.

