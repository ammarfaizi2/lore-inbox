Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTEPSyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTEPSyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:54:02 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:35905 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264582AbTEPSxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:53:22 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305161422280.1310-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305161422280.1310-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053111958.2606.69.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 May 2003 14:05:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 13:40, Alan Stern wrote:

> I disagree with 1.  When one port has an attached device there won't be
> any problem because suspends will never occur (since one port is active).
> ...
> > For the case of all ports hardwired OC, this
> > will work because you suspend the whole controller
> > and never get a valid resume.
> 
> Not suspending isn't really a big deal.  After all, we would suspend only 
> when no devices are plugged in anyway.  Is the PIIX4 chipset used in 
> laptops, where the power saving might be important?  That's the only 
> reason I can think of for wanting to suspend whenever possible.

OK, my bad. I thought global suspend could occur
with devices plugged in, if not that makes #1 a non issue.

The PIIX4E (same ID, same bug) is used in some laptops.
I would assume the 99% of laptop users without the OC
condition would like to save power.

I don't want to get in the way of the vast majority
of users for these rare special cases.

Since the thrashing is not a problem (no global suspend
when a device is plugged in), the only downside of
your original qualify wakeup plan is the possibility of
missing a valid resume once a transient OC condition is cleared.

Maybe just polling individual ports for OC cleared and
RD set to do a global wakeup?

You convinced me that the qualified wakeup is the
way to go.

-- 
Paul Fulghum
paulkf@microgate.com

