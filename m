Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVHOOUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVHOOUB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 10:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVHOOUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 10:20:01 -0400
Received: from fsmlabs.com ([168.103.115.128]:26811 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S964776AbVHOOUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 10:20:00 -0400
Date: Mon, 15 Aug 2005 08:25:51 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Harald Welte <laforge@netfilter.org>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.13-rc5-mm1: BUG: rwlock recursion on CPU#0
In-Reply-To: <20050815093714.GB4439@rama.de.gnumonks.org>
Message-ID: <Pine.LNX.4.61.0508150824150.6740@montezuma.fsmlabs.com>
References: <200508141448.36562.rjw@sisk.pl> <Pine.LNX.4.61.0508141940200.6740@montezuma.fsmlabs.com>
 <20050815093714.GB4439@rama.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2005, Harald Welte wrote:

> On Sun, Aug 14, 2005 at 08:15:53PM -0600, Zwane Mwaikambo wrote:
> 
> > Is the following patch correct? ip_conntrack_event_cache should never be 
> > called with ip_conntrack_lock held and ct_add_counters does not need to be 
> > called with ip_conntrack_lock held.
> 
> No, it's not correct.  ct_add_countes has to be called from within
> write_lock_bh() on ip_conntrack_lock.
> 
> So if you keep the ct_add_counters() call where it is and only apply the
> rest of your patch (i.e. deferring of ip_conntrack_event_cache() call),
> then I think your patch would work.
> 
> However, the whole eventcache needs to be audited, it's called from a
> number of places.
> 
> As Patrick wrote he's working on a solution, I'm not going to intervene
> or replicate his work.  As a interim solution I'd suggest disabling
> CONFIG_IP_NF_CT_ACCT [which can't be vital anyway, since it was only
> added in net-2.6.14 (and thus -mm)].

Thanks for the explanation Harald, i based the ct_add_counters assumption 
on other callers of it.

Thanks,
	Zwane

