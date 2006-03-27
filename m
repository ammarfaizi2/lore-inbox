Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWC0T5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWC0T5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWC0T5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:57:47 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:27984 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750812AbWC0T5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:57:46 -0500
X-IronPort-AV: i="4.03,135,1141632000"; 
   d="scan'208"; a="317694739:sNHT31322252"
To: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: InfiniBand 2.6.17 merge plans
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 27 Mar 2006 11:56:13 -0800
Message-ID: <ada7j6f8xwi.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Mar 2006 19:57:42.0527 (UTC) FILETIME=[B56D68F0:01C651D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As we enter the second week of the 2.6.17 merge window, I thought it
might be helpful to give an update on what I'm thinking about the
remaining pending pieces.  This is really to stimulate discussion --
if there's something that you think really should (or shouldn't) be
merged, let me know.

Of course bug fixes are always welcome and can be merged pretty much
any time -- that's the whole point of the stabilization period after
the merge window.

 * PathScale ipath driver.  In my git tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git ipath

   There is still ia64 build breakage and a lot of sparse endian
   annotations to clean up before it's mergeable.  Also, there are two
   issues I still see:

   - Working around the IB midlayer SMA (subnet management agent) /
     implementation with a character device when ib_mad isn't loaded.
     Maybe I'm off-base here objecting to this.  Hal and Sean, as the
     ib_mad guys, I'd be especially interested in your opinion of this.

   - The driver depends on 64BIT && PCI_MSI, and is basically
     x86_64-only for practical purposes.  I think this is OK as far as
     a merge goes, but it would be nice to be able to use a PCIe
     device on any system with PCIe slots...

 * RDMA CM.  In my git tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git rdma_cm

   I think this is OK to merge, but I don't see much pull to get it in
   right now.  There are three consumers on the horizon:

   - userspace RDMA CM, which exports the abstraction to userspace.
     The feeling is that this interface needs more time to mature.

   - NFS/RDMA.  Not ready to merge right now.

   - iSER.  Maybe ready to merge -- I haven't heard anything recently.

   My feeling is that without someone making a case for why this
   should go in now, I'm going to hold off.

 * IPoIB tunables.  This is probably OK but I haven't seen any patches
   yet, so we're running out time.

 * SRP FMRs.  I have a patch that I'm pretty happy with now, so I
   think this will go in.  This will need a lot of testing, or we may
   have to turn it off by default for 2.6.17 final

So if you care about any of this, let me know what you think.  And if
there's something not on this list and not in

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-2.6.17

please make sure I know about it, or it won't get merged.

Thanks,
  Roland
