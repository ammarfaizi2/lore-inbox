Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316973AbSFQUTb>; Mon, 17 Jun 2002 16:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316974AbSFQUTa>; Mon, 17 Jun 2002 16:19:30 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:23023 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316973AbSFQUT3>; Mon, 17 Jun 2002 16:19:29 -0400
Date: Mon, 17 Jun 2002 16:19:31 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.22 add __fput for aio
Message-ID: <20020617161931.E1457@redhat.com>
References: <20020617154738.B1457@redhat.com> <Pine.LNX.4.44.0206171307180.2949-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206171307180.2949-100000@home.transmeta.com>; from torvalds@transmeta.com on Mon, Jun 17, 2002 at 01:11:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 01:11:04PM -0700, Linus Torvalds wrote:
> The other alternative is that aio only does the book-keeping from
> interrupt context, adds the "struct file * to be freed" to some list of
> freeable files, and then does __fput() from _non_interrupt_ context on
> those files.
> 
> Is that was aio actually _does_?

Yes -- aio does the atomic_dec_and_test in the interrupt handler, and 
if that was the last user of the struct file *, it queues the io handle 
for cleanup from task context.

> If so, the code may be fine, but the comments are misleading crap and
> should be fixed asap.

Sure.  How's changing it to: 

+/* __fput is called from task task when aio completion releases the last
+ * use of a struct file *.  Do not use otherwise.
+ */

instead?

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
