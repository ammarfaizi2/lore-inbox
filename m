Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135199AbRDLPLH>; Thu, 12 Apr 2001 11:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135200AbRDLPK6>; Thu, 12 Apr 2001 11:10:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21765 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135199AbRDLPKo>; Thu, 12 Apr 2001 11:10:44 -0400
Subject: Re: scheduler went mad?
To: Valdis.Kletnieks@vt.edu
Date: Thu, 12 Apr 2001 16:12:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104121457.f3CEv8o09656@foo-bar-baz.cc.vt.edu> from "Valdis.Kletnieks@vt.edu" at Apr 12, 2001 10:57:08 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nimI-0000oY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've seen the same scenario about 2-3 times a week.  kswapd and one or
> more processes all CPU bound, totalling to 100%.  I've had 'esdplay' hung
> on several occasions, and 2-3 times it's been xscreensaver (3.29) hung.
> The 'hung' processes are consistently immune to kill -9, even as root, which
> indicates to me that they're hung inside a kernel call or something.

Do you have > 800Mb of RAM ?

> In page_alloc.c, __alloc_pages() has a 'goto try_again;' which will
> cause it to loop around and try to get more memory.  I'm wondering if

Even outside of that certain drivers also loop on alloc failures as does 
TCP.

> would explain the high context-switch rate.  I'm not clear on how kswapd
> can end up getting stuck and failing to free up something - unless it ends
> up calling __alloc_pages itself indirectly and the PF_MEMALLOC bit isn't
> enough to get it the memory it needs, causing a deadlock/loop between
> kswapd and __alloc_pages/wakeup_kswapd().

bounce buffers for one

