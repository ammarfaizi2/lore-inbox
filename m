Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWEGARX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWEGARX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 20:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWEGARX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 20:17:23 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62861
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751148AbWEGARW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 20:17:22 -0400
Date: Sat, 06 May 2006 17:17:20 -0700 (PDT)
Message-Id: <20060506.171720.21872950.davem@davemloft.net>
To: mpm@selenic.com
Cc: tytso@mit.edu, mrmacman_g4@mac.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network
 drivers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060506203304.GF15445@waste.org>
References: <20060506164808.GY15445@waste.org>
	<20060506180551.GB22474@thunk.org>
	<20060506203304.GF15445@waste.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Sat, 6 May 2006 15:33:04 -0500

> On Sat, May 06, 2006 at 02:05:51PM -0400, Theodore Tso wrote:
> > For network traffic, again, it depends on your threat model.
> 
> Here's a threat model: I remotely break into your LAN and 0wn insecure
> Windows box X that's one switch jump away from the web server Y that
> processes your credit card transactions. I use standard techniques to
> kick the switch into broadcast mode so I can see all its traffic or
> maybe I break into the switch itself and temporarily isolate Y from
> the rest of the world so that only X can talk to it. I'm still in
> Russia, but I might as well be in the same room.

Doesn't matter.

You cannot measure any of the delays happening between network packet
being seen on the wire to interrupt handler actually executing.

There is so much variable jitter and it depends on so many minute
details at both the hardware and software level, that you can't guess
this stuff.  What's the load on the box?  How many clock cycles does
it take for an interrupt to propagate to the cpu, how many clock
cycles from interrupt reception until the cpu executes the interrupt
handler, how are the hw interrupt mitigation facilities programmed
and how do their timers work, what is the wire to PHY delay, what is
the PHY to MAC delay, how many cycles does it take for the FIFO to
DMA the packet into main memory, what is the delay from DMA'ing the
packet to main memory and the indication of the interrupt condition.
etc. etc. etc.

You can't know any of that.

Please put together a real reproducable attack that others can run too
and would validate justify SA_SAMPLE_RANDOM from networking drivers.
It's all swiss cheese theory until you do this.  And we should not be
making kernel changes merely due to swiss cheese theory.
