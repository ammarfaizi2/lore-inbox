Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268259AbUIPRBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268259AbUIPRBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUIPQrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:47:24 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:38356 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268185AbUIPQoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:44:22 -0400
Date: Thu, 16 Sep 2004 12:44:23 +0000 (UTC)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
In-Reply-To: <20040916062759.GA10527@elte.hu>
Message-ID: <Pine.LNX.4.53.0409161238030.2897@musoma.fsmlabs.com>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com>
 <20040915144523.0fec2070.akpm@osdl.org> <20040916061359.GA12915@wotan.suse.de>
 <20040916062759.GA10527@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Ingo Molnar wrote:

> the ebp trick is nice, but forcing a formal stack frame for every
> function has global performance implications. Couldnt we define some
> sort of current-> field [or current_thread_info() field] that the
> spinlock code could set and clear, which field would be listened to by
> profile_pc(), so that the time spent spinning would be attributed to the
> callee? Something like:

I think the generic route is nice but wouldn't this break with the 
following.

taskA:
spin_lock(lockA); // contended
<interrupt>
int1:
spin_lock(lockB)

I was thinking along the likes of a per_cpu real_pc, but realised it falls 
prey to the same problem as above... Unless we have irq threads, then of 
course your solution works.

	Zwane

