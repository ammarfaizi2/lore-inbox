Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTDQPoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTDQPoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:44:14 -0400
Received: from galileo.bork.org ([66.11.174.148]:6931 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261695AbTDQPoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:44:11 -0400
Date: Thu, 17 Apr 2003 11:56:04 -0400
From: Martin Hicks <mort@wildopensource.com>
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: Martin Hicks <mort@wildopensource.com>, Patrick Mochel <mochel@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>, hpa@zytor.com, pavel@ucw.cz,
       jes@wildopensource.com, linux-kernel@vger.kernel.org, wildos@sgi.com
Subject: Re: [patch] printk subsystems
Message-ID: <20030417155604.GC543@bork.org>
References: <200304141533.18779.dsteklof@us.ibm.com> <Pine.LNX.4.44.0304161140160.912-100000@cherise> <20030416191619.GA3413@bork.org> <200304161243.58291.dsteklof@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304161243.58291.dsteklof@us.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Apr 16, 2003 at 12:43:58PM +0000, Daniel Stekloff wrote:
> On Wednesday 16 April 2003 07:16 pm, Martin Hicks wrote:
> > On Wed, Apr 16, 2003 at 11:42:59AM -0700, Patrick Mochel wrote:
> > > > I like the idea of having logging levels, which include debug, defined
> > > > by subsystem. Each subsystem will have separate requirements for
> > > > logging. Networking, for instance, already has the NETIF_MSG* levels
> > > > defined in netdevice.h that can be set with Ethtool. I can see, for
> > > > example, having the msg_enable not in the private data as it is now but
> > > > in the subsystem or class structure for that device, such as in struct
> > > > net_device. This could easily be exported through sysfs.
> > >
> > > It would be nice. Unfortunately, it's only a nifty pipe-dream at the
> > > moment, unless some lucky volunteer would like to step forward. ;)
> >
> > I guess my question is this:
> >
> > Is the patch I posted useful enough to go into the kernel?  I think it
> > is.  It introduces very little overhead, and provides most of the
> > functionality that you guys are discussing.  It does use sysctl, and not
> > sysfs but does that really matter?
> 
> 
> I would rather not see the filtering applied to printk specifically like 
> you've done it. I think this is still another stop gap measure for buffer 
> overruns. I would like to see for:
> 
> 1) Buffer overruns - a mechanism that wouldn't hit a buffer overrun, say a 
> relayfs implementation of printk that could be easily configured in, or a 
> mechanism that knows/reports when a overrun has happened like the Linux event 
> logging project.

I don't think relayfs solves the problem either.  This just adds an
extra dependency for yet another pseudo-filesystem.  printk is something
that needs to "just work" even if the kernel is in the midst of
crashing.  Adding the extra complexity of all printk going out through a
filesystem/buffer layer is not desirable, IMHO.

It seems that the relayfs solution for buffer overflows in the printk 
buffer is to just make lots of buffers.  I really want to be able to
turn off prink logging for stuff I don't care about, without the
complexity of having fifteen different logs to look in and changing 
how get get log info from the kernel to syslog.

> 
> 2) Message filtering - a mechanism above printk that allows filtering on the 
> fly and built into the new device model. Such a mechanism as Patrick 
> described that could be put into the dev_* macros in device.h. 

I haven't looked into these features too much.  Is every piece of
hardware in a machine considered a device?
i.e., can messages from CPU probing, Memory, NUMA nodes, etc. be
filtered separately while changing the logging level on these devices at
runtime?

The dev_* printk macros are all, of course, resolved at runtime.  How
does one control these printk's at runtime?

mh

-- 
Wild Open Source Inc.                  mort@wildopensource.com
