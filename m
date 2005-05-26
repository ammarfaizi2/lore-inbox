Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVEZWYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVEZWYy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVEZWY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:24:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21001
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261835AbVEZWXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:23:06 -0400
Date: Fri, 27 May 2005 00:22:56 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1
Message-ID: <20050526222256.GS5691@g5.random>
References: <20050525134933.5c22234a.akpm@osdl.org> <17045.36727.602005.757948@alkaid.it.uu.se> <20050526130402.GN5691@g5.random> <17046.8270.55088.771900@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17046.8270.55088.771900@alkaid.it.uu.se>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 09:15:26PM +0200, Mikael Pettersson wrote:
> (But please make it conditional on CONFIG_SECCOMP.)

Why should it be conditional? Isn't it faster to read it from the cpu
itself instead of reading it from slow ram? That info is cold in the
cache when the global tlb flush is invoked, while it's always in hot in
the cpu. Perhaps the cpu is dogslow at reading cr4 or what?

Note that the whole mmu_cr4 thing seems pretty flawed if used at
runtime, that's only necessary to initialize new cpus (head.S). So
basically at runtime nobody should read or write to mmu_cr4_features
global variable.

> The code called from __switch_to() would have to set or clear cr4
> locally only. That's easy using write_cr4() and read_cr4().

Agreed.
