Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265761AbSJTEQZ>; Sun, 20 Oct 2002 00:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265762AbSJTEQY>; Sun, 20 Oct 2002 00:16:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35627 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265761AbSJTEQY>; Sun, 20 Oct 2002 00:16:24 -0400
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
References: <Pine.LNX.3.96.1021019151523.29078E-200000@gatekeeper.tmr.com>
	<63160000.1035056177@baldur.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Oct 2002 22:20:47 -0600
In-Reply-To: <63160000.1035056177@baldur.austin.ibm.com>
Message-ID: <m1znt9wxk0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> writes:

> This patch isn't primarily a performance patch.  It does help for some
> things, notably the fork/exec/exit cases mentioned above.  But its primary
> goal is to reduce the amount of memory wasted in page tables mapping the
> same pages into multiple processes.  We have seen an application that
> consumed on the order of 10 GB of page tables to map a single shared memory
> chunk across hundreds of processes.  Shared page tables would eliminate
> this overhead.

Have you considered putting a fixed upper bound on the number of pages
tables a page can be mapped into?  This would result in the same amount
of memory reduction, with what should be very little complexity.

I admit there would be a few more demand paging hits, but they should be
controllable.  And I suspect their performance impact would be lost
in the noise.

Eric
