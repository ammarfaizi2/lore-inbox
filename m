Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbULMW0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbULMW0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbULMWY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:24:26 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:25008 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261241AbULMWVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:21:36 -0500
Date: Mon, 13 Dec 2004 23:21:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041213222138.GP16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <1102971389.1281.427.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102971389.1281.427.camel@cog.beaverton.ibm.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 12:56:29PM -0800, john stultz wrote:
> Interesting patch, I know some folks have been asking about HZ=10k
> recently, so this could help. 

Yes, they only need to pass HZ=10000 to the boot command line to make it
work with 2.4.

> The only bit that worries me a bit is the change from HZ->USER_HZ for
> internal calculations. In my mind, USER_HZ should only be used for
> converting internal system ticks to userspace-visible ticks. Changing
> drivers to think about things in user-ticks confuses things a bit since
> suddenly some kernel code is thinking in user-ticks and others in
> system-ticks. It just muddles things a bit.

I tried to make the smallest possible change to make the thing work,
even if that sometime meant to think in user hz. The user_to_kernel_hz
helper function converts back into kernel hz.
