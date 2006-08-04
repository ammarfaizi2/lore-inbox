Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWHDA0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWHDA0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWHDA0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:26:08 -0400
Received: from mga07.intel.com ([143.182.124.22]:14750 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932383AbWHDA0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:26:07 -0400
X-IronPort-AV: i="4.07,209,1151910000"; 
   d="scan'208"; a="97196140:sNHT8499537816"
Message-ID: <44D293F9.7040204@linux.intel.com>
Date: Thu, 03 Aug 2006 17:25:29 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, David Miller <davem@davemloft.net>,
       mchan@broadcom.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
References: <20060803201741.GA7894@thunk.org> <20060803.144845.66061203.davem@davemloft.net> <1154647699.3117.26.camel@rh4> <20060803.164311.91310742.davem@davemloft.net> <20060804000707.GA15342@thunk.org>
In-Reply-To: <20060804000707.GA15342@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> Removing the timer-based "ping" might be a good thing to do from the
> point of view of reducing power utilization of laptops (but hey, I
> don't have a tg3 in my laptop, so I won't worry about it a whole lot :-), 
> but I agree that in general the RT patches need to be able to
> call functions such as tg3_timer() reliably even when under a high
> real-time process workload, without needing to use the blunt hammer of
> "chrt -f 95 `pidof softirq-timer`".  (Since not all timer callbacks
> need to be run at rt prio 95.)
> 

I suppose the timer subsystem needs a "I'd like to have this timer called at time X, but it's ok to call it
later until time X+Y" option; that's useful for RT like stuff but also for power savings...
(eg you can batch timer firings that way a lot better)
