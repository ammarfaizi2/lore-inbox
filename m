Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbUJ0DXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbUJ0DXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUJ0DXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:23:34 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:35800 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261620AbUJ0DWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:22:40 -0400
Date: Wed, 27 Oct 2004 05:23:38 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041027032338.GU14325@dualathlon.random>
References: <417DCFDD.50606@yahoo.com.au> <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com> <20041027005425.GO14325@dualathlon.random> <417F025F.5080001@yahoo.com.au> <20041027022920.GS14325@dualathlon.random> <417F0FA2.4090800@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417F0FA2.4090800@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 01:01:54PM +1000, Nick Piggin wrote:
> Currently it does not overschedule, because one zone is always
> going to be low by the time kswapd wakes up. This causes all zones
> below to be scanned as well.

that's quite subtle (after all it's needed only for the numa pgdats) and
I agree on the wakeup side, the one thing that is wrong instead is the
kswapd-stop side. On that side you really need to know every single zone
that has to be balanced.  So whatever, you can't just use pages_high
there. I'm creating a zone->max_lowmem_reserve to fix that efficiently
(that's recalculated every time with the sysctl and at boot).

However my patch to wakeup_kswapd sure wouldn't hurt there.
