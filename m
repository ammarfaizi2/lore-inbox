Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWFTWIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWFTWIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWFTWIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:08:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:459 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751243AbWFTWIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:08:45 -0400
Subject: Re: [patch 0/3] 2.6.17 radix-tree: updates and lockless
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Paul McKenney <Paul.McKenney@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <20060408134635.22479.79269.sendpatchset@linux.site>
References: <20060408134635.22479.79269.sendpatchset@linux.site>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 08:08:10 +1000
Message-Id: <1150841290.1901.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 16:48 +0200, Nick Piggin wrote:
> I've finally ported the RCU radix tree over my radix tree direct-data patch
> (the latter patch has been in -mm for a while now).
> 
> I've also done the last step required for submission, which was to make a
> small userspace RCU test harness, and wire up the rtth so that it can handle
> multiple threads to test the lockless capability. The RCU test harness uses
> an implementation somewhat like Paul's paper's quiescent state bitmask
> approach; with infrequent quiescent state updates, performance isn't bad.
> 
> This quickly flushed out several obscure bugs just when running on my dual
> G5. After fixing those, I racked up about 100 CPU hours of testing on
> SUSE's 64-way Altix without problem. Also passes the normal battery of
> single threaded rtth tests.
> 
> I'd like to hear views regarding merging these patches for 2.6.18. Initially
> the lockless code would not come into effect (good - one thing at a time)
> until tree_lock can start getting lifted in -mm and 2.6.19.

I'm all about it. As I said earlier, I discovered that pp64 has been
abusing radix tree expecting them to work lockless in it's interrupt
management for ages (at least insert vs. search). Fortunatley, the race
is rare enough that it might never have been happening in practice but
still... It would kill me to have to add a big global spinlock on
interrupt handling to fix that so yeah, go for it !

Ben.


