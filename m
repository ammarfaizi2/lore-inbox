Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263798AbUEMGgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUEMGgR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbUEMGgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:36:17 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:21921 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263798AbUEMGgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:36:09 -0400
Date: Thu, 13 May 2004 15:35:05 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
In-reply-to: <1084413887.974.7.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: tokunaga.keiich@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net
Message-id: <20040513153505.21c5fc15.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
 <1083944945.23559.1.camel@nighthawk>
 <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
 <1084167941.28602.478.camel@nighthawk>
 <20040513102751.48c61d48.tokunaga.keiich@jp.fujitsu.com>
 <1084413887.974.7.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004 19:04:47 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Wed, 2004-05-12 at 18:27, Keiichiro Tokunaga wrote:
> > On Sun, 09 May 2004 22:45:42 -0700
> > Dave Hansen <haveblue@us.ibm.com> wrote:
> > 
> > > On Sun, 2004-05-09 at 18:47, Keiichiro Tokunaga wrote:
> > > > There is no NUMA support in the current code yet.  I'll post a
> > > > rough patch to show my idea soon.  I'm thinking to regard a
> > > > container device that has PXM as a NUMA node so far.
> > > 
> > > Don't you think it would be a good idea to work with some of the current
> > > code, instead of trying to wrap around it?  
> > 
> > Are you saying that LHNS should use the current NUMA code
> > (or coming code in the future) to support NUMA node hotplug?
> 
> Absolutely.  Why do we need wrappers when we can offline entire nodes
> with 6-line shell scripts?  The CPU hotplug interfaces are here today
> and the memory stuff will be here soon.  Perhaps you could help with the
> NUMA part.
> 
> #!/bin/sh
> NODENUM=$1
> NODEDIR=/sys/devices/system/node/node${NODENUM}
> for i in $NODEDIR/cpu* $NODEDIR/memory*; do
> 	echo 0 > $i/control/online
> fi
> echo 0 > $NODEDIR/control/online
> 
> We don't currently export bus to node mappings in sysfs, but we have
> them in the kernel, so that won't be too hard to export as well.  

LHNS is focusing on "container device hotplug". Container device
could contain CPUs, memory, and/or IO devices.  Container device
could contain only IO devices.  In this case, LHNS cannot use
$NODED/control/online (NUMA stuff) for the container device.

By the way, what happen when you issue
"echo 0 > $NODEDIR/control/online"?  Can you detach it
from the system after echo-ing?

Thanks,
Kei
