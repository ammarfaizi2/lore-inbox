Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTJ0SdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTJ0SdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:33:17 -0500
Received: from zero.aec.at ([193.170.194.10]:24074 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263420AbTJ0SdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:33:16 -0500
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86
 Architecture
From: Andi Kleen <ak@muc.de>
Date: Mon, 27 Oct 2003 19:33:01 +0100
In-Reply-To: <LhtX.bs.13@gated-at.bofh.it> ("J.A. Magallon"'s message of
 "Mon, 27 Oct 2003 16:30:21 +0100")
Message-ID: <m3k76qsf8i.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <JB3R.23s.23@gated-at.bofh.it> <JWKQ.7nS.15@gated-at.bofh.it>
	<LhtX.bs.15@gated-at.bofh.it> <LhtX.bs.13@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> writes:

> Patch inlined. Credits should go to Zwane Mwaikambo <zwane@linux.realnet.co.sz>.
> It adds the corresponding flags for PII) and P4, and in case thei are defined,
> the *fence insn are used.
>
> Included is also one other patch by Zwane, which states that smp_call_function
> needs mb() instead of wmb().
>
> I use them regularly, so they look safe. Are they really better ? At least they
> do not touch any register, like the trick used till now.

The current code also does not touch any register. It has a gcc memory
barrier, which is costly, but needed.

The wmb() change is not needed, unless you have an oostore CPU
(x86 has ordered writes by default). It probably does not hurt
neither though (I do it the same way on x86-64), but also doesn't 
change anything.

I think overall the patch is a very bad idea because it adds weird CPU
dependencies to the image again for very little again If you really
want to do this use alternative() and runtime patching. But it's
probably not worth the effort - don't do it until you can demonstrate
a difference in any benchmark.

-Andi
