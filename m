Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUDOMwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 08:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUDOMwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 08:52:35 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44207
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263003AbUDOMwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 08:52:33 -0400
Date: Thu, 15 Apr 2004 14:52:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <20040415125237.GA2150@dualathlon.random>
References: <35840000.1082010202@[10.10.2.4]> <Pine.LNX.4.44.0404151122190.6954-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404151122190.6954-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 11:26:09AM +0100, Hugh Dickins wrote:
> On Wed, 14 Apr 2004, Martin J. Bligh wrote:
> > 
> > FYI, even without prio-tree, I get a 12% boost from converting i_shared_sem
> > into a spinlock. I'll try doing the same on top of prio-tree next.
> 
> Good news, though not a surprise.
> 
> Any ideas how we might handle latency from vmtruncate (and
> try_to_unmap) if using prio_tree with i_shared_lock spinlock?

we'd need to break the loop after need_resched returns 1 (and then the
second time we'd just screw the latency and go ahead).  I also wanted to
make it a spinlock again like in 2.4, the semaphore probably generates
overscheduling. OTOH the spinlock saved some cpu in slightly different
workloads with big truncates (plus it made the cond_resched trivial w/o
requiring loop break) and I agree with Andrew about that, Martin isn't
benchmarking the other side, the one that made Andrew to change it to a
semaphore.
