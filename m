Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWBUUBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWBUUBq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWBUUBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:01:46 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1420
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932559AbWBUUBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:01:45 -0500
Date: Tue, 21 Feb 2006 11:58:59 -0800 (PST)
Message-Id: <20060221.115859.92015829.davem@davemloft.net>
To: mpm@selenic.com
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: softlockup interaction with slow consoles
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060221192340.GO4650@waste.org>
References: <Pine.LNX.4.58.0602210404330.3092@devserv.devel.redhat.com>
	<20060221.011650.120896368.davem@davemloft.net>
	<20060221192340.GO4650@waste.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Tue, 21 Feb 2006 13:23:40 -0600

> I don't like it. We should instead just have printk tickle the watchdog.

You can't, interrupts are disabled the entire time and thus
jiffies aren't advancing.  The "touch" just sets the local
cpu timestamp to whatever jiffies is.

That's the problem.

I agree that it would be nice to fix this, but the desire for
synchronous console output makes this very hard to solve.

Like I said, maybe some local chunking in release_console_sem()
but since interrupts will come in we can trigger more and more
lengthy console output and eventually overflow the printk log
buffer before the chunking loop can catch up and we'll thus
lose messages.
