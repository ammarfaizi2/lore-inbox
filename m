Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbULOJTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbULOJTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbULOJS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:18:28 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:15071 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262308AbULOJRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:17:55 -0500
Date: Wed, 15 Dec 2004 10:17:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: USB making time drift [was Re: dynamic-hz]
Message-ID: <20041215091741.GA16322@dualathlon.random>
References: <20041213002751.GP16322@dualathlon.random> <20041214220239.GA19221@elf.ucw.cz> <20041214231649.GR16322@dualathlon.random> <200412142159.23488.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412142159.23488.gene.heskett@verizon.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 09:59:23PM -0500, Gene Heskett wrote:
> Which way?  I was running quite fast here, several minutes an

In the future, if I disable the logic it goes in the past at the same
speed it was previously going in the future.

> hour, then I discovered the tickadj command, found its default
> was 10000, and started reducing it.  At 9926, I'm staying within
> a sec an hour now.  I have no idea when this started, I didn't

That seems quite an hack, note I did an hack too and it make the drift
much smaller (it gets manageable). But our modifications are wrong.

The point is that this didn't happen with HZ=100, so it's not that
tickadj is wrong, it's the tick adjustment code that doesn't work.

You may want to recompile your kernel with HZ=100 and verify it goes
away (I didn't verify myself, but I verified the max irq latency I get
is 4msec, and in turn I'm sure HZ=100 would fix it)
