Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWAEUwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWAEUwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWAEUwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:52:43 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:2314 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S932189AbWAEUwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:52:42 -0500
From: James Cloos <cloos@jhcloos.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt1
In-Reply-To: <20060103094720.GA16497@elte.hu> (Ingo Molnar's message of "Tue,
	3 Jan 2006 10:47:20 +0100")
References: <20060103094720.GA16497@elte.hu>
Copyright: Copyright 2005 James Cloos
X-Hashcash: 1:23:060105:mingo@elte.hu::VjgkP9keVLsclEzs:0000O5hE
X-Hashcash: 1:23:060105:linux-kernel@vger.kernel.org::QNZ2L+ZzisLaSJBf:0000000000000000000000000000000003qiJ
Date: Thu, 05 Jan 2006 15:52:29 -0500
Message-ID: <m3r77mv1ma.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this compiling 15-rt1:

,----
|   CC      net/ipv6/mcast.o
| net/ipv6/mcast.c: In function `ipv6_sock_mc_join':
| net/ipv6/mcast.c:227: error: `RW_LOCK_UNLOCKED' undeclared (first use in this function)
| net/ipv6/mcast.c:227: error: (Each undeclared identifier is reported only once
| net/ipv6/mcast.c:227: error: for each function it appears in.)
| make[2]: *** [net/ipv6/mcast.o] Error 1
`----

I take it something on the order of this is needed?:

-	mc_lst->sflock = RW_LOCK_UNLOCKED;
+	mc_lst->sflock = RW_LOCK_UNLOCKED(foo.bar);

for some foo.bar, yes?

Or is it?:

-	mc_lst->sflock = RW_LOCK_UNLOCKED;
+	rwlock_init(mc_lst->sflock);

I'm trying the latter now, but won't be able to reboot for
a runtime test for a while....

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
