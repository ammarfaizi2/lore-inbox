Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbUKFPdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbUKFPdV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 10:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbUKFPdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 10:33:21 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:8656 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261398AbUKFPdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 10:33:13 -0500
Date: Sat, 6 Nov 2004 16:32:09 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041106153209.GC3851@dualathlon.random>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <418C2861.6030501@cyberone.com.au> <20041106015051.GU8229@dualathlon.random> <16780.46945.925271.26168@thebsh.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16780.46945.925271.26168@thebsh.namesys.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 02:37:05PM +0300, Nikita Danilov wrote:
> We need page-reservation API of some sort. There were several attempts
> to introduce this, but none get into mainline.

they're already in under the name of mempools

I'm perfectly aware the fs tends to be the less correct places in terms
of allocations, and luckily it's not an heavy memory user, so I still
have to see a deadlock in getblk or create_buffers or similar. It's
mostly a correctness issue (math proof it can't deadlock, right now it
can if more tasks all get stuck in getblk at the same time during a hard
oom condition etc..).
