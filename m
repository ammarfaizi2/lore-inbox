Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263343AbTC0R4M>; Thu, 27 Mar 2003 12:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263355AbTC0R4L>; Thu, 27 Mar 2003 12:56:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39694 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263354AbTC0R4I>; Thu, 27 Mar 2003 12:56:08 -0500
Date: Thu, 27 Mar 2003 10:04:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: shmulik.hen@intel.com, <dane@aiinet.com>,
       <bonding-devel@lists.sourceforge.net>,
       <bonding-announce@lists.sourceforge.net>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
       <mingo@redhat.com>, <kuznet@ms2.inr.ac.ru>
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
In-Reply-To: <20030327.095537.26269606.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0303271002420.29205-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Mar 2003, David S. Miller wrote:
> 
>    I do agree that we should obviously not run bottom halves with
>    interrupts disabled
>    
> Ok, so can we add a:
> 
> 	if (irqs_disabled())
> 		BUG();
> 
> check to do_softirq()?

I'd suggest making it a counting warning (with a static counter per
local-bh-enable macro expansion) and adding it to local_bh_enable() -
otherwise it will only BUG()  when the (potentially rare) condition
happens - instead of always giving a nice backtrace of exact problem 
spots.

		Linus

