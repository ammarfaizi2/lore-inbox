Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUIEC6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUIEC6P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 22:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUIEC6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 22:58:15 -0400
Received: from peabody.ximian.com ([130.57.169.10]:39131 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266137AbUIEC6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 22:58:08 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040904005433.GA18229@kroah.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
	 <1094142321.2284.12.camel@betsy.boston.ximian.com>
	 <20040904005433.GA18229@kroah.com>
Content-Type: text/plain
Date: Sat, 04 Sep 2004 22:58:08 -0400
Message-Id: <1094353088.2591.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-04 at 02:54 +0200, Greg KH wrote:

> So, we're back to the original issue.  Why is this kernel event system
> different from the hotplug system?  I would argue there isn't one,
> becides the transport, as you seem to want everything that we currently
> provide in the current kobject_hotplug() call.
> 
> But transports are important, I agree.
> 
> How about you just add the ability to send hotplug calls across netlink?
> Make it so the kobject_hotplug() function does both the exec() call, and
> a netlink call (based on a config option for those people who like to
> configure such stuff.)

This smells.

Look, I agree that unifying the two ideas and transports as much as
possible is the right way to proceed.  But the fact is, as you said,
transports _are_ important.  And simply always sending out a hotplug
event _and_ a netlink event is silly and superfluous.  We need to make
up our minds.

I don't think anyone argues that netlink makes sense for these low
priority asynchronous events.

I'd prefer to integrate the two approaches as much as possible, but keep
the two transports separate.  Use hotplug for hotplug events as we do
now and use kevent, which is over netlink, for the new events we want to
add.

Maybe always do the kevent from the hotplug, but definitely do not do
the hotplug from all kevents.  It is redundant and extra overhead.

Doing both simultaneous begs the question of why have both.  Picking the
right tool for the job is, well, the right tool for the job.

	Robert Love


