Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUIJAyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUIJAyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUIJAyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:54:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:61604 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266244AbUIJAyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:54:12 -0400
Date: Thu, 9 Sep 2004 17:54:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Blanchard <anton@samba.org>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Paul Mackerras <paulus@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
In-Reply-To: <20040910003505.GG11358@krispykreme>
Message-ID: <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
 <20040909154259.GE11358@krispykreme> <20040909171954.GW3106@holomorphy.com>
 <16704.52551.846184.630652@cargo.ozlabs.ibm.com> <20040909220040.GM3106@holomorphy.com>
 <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com>
 <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org> <20040910003505.GG11358@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Sep 2004, Anton Blanchard wrote:
> 
> With preempt off profile_pc works as expected, timer ticks in spinlocks
> are apportioned to the calling function. Turn preempt on and you end up
> with one big bucket called __preempt_spin_lock where most of the
> spinlock ticks end up.

But that's because "__preempt_spin_lock" on ppc is in the wrong section, 
no?

Just change it from "__sched" to "__lockfunc", and move it to 
kernel/spinlock.c while you're at it, and everything works right. Do the 
same for __preempt_write_lock() too.

Oh, and you need to do the "is_sched_function()" change too that I 
outlined in the previous email.

All in all, about four lines of code changes (+ some movement to make it 
all saner)

		Linus
