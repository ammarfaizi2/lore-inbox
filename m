Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946519AbWJTVJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946519AbWJTVJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946523AbWJTVJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:09:22 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11969
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1423232AbWJTVI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:08:58 -0400
Date: Fri, 20 Oct 2006 14:08:59 -0700 (PDT)
Message-Id: <20061020.140859.95896187.davem@davemloft.net>
To: ak@suse.de
Cc: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
From: David Miller <davem@davemloft.net>
In-Reply-To: <200610202301.29859.ak@suse.de>
References: <20061020.134209.85688168.davem@davemloft.net>
	<20061020134826.75dd1cba@freekitty>
	<200610202301.29859.ak@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Fri, 20 Oct 2006 23:01:29 +0200

> netpoll always played a little fast'n'lose with various locking rules.

The current code is fine, it never reenters ->poll, because it
maintains a "->poll_owner" which it checks in netpoll_send_skb()
before trying to call back into ->poll.

Every call to ->poll first sets ->poll_owner to the current cpu id.
netpoll_send_skb() aborts and does a drop if ->poll_owner is set to
the current smp_processor_id().

I sometimes feel like I'm the only person actually reading the sources
and past threads on this topic before replying.
