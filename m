Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263560AbTIBGwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 02:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbTIBGwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 02:52:16 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:12682 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263560AbTIBGwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 02:52:15 -0400
Date: Tue, 2 Sep 2003 07:51:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-ID: <20030902065144.GC7619@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309012053110.1817-100000@localhost.localdomain> <20030902050921.355452C0A8@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902050921.355452C0A8@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What happens after this sequence:

	1. process A forks, making process B
	2. B does FUTEX_FD, or splits into threads and one does FUTEX_WAIT,
	   on a private page that has not been written to since the fork
	3. A does FUTEX_WAIT on the same address
	3. The page is swapped out
	4. B does FUTEX_WAKE at the same address

Won't the futex be hashed on the swap entry at step 4, so that
both processes are woken, yet only the waiter in B should be woken?

Related: could COW sharing after fork() explain the spurious wakeups I
saw mentioned earlier in the thread?

-- Jamie
