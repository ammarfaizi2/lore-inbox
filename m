Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWIIJhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWIIJhc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 05:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWIIJhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 05:37:32 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16547
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750798AbWIIJha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 05:37:30 -0400
Date: Sat, 09 Sep 2006 02:38:03 -0700 (PDT)
Message-Id: <20060909.023803.104047454.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: torvalds@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org, segher@kernel.crashing.org
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: David Miller <davem@davemloft.net>
In-Reply-To: <1157786600.31071.166.camel@localhost.localdomain>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
	<1157786600.31071.166.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 09 Sep 2006 17:23:20 +1000

> I quite like mem_to_io_* (barrier/rb/wb) and io_to_mem_* in fact :) That
> is probably more talkative to device driver writers and would allow more
> fine grained barriers.

I firmly believe that the average driver person is not going
to be able to get these things right, even if you document it
in big bold letters in some Documentation/*.txt file.

This is like the Alpha OSF outb() interface for kernel drivers
that had something like 8 arguments.

And even if you define these things, and people start using it,
only PowerPC and a few other systems (I guess IA64) will ever
notice when this stuff is done wrong.  That's really not a good
plan from a testing coverage point of view.
