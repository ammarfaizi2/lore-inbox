Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272586AbTHKNdc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272587AbTHKNdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:33:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22788 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S272586AbTHKNdT (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 11 Aug 2003 09:33:19 -0400
Subject: Re: volatile variable
From: David Woodhouse <dwmw2@infradead.org>
To: root@chaos.analogic.com
Cc: Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>,
       mlist-linux-kernel@nntp-server.caltech.edu
In-Reply-To: <Pine.LNX.4.53.0308010723060.3077@chaos>
References: <20030801105706.30523.qmail@webmail28.rediffmail.com>
	 <Pine.LNX.4.53.0308010723060.3077@chaos>
Content-Type: text/plain
Message-Id: <1060608783.19194.13.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Mon, 11 Aug 2003 14:33:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-01 at 12:38, Richard B. Johnson wrote:
> First, there are already procedures available to do just
> what you seem to want to do, interruptible_sleep_on() and
> interruptible_sleep_on_timeout(). These take care of the
> ugly details that can trip up compilers.

Just in case there are people reading this who don't realise that
Richard is trolling -- do not ever use sleep_on() and friends. They
_will_ introduce bugs, and hence they _will_ be removed from the kernel
some time in the (hopefully not-so-distant) future.

> In any event in your loop, variable 'a', has already been
> read by the code the compiler generates. There is nothing
> else in the loop that touches that variable. Therefore
> the compiler is free to (correctly) assume that whatever
> it was when it was first read is what it will continue to
> be. The compiler will therefore optimise it to be a single
> read and compare. So, the loop will continue forever if
> 'a' started as zero because the compiler correctly knows
> that it cannot possibly change in the only execution
> path that it knows about.

If 'a' is a local variable that's true. If 'a' is a global as the
original poster explicitly declared, then the compiler must assume that
function calls (such as the one to schedule()) may modify it, and hence
may not optimise away the second and subsequent reads. Therefore, the
'volatile' is not required.

Richard, stop taunting the newbies :)

-- 
dwmw2

