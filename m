Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWHLQvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWHLQvh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 12:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWHLQvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 12:51:36 -0400
Received: from helium.samage.net ([83.149.67.129]:2208 "EHLO helium.samage.net")
	by vger.kernel.org with ESMTP id S932526AbWHLQvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 12:51:35 -0400
Message-ID: <33471.81.207.0.53.1155401489.squirrel@81.207.0.53>
In-Reply-To: <20060812141415.30842.78695.sendpatchset@lappy>
References: <20060812141415.30842.78695.sendpatchset@lappy>
Date: Sat, 12 Aug 2006 18:51:29 +0200 (CEST)
Subject: Re: [RFC][PATCH 0/4] VM deadlock prevention -v4
From: "Indan Zupancic" <indan@nul.nu>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Daniel Phillips" <phillips@google.com>,
       "Rik van Riel" <riel@redhat.com>, "David Miller" <davem@davemloft.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, August 12, 2006 16:14, Peter Zijlstra said:
> Hi,
>
> here the latest effort, it includes a whole new trivial allocator with a
> horrid name and an almost full rewrite of the deadlock prevention core.
> This version does not do anything per device and hence does not depend
> on the new netdev_alloc_skb() API.
>
> The reason to add a second allocator to the receive side is twofold:
> 1) it allows easy detection of the memory pressure / OOM situation;
> 2) it allows the receive path to be unbounded and go at full speed when
>    resources permit.
>
> The choice of using the global memalloc reserve as a mempool makes that
> the new allocator has to release pages as soon as possible; if we were
> to hoard pages in the allocator the memalloc reserve would not get
> replenished readily.

Version 2 had about 250 new lines of code, while v3 has close to 600, when
including the SROG code. And that while things should have become simpler.
So why use SROG instead of the old alloc_pages() based code? And why couldn't
you use a slightly modified SLOB instead of writing a new allocator?
It looks like overkill to me.

Greetings,

Indan


