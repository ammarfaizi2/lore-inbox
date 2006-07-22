Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWGVP3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWGVP3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 11:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWGVP3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 11:29:31 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:396 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750797AbWGVP3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 11:29:30 -0400
Date: Sat, 22 Jul 2006 11:29:34 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: "Paul E. McKenney" <pmckenne@us.ibm.com>
Cc: Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org
Subject: NMI reentrant RCU list for -rt kernels
Message-ID: <20060722152933.GA17148@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 11:12:30 up 77 days, 18:21,  1 user,  load average: 1.64, 1.26, 1.16
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Following your presentation on RCU lists for -rt kernel, discussing with Bill
Huey led me to the following idea that could solve the problem of NMI reentrancy
of RCU read side in the -rt kernels.

If we consider that the RCU list modification that makes the read side
lock preemptible is only needed for very long code paths, we could leave the
original RCU implementation along with the preemptible one, so that very short
and frequent code paths could benefit of using the very cheap preempt count
protection without having a too big impact on the scheduler latency.

For instance, my LTTng tracer disables the preemption for about 95 ns, which I
doubt would be a problem for real-time behavior. I could easily fix maximum
a maximum list size so it can be run in a constant time.

So, basically, the idea is to have two RCU API that could take names like :
atomic_rcu_* and rcu_*

Does this idea make sense ?

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
