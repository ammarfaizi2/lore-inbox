Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263231AbUEGVRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUEGVRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 17:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUEGVRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 17:17:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:17310
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263231AbUEGVRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 17:17:33 -0400
Date: Fri, 7 May 2004 19:53:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Jack Steiner <steiner@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040507175358.GD3829@dualathlon.random>
References: <20040501120805.GA7767@sgi.com> <20040501211704.GY1445@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040501211704.GY1445@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 02:17:04PM -0700, William Lee Irwin III wrote:
> On Sat, May 01, 2004 at 07:08:05AM -0500, Jack Steiner wrote:
> > On a 512p idle 2.6.5 system, each cpu spends ~6% of the time in the kernel
> > RCU code. The time is spent contending for shared cache lines.
> 
> Would something like this help cacheline contention? This uses the
> per_cpu data areas to hold per-cpu booleans for needing switches.
> Untested/uncompiled.
> 
> The global lock is unfortunately still there.

I'm afraid this cannot help, the rcu_cpu_mask and the mutex are in the same
cacheline, so it's not just about the global lock being still there,
it's about the cpumask being in the same cacheline with the global lock.
