Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264567AbTDPTdv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTDPTdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:33:51 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:48593 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264567AbTDPTds convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:33:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Martin Hicks <mort@wildopensource.com>, Patrick Mochel <mochel@osdl.org>
Subject: Re: [patch] printk subsystems
Date: Wed, 16 Apr 2003 12:43:58 +0000
User-Agent: KMail/1.4.1
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Martin Hicks <mort@wildopensource.com>,
       hpa@zytor.com, pavel@ucw.cz, jes@wildopensource.com,
       linux-kernel@vger.kernel.org, wildos@sgi.com
References: <200304141533.18779.dsteklof@us.ibm.com> <Pine.LNX.4.44.0304161140160.912-100000@cherise> <20030416191619.GA3413@bork.org>
In-Reply-To: <20030416191619.GA3413@bork.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304161243.58291.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 April 2003 07:16 pm, Martin Hicks wrote:
> On Wed, Apr 16, 2003 at 11:42:59AM -0700, Patrick Mochel wrote:
> > > I like the idea of having logging levels, which include debug, defined
> > > by subsystem. Each subsystem will have separate requirements for
> > > logging. Networking, for instance, already has the NETIF_MSG* levels
> > > defined in netdevice.h that can be set with Ethtool. I can see, for
> > > example, having the msg_enable not in the private data as it is now but
> > > in the subsystem or class structure for that device, such as in struct
> > > net_device. This could easily be exported through sysfs.
> >
> > It would be nice. Unfortunately, it's only a nifty pipe-dream at the
> > moment, unless some lucky volunteer would like to step forward. ;)
>
> I guess my question is this:
>
> Is the patch I posted useful enough to go into the kernel?  I think it
> is.  It introduces very little overhead, and provides most of the
> functionality that you guys are discussing.  It does use sysctl, and not
> sysfs but does that really matter?


I would rather not see the filtering applied to printk specifically like 
you've done it. I think this is still another stop gap measure for buffer 
overruns. I would like to see for:

1) Buffer overruns - a mechanism that wouldn't hit a buffer overrun, say a 
relayfs implementation of printk that could be easily configured in, or a 
mechanism that knows/reports when a overrun has happened like the Linux event 
logging project.

For relayfs, please see: http://www.opersys.com/relayfs/index.html
For event logging, please see: http://evlog.sourceforge.net/

2) Message filtering - a mechanism above printk that allows filtering on the 
fly and built into the new device model. Such a mechanism as Patrick 
described that could be put into the dev_* macros in device.h. 

Thanks,

Dan



> mh

