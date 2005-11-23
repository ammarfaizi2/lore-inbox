Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbVKWCIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbVKWCIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbVKWCIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:08:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28645 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965208AbVKWCIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:08:38 -0500
Date: Tue, 22 Nov 2005 18:08:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jeffrey.hundstad@mnsu.edu, zlynx@acm.org, ak@muc.de,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc2
Message-Id: <20051122180817.465d465c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511221735400.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
	<43829ED2.3050003@mnsu.edu>
	<20051122150002.26adf913.akpm@osdl.org>
	<Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
	<20051122170507.37ebbc0c.akpm@osdl.org>
	<Pine.LNX.4.64.0511221735400.13959@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Tue, 22 Nov 2005, Andrew Morton wrote:
> > > 
> > > Why does it happen at all, though?
> > 
> > davem recently merged a patch which adds ext3 ioctls to fs/compat_ioctl.c. 
> > That required inclusion of ext3 and jbd header files.  Those files explode
> > unpleasantly when CONFIG_JBD=n.
> 
> Oh. How about just making jbd.h do the rigt thing, and not care about the 
> configuration?
> 
> If we include jbd.h, we want the jbd data structures. There's never any 
> reason to care whether jbd is enabled or not afaik.

Yes, that would be the right thing to do.

> ...
> -#if defined(__KERNEL__) && !(defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE))
> -
> -#define J_ASSERT(expr)			do {} while (0)
> -#define J_ASSERT_BH(bh, expr)		do {} while (0)
> -#define buffer_jbd(bh)			0
> -#define journal_buffer_journal_lru(bh)	0
> -
> -#endif	/* defined(__KERNEL__) && !defined(CONFIG_JBD) */

I guess the core kernel once needed these, but it doesn't (and shouldn't) now.
