Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUIUBWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUIUBWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 21:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUIUBWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 21:22:20 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:23754 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S267438AbUIUBWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 21:22:09 -0400
Date: Mon, 20 Sep 2004 18:22:08 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: help with next generation bkbits please
Message-ID: <20040921012208.GA16008@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we're trying to upgrade bkbits.net for your pushing&pulling pleasure
and we're having some problems.

We wanted to throw lots of memory at the problem so we went with an
ASUS SK8V motherboard, opteron 148, 4 x 1GB registered / ECC dimms.
We thought we would be careful so we bought dimms that ASUS claims works.

We can't get the system to stabilize and we're looking for either 
    a) information on how to do that or
    b) a suggestion for a machine which will support 4GB or more

What we are currently seeing looks like a cache writeback problem.
I have a simple memory scrubber, see below, which just cycles through a
series of patterns, verifying the previous one and writing a new one,
switch pattern, repeat until pattern list is exhausted, then loop.
We cycle through the offset into the array, 0xdeadbeef, 0x50505050,
0x0a0a0a0a, 0x55555555, 0xaaaaaaaa, 0, 0xffffffff.

What we see is that for 16x4 bytes in a row we will get errors where
what we get is the previous value.  In other words, we just went through
a loop that verified that all the data is 0xdeadbeef and then set it
to 0x50505050, and then in the next loop 16 values will be 0xdeadbeef.
In other words, it looks like the cache writeback didn't work, it's as
if the dirty bits were cleared for some reason.

Does anyone have any idea what might be causing this and what we need
to do to fix it?  We'd really like to get you guys a nicer machine.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
