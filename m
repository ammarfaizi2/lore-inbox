Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbSKUUwe>; Thu, 21 Nov 2002 15:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbSKUUwe>; Thu, 21 Nov 2002 15:52:34 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:10259 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264748AbSKUUwc>; Thu, 21 Nov 2002 15:52:32 -0500
Date: Thu, 21 Nov 2002 15:58:29 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Failover in NFS
In-Reply-To: <200211181611.06241.pollard@admin.navo.hpc.mil>
Message-ID: <Pine.LNX.3.96.1021121154055.10456C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Jesse Pollard wrote:

> It would actually be better to use two floating IP numbers. That way during
> normal operation, both servers would be functioning simultaneously
> (based on the shared storage on two nodes).
> 
> Then during failover, the floating IP of the failed node is activated on the
> remaining node (total of 3 IP numbers now, one real, two floating). The NFS
> recovery cycle should then cause the clients to remount the filesystem from
> the backup server.
> 
> When the failed node is recovered, the active server should then disable the
> floating IP associated with the recovered server, causing only the mounts
> using that IP number to fall back to the proper node, balancing the load
> again.

That works for stateless connections, but for stateful connections like
POP, NNTP, SMTP, etc, you will lose all the connections currently
actively.

A proper solution is the have the recovered server accept ESTABLISHED and
--syn packets, then DNAT the rest to the fallback server, while the
fallback server takes and new (--syn) packets and does DNAT to the
recovered server.

I'm not sure iptables can do this right, you probably need a program to
get the DNAT part just correct. There may be some one of the experimental
patches which adds that capability, since people do load balancing with
Linux. It might take source routing, and certainly will be harder than
just turning off the alias ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

