Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268234AbUGXCOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268234AbUGXCOr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 22:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUGXCOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 22:14:47 -0400
Received: from peabody.ximian.com ([130.57.169.10]:53909 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268234AbUGXCOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 22:14:44 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040723200335.521fe42a.akpm@osdl.org>
References: <1090604517.13415.0.camel@lucy>
	 <20040723200335.521fe42a.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 23 Jul 2004 22:14:57 -0400
Message-Id: <1090635297.1830.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-23 at 20:03 -0700, Andrew Morton wrote:

> OK.  Can you give us a ballpark estimate of how many send_kmessage() calls
> we're likely to have in two years time?

Predicting the future is hard, but I suspect this number to be small.
Let's say 10 in core kernel code?

If this takes off as a solution for error reporting, that number will be
much larger in drivers.

> - The GFP_ATOMIC page allocation is unfortunate.  Please pass in the
>   gfp_flags, or change it to GFP_KERNEL and provide a separate
>   send_kmessage_atomic()?

I like the latter.

> - Methinks the kernel won't build if the user set CONFIG_NETLINK_DEV=n

I will test and fix.

> - When fixing that up, please add CONFIG_KERNEL_EVENTS or whatever,
>   provide the appropriate do-nothing stubs if it's disabled.  For the tiny
>   systems.

OK.

> - send_kmessage() is racy against kmessage_exit().  I'm not sure that's
>   worth fixing - if you agree then it would set minds at ease to simply
>   remove kmessage_exit().

The race is definitely not worth fixing.  If it bothers you, then
removing kmessage_exit() makes sense.  I will do that.

> - This code will never work as a module, so why include the
>   MODULE_AUTHOR/DESCRIPTION/etc?

Can be removed.

> - What led to the decision to export send_kmessage() to only GPL modules?

I am a fanatic about freedom?  Seriously, I will talk to Arjan about
changing it.  I do not care either way.

Updated patch forthcoming.

Thanks,

	Robert Love


