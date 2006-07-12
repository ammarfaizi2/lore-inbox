Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWGLOTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWGLOTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWGLOTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:19:41 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43016 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750780AbWGLOTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:19:41 -0400
Date: Wed, 12 Jul 2006 10:19:39 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Dave Jones <davej@redhat.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re:  annoying frequent overcurrent messages.
In-Reply-To: <200607111747.13529.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0607121012570.6607-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> I have a box that's having its dmesg flooded with..
> 
> hub 1-0:1.0: over-current change on port 1
> hub 1-0:1.0: over-current change on port 2
> hub 1-0:1.0: over-current change on port 1
> hub 1-0:1.0: over-current change on port 2
...

> over and over again..
> The thing is, this box doesn't even have any USB devices connected to it,
> so there's absolutely nothing I can do to remedy this.

Well, overcurrent is a potentially dangerous situation.  That's why it 
gets reported with dev_err priority.

Evidently it's a hardware fault.  Perhaps the overcurrent-detect input 
lines are floating and constantly triggering as a result.  It's not even 
clear that attaching a USB device would make the problem go away.

Since you're not using the UHCI controller on that computer, you could 
simply rmmod uhci-hcd (or modify /etc/modprobe.conf to prevent it from 
being loaded in the first place).  That would stop the constant interrupts 
and the syslog spamming.

But as for fixing the underlying hardware problem, I don't think there's 
anything we can do.

Alan Stern

