Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbULMU63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbULMU63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbULMU61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:58:27 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:46491 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261175AbULMU4E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:56:04 -0500
Subject: Re: dynamic-hz
From: john stultz <johnstul@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041211142317.GF16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random>
Content-Type: text/plain
Message-Id: <1102971389.1281.427.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Dec 2004 12:56:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-11 at 06:23, Andrea Arcangeli wrote:
> This patch is quite intrusive since many HZ visible to userspace have to
> be converted to USER_HZ, and most important because HZ isn't available
> at compile time anymore and every variable in function of HZ must be
> either changed to be in function of USER_HZ or it must be initialized at
> runtime. The code has debugging code (optional at compile time) so that
> I can guarantee that there cannot be any regression.

Interesting patch, I know some folks have been asking about HZ=10k
recently, so this could help. 

The only bit that worries me a bit is the change from HZ->USER_HZ for
internal calculations. In my mind, USER_HZ should only be used for
converting internal system ticks to userspace-visible ticks. Changing
drivers to think about things in user-ticks confuses things a bit since
suddenly some kernel code is thinking in user-ticks and others in
system-ticks. It just muddles things a bit.

thanks
-john



