Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264759AbTFERdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbTFERdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:33:12 -0400
Received: from holomorphy.com ([66.224.33.161]:11706 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264759AbTFERdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:33:11 -0400
Date: Thu, 5 Jun 2003 10:46:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: pgcl-2.5.70-bk10-1
Message-ID: <20030605174641.GJ20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From pgcl-2.5.70-bk9-2:
Do some intelligent pagetable preconstruction, in combination with a
small bit of restoration of struct mmu_gather's opacity to the core VM.
>From pgcl-2.5.70-bk9-3:
Also inline various things to cope with identified regressions and for
utterly trivial functions that can be inlined with the non-private
structure declaration.

This hopefully addresses a performance degradation in pte_alloc_one()
in the autoconf build benchmark identified by Randy Hron. Further
tuning may be required to keep space consumption more tightly bounded.
Oddly, this technique is potentially also applicable to mainline. I
vaguely wonder why no one's done it yet.

Unfortunately, neither the sysenter bug nor the bug encountered during
the AIM7 run have had progress made on them.

The unified anonymizing fault handling may end up just going in even
with those bugs pending since it doesn't look likely forward progress
will get made on either in a timely fashion. For testers looking to
just avoid the bugs for now, there are workarounds to #ifdef out some
of the sysenter hooks for ELF loading and coredumping that can help
carry out test runs of things like LTP without tripping things up
I can send out in private mail. The AIM7 bug has no known workaround
or reliable method of reproduction. The sysenter bug is trivial to
reproduce, so don't bother hunting.

This thing's broken the 300KB of diff mark and I've yet to touch a
significant number of drivers, fs's, or non-i386 architectures (3 or 4
drivers, 0 fs's, and 0 non-i386 architectures), and worse yet, I've yet
to polish off the actual core functionality. It could get harder to
maintain, I suppose, but I'm not sure how. I guess I asked for it.

I'm at least hoping the aggressive keeping up-to-date of the past week
or so will float me through the time I'm preoccupied with cpumask_t,
which should happen soon, since the big MIPS merge looks like it's
rapidly closing in on -CURRENT.

As usual, available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/


-- wli
