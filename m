Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUIPG44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUIPG44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 02:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUIPG4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 02:56:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9184 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267777AbUIPG4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 02:56:46 -0400
Date: Thu, 16 Sep 2004 08:58:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@fsmlabs.com>,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916065805.GA12244@elte.hu>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com> <20040915144523.0fec2070.akpm@osdl.org> <20040916061359.GA12915@wotan.suse.de> <20040916062759.GA10527@elte.hu> <20040916064428.GD12915@wotan.suse.de> <20040916065101.GA11726@elte.hu> <20040916065342.GE12915@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916065342.GE12915@wotan.suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> > the alternative would be to unwind the stack - quite some task on some 
> > platforms ...
> 
> Sometimes call graph profiling would be very useful, but I wouldn't
> want the profiler to do it by default, especially not for this silly
> simple case. dwarf2 unwinding is complex enough that just requiring
> frame pointers for the CG case would look attractive.

but ... frame pointers are overhead to all of the kernel. (the overhead
is less pronounced on architectures with more registers, but even with
15 registers, 14 or 15 can still be a difference.) While unwinding is
overhead to profiling only - if enabled. Also, there could be other
functionality (exception handling?) that could benefit from dwarf2
unwinding.

	Ingo
