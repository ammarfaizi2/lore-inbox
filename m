Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUGHMHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUGHMHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 08:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265534AbUGHMHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 08:07:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11473 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265224AbUGHMHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 08:07:52 -0400
Date: Thu, 8 Jul 2004 08:07:19 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040708120719.GS21264@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 09:46:39PM +1000, Nigel Cunningham wrote:
> In response to a user report that suspend2 was broken when compiled with
> gcc 3.4, I upgraded my compiler to 3.4.1-0.1mdk. I've found that the
> restore_processor_context, defined as follows:
> 
> static inline void restore_processor_context(void)
> 
> doesn't get inlined. GCC doesn't complain when compiling the file, and
> so far as I can see, there's no reason for it not to inline the routine.

Try passing -Winline, it will tell you when a function marked inline is not
actually inlined.
Presence of inline keyword is not a guarantee the function will not be
inlined, it is a hint to the compiler.
GCC 3.4 is much bettern than earlier 3.x GCCs in actually inlining functions
marked as inline, but there are still cases when it decides not to inline
for various reasons.  E.g. in C++ world, lots of things are inline, yet
honoring that everywhere would mean very inefficient huge programs.
If a function relies for correctness on being inlined, then it should use
inline __attribute__((always_inline)).

	Jakub
