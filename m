Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265315AbUHAHTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUHAHTT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 03:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUHAHTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 03:19:19 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:48114 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265315AbUHAHTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 03:19:17 -0400
Date: Sun, 1 Aug 2004 03:22:56 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
In-Reply-To: <20040731232126.1901760b.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
 <20040731232126.1901760b.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2004, Paul Jackson wrote:

> When I tried it just now on an ia64 sn2_defconfig, NR_CPUS == 512, it
> increased each for_*_cpu() loop about 28 bytes of text, for a kernel
> text size increase of 1352 bytes (this is on a private kernel I have,
> your results will vary).

I haven't checked the text size increase, but will do.

> Could you explain this a bit more?  What value of NR_CPUS were you
> using -- if NR_CPUS == 32, then I'd _expect_ any_online_cpu() to return
> 32 if none of the bits provided it were online.  The way you phrase
> this, it sure seems that you are hinting at a bug in the i386 implementation
> of find_next_bit().  But I can't quite make out the code, nor what you're
> saying, so I'm still confused.
>
> A specific example might help -- NR_CPUS is this, what's online is that,
> called "any_online_cpu()" with so-and-so, expected thus as a return, got
> something else instead.
>
> I'd hate to see a bug in i386 find_next_bit() left to stand, at the
> expense of increasing sometimes fairly interesting code loops by 28
> bytes of text each.  If that's what's happening here ...

NR_CPUS was 3, the test case may as well be passing first_cpu or next_cpu
a value of 0 for the map. The "bug" in the i386 find_next_bit really
looks like a feature if you look at the code.
