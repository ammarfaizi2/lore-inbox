Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbVLOI3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbVLOI3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbVLOI3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:29:32 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14012
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161070AbVLOI3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:29:31 -0500
Date: Thu, 15 Dec 2005 00:21:20 -0800 (PST)
Message-Id: <20051215.002120.133621586.davem@davemloft.net>
To: sri@us.ibm.com
Cc: mpm@selenic.com, ak@suse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0512142318410.7197@w-sridhar.beaverton.ibm.com>
References: <20051215033937.GC11856@waste.org>
	<20051214.203023.129054759.davem@davemloft.net>
	<Pine.LNX.4.58.0512142318410.7197@w-sridhar.beaverton.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sridhar Samudrala <sri@us.ibm.com>
Date: Wed, 14 Dec 2005 23:37:37 -0800 (PST)

> Instead, you seem to be suggesting in_emergency to be set dynamically
> when we are about to run out of ATOMIC memory. Is this right?

Not when we run out, but rather when we reach some low water mark, the
"critical sockets" would still use GFP_ATOMIC memory but only
"critical sockets" would be allowed to do so.

But even this has faults, consider the IPSEC scenerio I mentioned, and
this applies to any kind of encapsulation actually, even simple
tunneling examples can be concocted which make the "critical socket"
idea fail.

The knee jerk reaction is "mark IPSEC's sockets critical, and mark the
tunneling allocations critical, and... and..."  well you have
GFP_ATOMIC then my friend.

In short, these "seperate page pool" and "critical socket" ideas do
not work and we need a different solution, I'm sorry folks spent so
much time on them, but they are heavily flawed.
