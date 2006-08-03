Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWHCXnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWHCXnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWHCXnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:43:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47842
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751380AbWHCXnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:43:09 -0400
Date: Thu, 03 Aug 2006 16:43:11 -0700 (PDT)
Message-Id: <20060803.164311.91310742.davem@davemloft.net>
To: mchan@broadcom.com
Cc: tytso@mit.edu, herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: David Miller <davem@davemloft.net>
In-Reply-To: <1154647699.3117.26.camel@rh4>
References: <20060803201741.GA7894@thunk.org>
	<20060803.144845.66061203.davem@davemloft.net>
	<1154647699.3117.26.camel@rh4>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael Chan" <mchan@broadcom.com>
Date: Thu, 03 Aug 2006 16:28:19 -0700

> > eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[0] TSOcap[0]
> 
> We'll see if we can do away with the timer-based heartbeat.  That's
> probably the best solution.

The tg3 driver is not the only device in the world that requires a
timer based "ping" to work.  The watchdog drivers and the softlockup
detector are other instances which require a timer to not be delayed
an unreasonable amount of time.

Therefore TG3 is not unique in this regard, and I thus don't think
it's worthwhile to change tg3 just to accomodate this broken behavior
of the RT patches.
