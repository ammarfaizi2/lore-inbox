Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUIJAWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUIJAWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUIJAWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:22:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:55695 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266891AbUIJAVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:21:44 -0400
Date: Thu, 9 Sep 2004 17:21:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
In-Reply-To: <20040910000903.GS3106@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
 <20040909154259.GE11358@krispykreme> <20040909171954.GW3106@holomorphy.com>
 <16704.52551.846184.630652@cargo.ozlabs.ibm.com> <20040909220040.GM3106@holomorphy.com>
 <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Sep 2004, William Lee Irwin III wrote:
> 
> Unfortunately the alternative appears to be stack unwinding in
> profile_pc(), which was why I hoped we could punt. Any other ideas?

Why do we care about profile_pc() here? It should do the right thing 
as-is.

What you care about is wchan, and stack unwiding _over_ the spinlocks. 
Since a spinlock can never be part of the wchan callchain, I vote we just 
change "in_sched_functions()" to claim that anything in the spinlock 
section is also a scheduler function as far as it's concerned.

That makes wchan happy, and profile_pc() really never should care.

		Linus
