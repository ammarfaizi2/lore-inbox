Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270483AbTHQSiu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 14:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTHQSiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 14:38:50 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:58537
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S270483AbTHQSis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 14:38:48 -0400
Date: Sun, 17 Aug 2003 14:38:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [bk patches] add ethtool_ops to net drivers
Message-ID: <20030817183848.GA18728@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

In order to maintain backwards compatibility and minimize impact,
netdev_ops mentioned at KS was scaled back to ethtool_ops.  This allows
driver-at-a-time replacement often-duplicated ioctl handling code with a
Linux-style foo_ops set of function pointers.

Also, I've been waiting on this patch to begin attacking the stack
usage problems that often occur in ethtool ioctl handlers.  Since gcc
sums instead of unions disjoint stack scopes (gcc bug #9997), huge
functions that handle a bunch of ioctls wind up eating way more stack
space than the programmer (rightfully) intended.  ethtool_ops not
only makes a driver smaller, but it also neatly eliminates the stack
usage problem.

I much prefer this scaled back approach, which doesn't break anything,
and DaveM is ok with it as well.  Please apply.


BitKeeper repo:

	bk pull http://gkernel.bkbits.net/ethtool-2.6

Patch is also available from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test3-bk5-ethtool1.patch.bz2

This will update the following files:

 drivers/net/tg3.c         |  664 +++++++++++++++++++--------------------------
 include/linux/ethtool.h   |   99 ++++++
 include/linux/netdevice.h |    9 
 net/core/Makefile         |    4 
 net/core/dev.c            |   16 -
 net/core/ethtool.c        |  672 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1076 insertions(+), 388 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/08/07 1.1119.10.3)
   [netdrvr] add SET_ETHTOOL_OPS back-compat hook

<jgarzik@redhat.com> (03/08/07 1.1119.10.2)
   [netdrvr tg3] convert to using ethtool_ops

<jgarzik@redhat.com> (03/08/07 1.1119.10.1)
   [netdrvr] add ethtool_ops to struct net_device, and associated infrastructure
   
   Contributed by Matthew Wilcox.

