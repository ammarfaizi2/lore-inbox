Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbTC0TOD>; Thu, 27 Mar 2003 14:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261345AbTC0TOD>; Thu, 27 Mar 2003 14:14:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36102 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261340AbTC0TOA>; Thu, 27 Mar 2003 14:14:00 -0500
Date: Thu, 27 Mar 2003 11:22:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: dane@aiinet.com, <shmulik.hen@intel.com>,
       <bonding-devel@lists.sourceforge.net>,
       <bonding-announce@lists.sourceforge.net>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
       <mingo@redhat.com>, <kuznet@ms2.inr.ac.ru>
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
In-Reply-To: <20030327.111012.23672715.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0303271120230.31459-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Mar 2003, David S. Miller wrote:
> 
> Let's codify this "in_atomic() || irqs_disabled()" test into a macro
> that everyone can use to test sleepability, ok?

Well, I really don't want people to act dynamically differently depending 
on whether they can sleep or not. That makes static sanity-testing 
impossible. So I really think that the only really valid use of the above 
is on one single place: might_sleep().

Which right now doesn't do the "irqs_disabled()" test, but otherwise looks 
good. So the code should really just say

	if (gfp_mask & __GFP_WAIT)
		might_sleep();

and might_sleep() should be updated.

Anybody want to try that and see whether things break horribly?

		Linus

