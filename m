Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268138AbUIPT3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268138AbUIPT3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 15:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbUIPT3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 15:29:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32173 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268138AbUIPT3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 15:29:06 -0400
Date: Thu, 16 Sep 2004 21:30:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916193013.GA25730@elte.hu>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com> <20040915144523.0fec2070.akpm@osdl.org> <20040916061359.GA12915@wotan.suse.de> <20040916062759.GA10527@elte.hu> <Pine.LNX.4.53.0409161238030.2897@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409161238030.2897@musoma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

> On Thu, 16 Sep 2004, Ingo Molnar wrote:
> 
> > the ebp trick is nice, but forcing a formal stack frame for every
> > function has global performance implications. Couldnt we define some
> > sort of current-> field [or current_thread_info() field] that the
> > spinlock code could set and clear, which field would be listened to by
> > profile_pc(), so that the time spent spinning would be attributed to the
> > callee? Something like:
> 
> I think the generic route is nice but wouldn't this break with the 
> following.
> 
> taskA:
> spin_lock(lockA); // contended
> <interrupt>
> int1:
> spin_lock(lockB)
> 
> I was thinking along the likes of a per_cpu real_pc, but realised it
> falls prey to the same problem as above... Unless we have irq threads,
> then of course your solution works.

you mean the nesting? spin_lock() should save/restore the value instead
of setting/clearing it - and fork() should initialize it to zero.

	Ingo
