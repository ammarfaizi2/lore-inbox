Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVGWPfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVGWPfq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 11:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVGWPfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 11:35:45 -0400
Received: from mx1.suse.de ([195.135.220.2]:10221 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261764AbVGWPfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 11:35:43 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, 76306.1226@compuserve.com
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
References: <200507212309_MC3-1-A534-95EF@compuserve.com.suse.lists.linux.kernel>
	<20050722132756.578acca7.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Jul 2005 17:35:38 +0200
In-Reply-To: <20050722132756.578acca7.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p73br4tbkmt.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
> 
> We do have the `used_math' optimisation in there which attempts to avoid
> doing the FP save/restore if the app isn't actually using math.  But
> <ancient recollections> there's code in glibc startup which always does a
> bit of float, so that optimisation is always defeated.  There was some
> discussion about periodically setting tasks back into !used_math state to
> try to restore the optimisation for tasks which only do a little bit of FP,
> but nothing actually got done.

Actually we reset the flag on every context switch, so that works just fine.

But I was considering to do it less often so that we switch the FP 
state non lazily for FP intensive processes and avoid the overhead
of all these exceptions.

-Andi

P.S.: Original profile data looks a bit fishy. Normally avoiding a single
function call should not make tht much difference unless you call
it in a inner loop, but that is not the case here.
