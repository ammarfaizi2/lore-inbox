Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbUEMCE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUEMCE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 22:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbUEMCE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 22:04:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:11222 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263741AbUEMCEv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 22:04:51 -0400
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
From: Dave Hansen <haveblue@us.ibm.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hotplug devel <linux-hotplug-devel@lists.sourceforge.net>,
       lhns-devel@lists.sourceforge.net
In-Reply-To: <20040513102751.48c61d48.tokunaga.keiich@jp.fujitsu.com>
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
	 <1083944945.23559.1.camel@nighthawk>
	 <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
	 <1084167941.28602.478.camel@nighthawk>
	 <20040513102751.48c61d48.tokunaga.keiich@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1084413887.974.7.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 19:04:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-12 at 18:27, Keiichiro Tokunaga wrote:
> On Sun, 09 May 2004 22:45:42 -0700
> Dave Hansen <haveblue@us.ibm.com> wrote:
> 
> > On Sun, 2004-05-09 at 18:47, Keiichiro Tokunaga wrote:
> > > There is no NUMA support in the current code yet.  I'll post a
> > > rough patch to show my idea soon.  I'm thinking to regard a
> > > container device that has PXM as a NUMA node so far.
> > 
> > Don't you think it would be a good idea to work with some of the current
> > code, instead of trying to wrap around it?  
> 
> Are you saying that LHNS should use the current NUMA code
> (or coming code in the future) to support NUMA node hotplug?

Absolutely.  Why do we need wrappers when we can offline entire nodes
with 6-line shell scripts?  The CPU hotplug interfaces are here today
and the memory stuff will be here soon.  Perhaps you could help with the
NUMA part.

#!/bin/sh
NODENUM=$1
NODEDIR=/sys/devices/system/node/node${NODENUM}
for i in $NODEDIR/cpu* $NODEDIR/memory*; do
	echo 0 > $i/control/online
fi
echo 0 > $NODEDIR/control/online

We don't currently export bus to node mappings in sysfs, but we have
them in the kernel, so that won't be too hard to export as well.  

-- Dave

