Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbSI0LVt>; Fri, 27 Sep 2002 07:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261692AbSI0LVt>; Fri, 27 Sep 2002 07:21:49 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:17138
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261563AbSI0LVs>; Fri, 27 Sep 2002 07:21:48 -0400
Subject: Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI
	RAIDdevice  driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry Kessler <kessler@us.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
In-Reply-To: <3D939075.897C9021@us.ibm.com>
References: <3D8FC5BC.51A8FCCF@us.ibm.com>  <3D8FCC53.3070809@pobox.com>
	<1033055520.11848.49.camel@irongate.swansea.linux.org.uk> 
	<3D939075.897C9021@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Sep 2002 12:32:08 +0100
Message-Id: <1033126328.15269.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-26 at 23:55, Larry Kessler wrote:
> At the risk of reading more into your suggestion than you intended...
> Are you supportive of adding infrastructure into the kernel that 
> provides, conceptually at least, the sort of things that Rusty and
> I (and others) are after ?

Sort of. We have a problem about consistently reporting which device. So
dev_printk(dev, ...) is printk that formats up the device info for you.
Its also easy to use and happens to pass a device pointer into the
places you want it for more detailed logging

> Provide a reasonable and printk-like interface (like you've
> shown above), that writes to printk if advanced logging is not 
> configured; but, if advanced logging is configured... 

I'm trying to make sure the right data is available. I don't *care* what
you do with it after it gets thrown at you. If I have to care what you
are doing with the data the interface is wrong.


> 1) It will take time for device drivers to migrate to a new interface

Who cares. Migrate the devices you care about one at a time, test them
and worry about just those. Do you need 120 highly available network
card drivers. Do you need telco grade soundblaster 16 ?

> 3) we should avoid modifying current printk behavior 

We don't. We add an extra helper that builds on it in a totally logical
fashion. The existing one doesnt break, its merely something to be
polished when needed by the folks who care

> 4) advanced logging must be an optional feature to avoid the overhead
>    where its not wanted or needed 

And dev_printk is going to be under 1K. What you do with the data isnt
my problem.


> 5) User-space utilities already exist (evlog.sourceforge.net)

Again, this is about what you do with the data for your cases.
dev_printk is about making the info available cleanly

> and of course, mindful that the 2.5 window is closing in 1 month.

For core code changes for 2.6 base Linus tree. So you end up with a set
of patches you add over time. I would note however that the default
dev_printk() routine that just reformats up as

<level>%s: message

is not exactly taxing to get into 2.5 before October 31st, being about
10 lines long. That gives you the infrastructure to know what is going
on. Similarly I don't think its infeasible to get the state interface
into the base kernel just flipping flags in the device structure.

That makes it easy to add the needed pieces to base kernel code during
the driver work after Oct 31st, but without having to import all the
event logging stuff which wants hammering out over a longer period of
time

