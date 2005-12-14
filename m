Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVLNR5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVLNR5W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVLNR5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:57:22 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:35804 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964789AbVLNR5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:57:20 -0500
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
From: Sridhar Samudrala <sri@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20051214092228.GC18862@brahms.suse.de>
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com>
	 <20051214092228.GC18862@brahms.suse.de>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 09:55:45 -0800
Message-Id: <1134582945.8698.17.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 10:22 +0100, Andi Kleen wrote:
> > I would appreciate any feedback or comments on this approach.
> 
> Maybe I'm missing something but wouldn't you need an own critical
> pool (or at least reservation) for each socket to be safe against deadlocks?
> 
> Otherwise if a critical sockets needs e.g. 2 pages to finish something
> and 2 critical sockets are active they can each steal the last pages
> from each other and deadlock.

Here we are assuming that the pre-allocated critical page pool is big enough
to satisfy the requirements of all the critical sockets.

In the current critical page pool implementation, there is also a limitation 
that only order-0 allocations(single page) are supported. I think in the
networking send/receive patch, the only place where multi-page allocs are
requested is in the drivers if the MTU > PAGESIZE. But i guess the drivers
are getting updated to avoid > order-0 allocations.

Also during the emergency, we free the memory allocated for non-critical 
packets as quickly as possible so that it can be re-used for critical
allocations.

Thanks
Sridhar

