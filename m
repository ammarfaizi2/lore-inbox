Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268086AbUHWVw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUHWVw2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUHWVhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:37:51 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:24278 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267567AbUHWVYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:24:18 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: kernbench on 512p
Date: Mon, 23 Aug 2004 14:23:11 -0700
User-Agent: KMail/1.6.2
Cc: paulmck@us.ibm.com, "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408201324.32464.jbarnes@engr.sgi.com> <41265CCE.3070808@colorfullife.com>
In-Reply-To: <41265CCE.3070808@colorfullife.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408231423.11492.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 1:19 pm, Manfred Spraul wrote:
> Jesse Barnes wrote:
> >Looks like a bit more context has changed.  Manfred, care to respin
> > against -mm3 so I can test?
>
> The patches are attached. Just boot-tested on a single-cpu system.
>
> Three  changes:
> - I've placed the per-group structure into rcu_state. That's simpler but
> wrong: the state should be allocated from node-local memory, not a big
> global array.
> - I found a bug/race in the cpu_offline path: When the last cpu of a
> group goes offline then the group must be forced into quiescent state.
> The "&& (!forced)" was missing.
> - I've removed the spin_unlock_wait(). It was intended to synchronize
> cpu_online_mask changes with the calculation of ->outstanding. Paul
> convinced me that this is not necessary.

I haven't been able to boot successfully with this patch applied.  Things seem 
to get real slow around the time init starts, and the system becomes 
unusable.  I applied them on top of stock 2.6.8.1-mm4, which boots fine 
without them (testing that again to make sure, but I booted it a few times 
this morning w/o incident).

Jesse
