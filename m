Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUIIP1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUIIP1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUIIP1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:27:48 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:24017 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265462AbUIIP1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:27:46 -0400
Date: Thu, 9 Sep 2004 11:32:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>, Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
In-Reply-To: <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2004, Linus Torvalds wrote:

> On Thu, 9 Sep 2004, Linus Torvalds wrote:
> > 
> > and the fact is, this is all much better just done in the arch-specific 
> > spinlock code. 
> 
> This is especially true since some architectures may have high overheads 
> for this, so you may do normal spinning for a while before you even start 
> doing the "fancy" stuff. So there is no ay we should expose this as a 
> "generic" interface. It ain't generic. It's very much a low-level 
> implementation detail of "spin_lock()".

Agreed, Paul we may as well remove the cpu_relax() in __preempt_spin_lock 
and use something like "cpu_yield" (architectures not supporting it would 
just call cpu_relax) i'll have something for you later.

Thanks,
	Zwane
