Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWATJ3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWATJ3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 04:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWATJ3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 04:29:19 -0500
Received: from aun.it.uu.se ([130.238.12.36]:38570 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750710AbWATJ3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 04:29:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17360.44337.425946.347577@alkaid.it.uu.se>
Date: Fri, 20 Jan 2006 10:28:17 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "David S. Miller" <davem@davemloft.net>
Cc: laforge@netfilter.org, netfilter-devel@lists.netfilter.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x_tables: fix alignment on [at least] ppc32
In-Reply-To: <20060119.165635.104653932.davem@davemloft.net>
References: <17358.19458.555996.684819@alkaid.it.uu.se>
	<20060118150158.GL4603@sunbeam.de.gnumonks.org>
	<20060120004512.GT4603@sunbeam.de.gnumonks.org>
	<20060119.165635.104653932.davem@davemloft.net>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
 > From: Harald Welte <laforge@netfilter.org>
 > Date: Fri, 20 Jan 2006 01:45:12 +0100
 > 
 > > [NETFILTER] x_tables: Fix XT_ALIGN() macro on [at least] ppc32
 > > 
 > > To keep backwards compatibility with old iptables userspace programs,
 > > the new XT_ALIGN macro always has to return the same value as IPT_ALIGN,
 > > IP6T_ALIGN or ARPT_ALIGN in previous kernels.
 > > 
 > > However, in those kernels the macro was defined in dependency to the
 > > respective layer3 specifi data structures, which we can no longer do with
 > > x_tables.
 > > 
 > > The fix is an ugly kludge, but it has been tested to solve the problem. Yet
 > > another reason to move away from the current {ip,ip6,arp,eb}tables like
 > > data structures.
 > > 
 > > Signed-off-by: Harald Welte <laforge@netfilter.org>
 > 
 > Harald, I'm going to modify this to just use u_int64_t as that
 > should be totally sufficient.

ACK. Both Harald's patch and DaveM's simplification of it
(simply s/void */u_int64_t/g in XT_ALIGN()) fix the iptables
problems on my ppc32 box.

/Mikael
