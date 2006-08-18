Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbWHRQZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWHRQZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbWHRQZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:25:58 -0400
Received: from ns1.suse.de ([195.135.220.2]:59850 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030220AbWHRQZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:25:57 -0400
To: "Vishal Patil" <vishpat@gmail.com>
Cc: "Andrea Arcangeli" <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Page cache using B-trees benchmark results
References: <4745278c0608171843j5b3d28bbx16ddf472e1bdb329@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 18 Aug 2006 18:25:54 +0200
In-Reply-To: <4745278c0608171843j5b3d28bbx16ddf472e1bdb329@mail.gmail.com>
Message-ID: <p73mza280z1.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vishal Patil" <vishpat@gmail.com> writes:

> I am attaching the benchmark results for Page Cache Implementation
> using B-trees. I basically ran the tio (threaded i/o) benchmark
> against my kernel (with the B-tree implementation) and the Linux

I suppose you'll need some more varied benchmarks to get
more solid data.

> kernel shipped with FC5. Radix tree implementation is definately
> better however the B-tree implementation did not suck that bad :)

Have you considered trying it again instead of radix tree with
another data structure? There are still plenty of other big
hash tables in the kernel that might benefit from trying
a different approach:

> dmesg | grep -i hash
PID hash table entries: 4096 (order: 12, 131072 bytes)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)

e.g. the dentry/inode hashes are an obvious attack point.

Of course you'll need benchmarks that actually stress them.

-Andi
