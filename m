Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUBHKzO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 05:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUBHKzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 05:55:14 -0500
Received: from dp.samba.org ([66.70.73.150]:45785 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263244AbUBHKzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 05:55:10 -0500
Date: Sun, 8 Feb 2004 21:43:35 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx, rth@twiddle.net
Subject: Re: When should we use likely() / unlikely() / get_unaligned() ?
Message-Id: <20040208214335.58f351d4.rusty@rustcorp.com.au>
In-Reply-To: <1076065578.16147.72.camel@hades.cambridge.redhat.com>
References: <1076065578.16147.72.camel@hades.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Feb 2004 11:06:19 +0000
David Woodhouse <dwmw2@infradead.org> wrote:

> There seems to be no coherent answer to the above questions. On some
> architectures likely() might bypass dynamic branch prediction, so we
> shouldn't use it unless there's at _least_ a 95% probability; on others
> it may simply affect code ordering and we gain a tiny benefit from it if
> the probabilities aren't precisely 50/50.

Yes, agreed.  But many unlikely() macros are simply there because gcc isn't
smart enough yet:

eg. fs/read_write.c:

		if (unlikely(put_user(pos, offset)))
			return -EFAULT;

It'd be better to have gcc know that this function was unlikely to return
a -ve value, and derive all the error paths itself.

It'd also be nice to be able to mark eg. printk() and BUG() as fundamentally
unlikely.

Sometimes, unlikely()/likely() help code readability.  But generally it
should be considered the register keyword of the 2000's: if the case isn't
ABSOLUTELY CRYSTAL CLEAR, or doesn't show up on benchmarks, distain is
appropriate.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
