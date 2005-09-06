Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVIFBvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVIFBvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 21:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVIFBvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 21:51:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6860
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750782AbVIFBvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 21:51:45 -0400
Date: Mon, 05 Sep 2005 18:51:41 -0700 (PDT)
Message-Id: <20050905.185141.44096788.davem@davemloft.net>
To: viro@ZenIV.linux.org.uk
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig fix (GEN_RTC dependencies)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050906005645.GQ5155@ZenIV.linux.org.uk>
References: <20050906005645.GQ5155@ZenIV.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: viro@ZenIV.linux.org.uk
Date: Tue, 6 Sep 2005 01:56:45 +0100

> 	Yet another architecture not coverd by GEN_RTC - sparc64 never
> picked it until now and it doesn't have asm/rtc.h to go with it, so
> it wouldn't compile anyway (or have these ioctls in the user-visible
> headers, for that matter).
> 
> 	FWIW, I'm very tempted to introduce ARCH_HAS_GEN_RTC and have
> it set in arch/*/Kconfig for architectures that know what to do with this
> stuff - for something supposedly generic the list of architectures where
> it doesn't work is getting too long...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I'll add this patch to my sparc tree, thanks Al.

Admittedly, the whole RTC situation is quite a mess I have to
agree.

To make the problem worse, we have two sets of RTC ioctls
which userland makes use of on Sparc.  The older ones which
the SBUS RTC driver exported and supported, and the normal
ones the rest of the world uses.  Because the normal RTC driver
gets used as well, userland actually tries both ioctl sets.
Therefore, it probably would work to completely do away with
the SBUS RTC ioctl support, and only use the normal ones.

This would make using the generic RTC driver much easier, I
would think.

Anyways, I've added this to my sparc64 TODO list at:

	 http://vger.kernel.org/~davem/sparc64_todo.html

so that I can get to dealing with this at some point.
