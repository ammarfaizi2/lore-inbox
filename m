Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWHHWAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWHHWAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWHHWAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:00:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44717
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030278AbWHHWAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:00:02 -0400
Date: Tue, 08 Aug 2006 15:00:06 -0700 (PDT)
Message-Id: <20060808.150006.48399434.davem@davemloft.net>
To: rostedt@goodmis.org
Cc: tytso@mit.edu, mchan@broadcom.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0608080819080.7917@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608070124340.15870@gandalf.stny.rr.com>
	<20060806.231846.71090637.davem@davemloft.net>
	<Pine.LNX.4.58.0608080819080.7917@gandalf.stny.rr.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 8 Aug 2006 08:24:10 -0400 (EDT)

> Of the 4 timers, only one is a timeout. The other three expire every time,
> forcing the timer wheel into effect.  Even though it's one timer
> implementing 4, it's expensive to use it as a watchdog.

It's not a watchdog, the timer continually fires.

It is the on-chip ASF firmware that "times out" if it does not
see  the heartbeat message from the driver within 5 seconds.

The driver timer in question runs every 2 seconds to write this
heartbeat message to the chip.
