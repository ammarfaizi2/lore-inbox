Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTIBNqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 09:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbTIBNqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 09:46:03 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:10758
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262489AbTIBNpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 09:45:44 -0400
Subject: Re: [PATCH] might_sleep() improvements
From: Robert Love <rml@tech9.net>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030902075145.GA12817@sfgoth.com>
References: <20030902075145.GA12817@sfgoth.com>
Content-Type: text/plain
Message-Id: <1062510937.28552.7.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Tue, 02 Sep 2003 09:55:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-02 at 03:51, Mitchell Blank Jr wrote:

> Andrew - I thought this might be appropriate for -mm kernels.
> 
> This patch makes the following improvements to might_sleep():

Good.  These checks are very useful.

>  o Add a "might_sleep_if()" macro for when we might sleep only if some
>    condition is met.

But I am neutral about this.  One thing that BUG_ON() gives is that the
if has an unlikely() in it, so it at least guarantees some improved
semantics.

Another bit is that we have historically avoided conditional code (i.e.,
cruft like smp_if() etc. that you see elsewhere) like this.  Maybe
renaming this "might_sleep_on()" at least brings it more in line with
BUG_ON(), and avoids looking like the gross constructs I fear.

>  o Add might_sleep checks to skb_share_check() and skb_unshare() which
>    sometimes need to allocate memory.

Great.

>  o Make all architectures call might_sleep() in both down() and
>    down_interruptible().  Before only ppc, ppc64, and i386 did this check.
>    (sh did the check on down() but not down_interruptible())

Even better.

	Robert Love


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, 2003-09-02 at 03:51, Mitchell Blank Jr wrote:

> Andrew - I thought this might be appropriate for -mm kernels.
> 
> This patch makes the following improvements to might_sleep():

Good.  These checks are very useful.

>  o Add a "might_sleep_if()" macro for when we might sleep only if some
>    condition is met.

But I am neutral about this.  One thing that BUG_ON() gives is that the
if has an unlikely() in it, so it at least guarantees some improved
semantics.

Another bit is that we have historically avoided conditional code (i.e.,
cruft like smp_if() etc. that you see elsewhere) like this.  Maybe
renaming this "might_sleep_on()" at least brings it more in line with
BUG_ON(), and avoids looking like the gross constructs I fear.

>  o Add might_sleep checks to skb_share_check() and skb_unshare() which
>    sometimes need to allocate memory.

Great.

>  o Make all architectures call might_sleep() in both down() and
>    down_interruptible().  Before only ppc, ppc64, and i386 did this check.
>    (sh did the check on down() but not down_interruptible())

Even better.

	Robert Love


