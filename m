Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269131AbUIBWTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269131AbUIBWTv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269091AbUIBWSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:18:54 -0400
Received: from soundwarez.org ([217.160.171.123]:35202 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S269185AbUIBWPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:15:53 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Kay Sievers <kay.sievers@vrfy.org>
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: Robert Love <rml@ximian.com>, Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1094157902.1316.83.camel@DYN319498.beaverton.ibm.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <1094004324.1916.63.camel@localhost.localdomain>
	 <20040901100750.GA23337@vrfy.org>
	 <1094157902.1316.83.camel@DYN319498.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 03 Sep 2004 00:15:50 +0200
Message-Id: <1094163351.26430.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 13:45 -0700, Daniel Stekloff wrote:
> On Wed, 2004-09-01 at 03:07, Kay Sievers wrote:
> [snip]
> > The motivation for doing this, is the ambitioned idea, that _data_ should
> > only be exposed through sysfs values to userspace. This would make it
> > possible for userspace to scan any state at any time, regardless of a
> > received event. Which should make the whole setup more reliable, as
> > applications can just read in the state at startup. We do a similar job
> > with udevstart, as all lost hotplug events during the early boot are
> > recovered just by reading sysfs and synthesize these events for creating
> > device nodes.
> > 
> > The same applies to the way back to the kernel. We don't want to send
> > data over the netlink back to the kernel, we can write to sysfs.
> 
> 
> Ok.. so if I wanted to send an event (that included data at event time)
> from a driver for a particular device, I would send the event with the
> send_kevent() call and create and maintain an attribute for that
> specific event. In order for an application to receive the data for the
> event, the driver would need to store the data for that event somewhere
> and keep it. Unless there's a write attribute to tell me it's been read,
> I must maintain it or write over it if the same event occurs again. 
> 
> Is this how it's supposed to work? 

No, the current version(idea) is mainly a sysfs/kobject notification,
not a data channel, or something that requires a more complicated logic.
(but, yes, your example applies to simple event sequence numbers too. We
can't expose these kind of "snapshot data" by a sysfs value).

> Even though 1) there won't be many events and 2) few events will include
> data - don't you think this is a bit too much development overhead for
> the driver? 
> 
> If you had the payload with the event, you could fire and forget. It
> would be fewer steps for the driver and require less management and
> storage.

There will be only very few cases for that, but some drivers will want
to send these kind of information to userspace (even binary blobs). 

Don't know if this kind of data dump should be part of kevent or better
handled by something driver specific. It gets even more complicated, if
the userspace listener must interpret all these different data formats.

Maybe we just need to rename "kevent" to "kobject_notify" to make the
focus more clear :)

Thanks,
Kay

