Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129385AbQKKXTL>; Sat, 11 Nov 2000 18:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbQKKXTC>; Sat, 11 Nov 2000 18:19:02 -0500
Received: from u-177.karlsruhe.ipdial.viaginterkom.de ([62.180.21.177]:33030
	"EHLO u-177.karlsruhe.ipdial.viaginterkom.de") by vger.kernel.org
	with ESMTP id <S129385AbQKKXS4>; Sat, 11 Nov 2000 18:18:56 -0500
Date: Sat, 11 Nov 2000 14:06:34 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: rth@cygnus.com, Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_task() and thread_saved_pc() fix for x86
Message-ID: <20001111140634.A4865@bacchus.dhis.org>
In-Reply-To: <Pine.GSO.4.21.0011101618030.17943-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0011101618030.17943-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Nov 10, 2000 at 04:26:32PM -0500
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 04:26:32PM -0500, Alexander Viro wrote:

> 	* thread_saved_pc() on x86 returns (thread->esp)[3]. Bogus, since the
> third word from the stack top has absolutely nothing to return address of
> any kind. Correct value: (thread->esp)[0][1] - ebp is on top of the stack
> and the rest is obvious. Current code gives completely bogus addresses -
> try to say Alt-SysRq-T and watch the show.

Reminds me that the Alpha implementation of get_wchan() looks to me like
it doesn't handle all cases of schedule() being called from another
scheduler function correctly.  Some Alpha guru may want to take a look at
it.

I recently had to fix the mips / mips64 versions of get_wchan() - for the
dozenth time.  I'd really like to see a wchan field in task_struct to avoid
get_wchan breaking every once in a while.  Current implementation more than
qualifies as a crazy hack ...

  Ralf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
