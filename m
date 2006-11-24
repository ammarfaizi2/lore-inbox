Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757812AbWKXRNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757812AbWKXRNg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 12:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757810AbWKXRNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 12:13:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:39570 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1757811AbWKXRNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 12:13:35 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
Date: Fri, 24 Nov 2006 18:13:13 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>
References: <20061124170246.GA9956@elte.hu>
In-Reply-To: <20061124170246.GA9956@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611241813.13205.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> make the TSC synchronization code more robust, and unify it between 
> x86_64 and i386.
> 
> The biggest change is the removal of the 'fix up TSCs' code on x86_64 
> and i386, in some rare cases it was /causing/ time-warps on SMP systems.

On x86-64 I don't think it can since it doesn't check anymore on sync Intel.

> The new code only checks for TSC asynchronity - and if it can prove a 
> time-warp (if it can observe the TSC going backwards when going from one 
> CPU to another within a critical section), then the TSC clock-source is 
> turned off.

The trouble is that people are using the RDTSC anyways even if the
kernel doesn't. So some synchronization is probably a good idea.

-Andi
