Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbTGJTkJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 15:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbTGJTkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 15:40:09 -0400
Received: from mail-out2.apple.com ([17.254.0.51]:6045 "EHLO
	mail-out2.apple.com") by vger.kernel.org with ESMTP id S266454AbTGJTkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 15:40:05 -0400
Date: Thu, 10 Jul 2003 12:53:44 -0700
Subject: Re: [PATCH] Fix do_div() for all architectures
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v551)
Cc: Dale Johannesen <dalej@apple.com>, Richard Henderson <rth@twiddle.net>,
       Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Peter Chubb <peter@chubb.wattle.id.au>,
       Andrew Morton <akpm@digeo.com>, Ian Molton <spyro@f2s.com>,
       gcc@gcc.gnu.org
To: Bernardo Innocenti <bernie@develer.com>
From: Dale Johannesen <dalej@apple.com>
In-Reply-To: <200307102131.45474.bernie@develer.com>
Message-Id: <3645F0F8-B310-11D7-890F-000393D76DAA@apple.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 10, 2003, at 12:31  PM, Bernardo Innocenti wrote:
>
>  The compiler could easily tell what memory can be clobbered by a 
> pointer
> by applying type-based aliasing rules. For example, a function taking a
> "char *" can't clobber memory objects declared as "long bar" or
> "struct foo".

No, for two reasons.  First, anything can be aliased by a char.  Second,
the restriction is on the type of the eventual memory reference,
not on the type of the pointer.  Assuming an int* p, you can still do 
*((char*)p) and
that may alias anything.  So you must check each dereference; this 
can't be
done easily at function entry.

