Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWCDLUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWCDLUT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 06:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWCDLUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 06:20:19 -0500
Received: from colin.muc.de ([193.149.48.1]:44808 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751292AbWCDLUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 06:20:18 -0500
Date: 4 Mar 2006 12:20:10 +0100
Date: Sat, 4 Mar 2006 12:20:10 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org, johnstul@us.ibm.com,
       Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64 aliasing problem)
Message-ID: <20060304112010.GA94875@muc.de>
References: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp> <20060302190408.1e754f12.akpm@osdl.org> <20060303.133125.106438890.nemoto@toshiba-tops.co.jp> <20060304.013153.71086081.anemo@mba.ocn.ne.jp> <20060304001834.0476e8e9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304001834.0476e8e9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> b) On 64-bit machines jiffies and jiffies_64 always have the same
>    address (don't they?) Is the compiler really going to move a read of an
>    absolute address ahead of a modification of the same address?
> 
>    <looks>
> 
>    The address of jiffies isn't known until link time, so yup, the risk
>    is there.

Yes maybe it would be better to just use  #define there.
jiffies_64 always was a bit too clever.

> 
> c) jiffies is declared volatile.  In practice, if I know my gcc, it's
>    just not going to play these reordering games with a volatile.
> 
>    If that's true, and if some standard (presumably c99) says that it
>    must be true then I don't think we need the patch.

The standards definition of volatile is unfortunately quite vague,
so at least from this side you cannot rely on much.

Also I assume Atsushi-san did the patch because he saw a real problem?

-Andi

