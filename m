Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318469AbSGSIZW>; Fri, 19 Jul 2002 04:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318471AbSGSIZW>; Fri, 19 Jul 2002 04:25:22 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:23839 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S318469AbSGSIZV>; Fri, 19 Jul 2002 04:25:21 -0400
Date: Fri, 19 Jul 2002 09:30:32 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Robert Love <rml@tech9.net>
cc: <root@chaos.analogic.com>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <1027019414.1085.143.camel@sinai>
Message-ID: <Pine.LNX.4.30.0207190843200.30902-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jul 2002, Robert Love wrote:
> Btw, without this it is possible to OOM any machine.  OOM is a
> by-product of allowing overcommit and poor accounting (and perhaps
> poor software/users), not an incorrectly configured machine.

Very well said, now I try to explain again what's missing from the
patch: livelock is a by-product of allowing strict VM overcommit and
poor accounting (and perhaps poor software/users), not an incorrectly
configured machine.

So where is the solution for "poor accounting (and perhaps poor
software/users), not an incorrectly configured machine" users? These
are part of life and please don't claim all your work was perfect at
first shoot and automatically adapted in all changing environments
whitout ever touching it again on a general purpose system. Even if
it would be true, not everybody supergenius.

So which one is better? OOM killer that considers root owned processes
to make his decision or strict VM overcommit that doesn't distinguish
root and non-root users and potentially will livelock [if you don't
have some custom solution, like "trigger OOM handler through sysrq"
patch posted here a year ago].

For embedded systems the later, for general purpose systems the first
is better in average however this is not linux-embedded and later on
people using Linux for general purpose could get the impression strict
VM overcommit is useful for them and potentially would end up in a
worse situation than without it (see my example sent, default kernel
OOM killed the bad process, with your patch reset the box).

*However* distinguishing root and non-root users also in strict VM
overcommit would make a significant difference for general purpose
systems, this was always my point.

Can you see the non-orthogonality now?

	Szaka

