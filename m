Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266730AbUIJBoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266730AbUIJBoB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 21:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUIJBoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 21:44:01 -0400
Received: from ozlabs.org ([203.10.76.45]:60363 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266730AbUIJBny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 21:43:54 -0400
Date: Fri, 10 Sep 2004 11:42:28 +1000
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Paul Mackerras <paulus@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040910014228.GH11358@krispykreme>
References: <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <20040909154259.GE11358@krispykreme> <20040909171954.GW3106@holomorphy.com> <16704.52551.846184.630652@cargo.ozlabs.ibm.com> <20040909220040.GM3106@holomorphy.com> <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com> <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org> <20040910003505.GG11358@krispykreme> <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> But that's because "__preempt_spin_lock" on ppc is in the wrong section, 
> no?
> 
> Just change it from "__sched" to "__lockfunc", and move it to 
> kernel/spinlock.c while you're at it, and everything works right. Do the 
> same for __preempt_write_lock() too.
> 
> Oh, and you need to do the "is_sched_function()" change too that I 
> outlined in the previous email.

Yep Im agreeing with you :) But we also need to fix profile_pc() since
it wont handle the 2 deep _spin_lock -> __preempt_spin_lock. Should be
no problems, ill work on this.

Anton
