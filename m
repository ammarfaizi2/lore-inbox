Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWATA4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWATA4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWATA4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:56:45 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5346
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030285AbWATA4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:56:45 -0500
Date: Thu, 19 Jan 2006 16:56:35 -0800 (PST)
Message-Id: <20060119.165635.104653932.davem@davemloft.net>
To: laforge@netfilter.org
Cc: netfilter-devel@lists.netfilter.org, mikpe@user.it.uu.se,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x_tables: fix alignment on [at least] ppc32
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060120004512.GT4603@sunbeam.de.gnumonks.org>
References: <17358.19458.555996.684819@alkaid.it.uu.se>
	<20060118150158.GL4603@sunbeam.de.gnumonks.org>
	<20060120004512.GT4603@sunbeam.de.gnumonks.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Welte <laforge@netfilter.org>
Date: Fri, 20 Jan 2006 01:45:12 +0100

> [NETFILTER] x_tables: Fix XT_ALIGN() macro on [at least] ppc32
> 
> To keep backwards compatibility with old iptables userspace programs,
> the new XT_ALIGN macro always has to return the same value as IPT_ALIGN,
> IP6T_ALIGN or ARPT_ALIGN in previous kernels.
> 
> However, in those kernels the macro was defined in dependency to the
> respective layer3 specifi data structures, which we can no longer do with
> x_tables.
> 
> The fix is an ugly kludge, but it has been tested to solve the problem. Yet
> another reason to move away from the current {ip,ip6,arp,eb}tables like
> data structures.
> 
> Signed-off-by: Harald Welte <laforge@netfilter.org>

Harald, I'm going to modify this to just use u_int64_t as that
should be totally sufficient.

It is the largest type, and will produce the desired results without
the silly structure.

Some malloc() implementations use "long double" to figure out the
largest type size and alignment requirements any C type might have
on the machine.  But there is no reason to use that here.
