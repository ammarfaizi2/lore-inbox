Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271283AbTG2G4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 02:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271284AbTG2G4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 02:56:03 -0400
Received: from dp.samba.org ([66.70.73.150]:20117 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271283AbTG2G4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 02:56:01 -0400
Date: Tue, 29 Jul 2003 16:53:07 +1000
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] e1000 TSO parameter
Message-ID: <20030729065307.GC13227@krispykreme>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229169@orsmsx402.jf.intel.com> <20030714214510.17e02a9f.davem@redhat.com> <16147.37268.946613.965075@napali.hpl.hp.com> <20030714223822.23b78f9b.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714223822.23b78f9b.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> > So we get almost 15% of throughput drop.  This was with plain "netkit
> > fptd".  AFAIK, it does a simple read/write loop (not sendfile()).

We've been seeing rather variable results for TSO as well. With TSO off
netperf TCP_STREAM will hit line speed and stay there. With TSO on
some runs will hit line speed and others will be about 100Mbit/sec
slower.

> When we use TSO for non-sendfile() applications it really
> stresses memory allocations.  We do these 64K+ kmalloc()'s
> for each packet we construct.

Yep we definitely noticed much more higher allocations when watching
/proc/slab. Playing around with slab tuning didnt seem to help.

Anton
