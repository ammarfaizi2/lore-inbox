Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTL3Ew2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTL3EwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:52:16 -0500
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:7359 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264457AbTL3Etq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:49:46 -0500
Date: Tue, 30 Dec 2003 13:37:27 +1100
From: Rusty Russell <rusty@au1.ibm.com>
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: in_atomic doesn't count local_irq_disable?
Message-Id: <20031230133727.5222bfac.rusty@rustcorp.com.au>
In-Reply-To: <20031229190336.A6746@in.ibm.com>
References: <20031229190336.A6746@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003 19:03:36 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> do_page_fault avoids calling this down_read if we are "in_atomic()"
> Isn't in_atomic supposed to count IRQs disabled case? If not
> then shouldn't do_page_fault also check for irqs_disabled() 
> before calling down_read()?

in_atomic() doesn't actually return true if irqs are disabled.

hence "(in_atomic() || irqs_disabled())" in __might_sleep.

do_page_fault should have the same test...

Thanks,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
