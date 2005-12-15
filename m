Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbVLOIfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbVLOIfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbVLOIfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:35:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53429 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161071AbVLOIft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:35:49 -0500
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
From: Arjan van de Ven <arjan@infradead.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: sri@us.ibm.com, mpm@selenic.com, ak@suse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20051215.002120.133621586.davem@davemloft.net>
References: <20051215033937.GC11856@waste.org>
	 <20051214.203023.129054759.davem@davemloft.net>
	 <Pine.LNX.4.58.0512142318410.7197@w-sridhar.beaverton.ibm.com>
	 <20051215.002120.133621586.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 09:35:20 +0100
Message-Id: <1134635721.16486.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 00:21 -0800, David S. Miller wrote:
> From: Sridhar Samudrala <sri@us.ibm.com>
> Date: Wed, 14 Dec 2005 23:37:37 -0800 (PST)
> 
> > Instead, you seem to be suggesting in_emergency to be set dynamically
> > when we are about to run out of ATOMIC memory. Is this right?
> 
> Not when we run out, but rather when we reach some low water mark, the
> "critical sockets" would still use GFP_ATOMIC memory but only
> "critical sockets" would be allowed to do so.
> 
> But even this has faults, consider the IPSEC scenerio I mentioned, and
> this applies to any kind of encapsulation actually, even simple
> tunneling examples can be concocted which make the "critical socket"
> idea fail.
> 
> The knee jerk reaction is "mark IPSEC's sockets critical, and mark the
> tunneling allocations critical, and... and..."  well you have
> GFP_ATOMIC then my friend.
> 
> In short, these "seperate page pool" and "critical socket" ideas do
> not work and we need a different solution, I'm sorry folks spent so
> much time on them, but they are heavily flawed.

maybe it should be approached from the other side; having a way to mark
connections as low priority (say incoming http connections to your
webserver) or as non-critical/expendable would give the "normal"
GFP_ATOMIC ones a better chance in case of overload/DDOS etc. It's not
going to solve the VM deadlock issue wrt iscsi/nfs; however it might be
useful in the "survive slashdot" sense...

