Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVDFFyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVDFFyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 01:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVDFFyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 01:54:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28329 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262113AbVDFFyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 01:54:16 -0400
Date: Wed, 6 Apr 2005 07:54:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 3/5] sched: multilevel sbe and sbf
Message-ID: <20050406055409.GA5973@elte.hu>
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42532346.5050308@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> 3/5

> The fundamental problem that Suresh has with balance on exec and fork
> is that it only tries to balance the top level domain with the flag
> set.
> 
> This was worked around by removing degenerate domains, but is still a
> problem if people want to start using more complex sched-domains, especially
> multilevel NUMA that ia64 is already using.
> 
> This patch makes balance on fork and exec try balancing over not just the
> top most domain with the flag set, but all the way down the domain tree.
> 
> Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Acked-by: Ingo Molnar <mingo@elte.hu>

note that no matter how much scheduler logic, in the end 
cross-scheduling of tasks between nodes on NUMA will always have a 
permanent penalty (i.e. the 'migration cost' is 'infinity' in the long 
run), so the primary focus _hast to be_ on 'get it right initially' When 
tasks must spill over to other nodes will always remain a special case.  
So balance-on-fork/exec/[clone] definitely needs to be aware of the full 
domain tree picture.

	Ingo
