Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318361AbSIPBJQ>; Sun, 15 Sep 2002 21:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318366AbSIPBJQ>; Sun, 15 Sep 2002 21:09:16 -0400
Received: from almesberger.net ([63.105.73.239]:11281 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S318361AbSIPBJP>; Sun, 15 Sep 2002 21:09:15 -0400
Date: Sun, 15 Sep 2002 02:46:16 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question regarding Qdisc.stats
Message-ID: <20020915024616.B3352@almesberger.net>
References: <20020820171431.K1992@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020820171431.K1992@in.ibm.com>; from kiran@in.ibm.com on Tue, Aug 20, 2002 at 05:14:31PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> Where do the Qdisc.stats show up? in /proc?

No, only on (rt)netlink.

> (Assuming CONFIG_NET_SCHED is not defined)

In this case, the statistics are not usefully accessible. The
tx_dropped you get with ifconfig (or such) comes from the device
level, not the traffic control subsystem.

> qdisc_copy_stats with 'TCA_STATS' attribute, but where is it being 
> reported? or what is it being used for ?? Specifically, does 
> Qdisc.stats.drops get reported anywere?

Yep, e.g. in iproute2/tc/tc_qdisc.c:print_tcstats

> While I am at it, I see that qdisc->enqueue routines kfree the skb with the
> dev->queue_lock held (when the enqueue routine drops the packet -- 
> NET_XMIT_DROP)  from dev_queue_xmit. kfree_skb can be done outside the 
> lock.... right? I can make a patch for this if I am not missing something.....

That certainly sounds good to me.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
