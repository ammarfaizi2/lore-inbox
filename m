Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbULMBG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbULMBG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 20:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbULMBG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 20:06:29 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:32988
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262184AbULMBGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 20:06:24 -0500
Date: Sun, 12 Dec 2004 16:55:46 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Robin Holt <holt@sgi.com>
Cc: holt@sgi.com, akpm@osdl.org, yoshfuji@linux-ipv6.org,
       hirofumi@parknet.co.jp, torvalds@osdl.org, dipankar@ibm.com,
       laforge@gnumonks.org, bunk@stusta.de, herbert@apana.org.au,
       paulmck@ibm.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       gnb@sgi.com
Subject: Re: [RFC] Limit the size of the IPV4 route hash.
Message-Id: <20041212165546.1808536e.davem@davemloft.net>
In-Reply-To: <20041210234037.GB25582@lnx-holt.americas.sgi.com>
References: <20041210190025.GA21116@lnx-holt.americas.sgi.com>
	<20041210114829.034e02eb.davem@davemloft.net>
	<20041210210006.GB23222@lnx-holt.americas.sgi.com>
	<20041210130947.1d945422.akpm@osdl.org>
	<20041210232722.GC24468@lnx-holt.americas.sgi.com>
	<20041210153848.5acacd0a.akpm@osdl.org>
	<20041210233700.GA25582@lnx-holt.americas.sgi.com>
	<20041210234037.GB25582@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004 17:40:37 -0600
Robin Holt <holt@sgi.com> wrote:

> Sorry, I was asleep at the wheel.  I failed to even grok your second
> paragraph.  I will fall back to agreeing with the printk to let the admin
> know that something is amiss.
> 
> Should we possibly modify the output of /proc/net/rt_cache (or whatever
> its name is) to include the hash bucket so people can watch to see how
> many bucket collisions their system has?

I think there are rt stats for this already added by Robert Olsson.

One thing not mentioned, besides the physically contiguous issue,
is that fact that the locking would need to be changed quite a bit
in order to allow runtime reallocation of the hash table.  The current
code is certainly not ready for it.  It might just work to run the
hash freeing via RCU, but I'm not quite sure.

