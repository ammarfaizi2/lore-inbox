Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWIQKEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWIQKEo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 06:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWIQKEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 06:04:44 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:29410 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S964855AbWIQKEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 06:04:43 -0400
Date: Sun, 17 Sep 2006 20:04:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/7] Alter get_order() so that it can make use of
 ilog2() on a constant [try #3]
Message-Id: <20060917200451.53251886.sfr@canb.auug.org.au>
In-Reply-To: <13274.1158331362@warthog.cambridge.redhat.com>
References: <20060915113516.ae2c788c.sfr@canb.auug.org.au>
	<20060914112435.4ce28290.sfr@canb.auug.org.au>
	<20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
	<20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com>
	<21308.1158234724@warthog.cambridge.redhat.com>
	<13274.1158331362@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 15:42:42 +0100 David Howells <dhowells@redhat.com> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Except the get_order() interface is purely related to pages (the fact
> > that you have reimplemented it using the log2-based functions is just an
> > implementation detail.
> 
> Do you have a major objection to it moving to linux/log2.h (do you count the
> one you've just raised as "major")?

I just think that things should be grouped according to the function they
provide (and not their implemetation) and get_order is part of the paging
API.

> I'd rather avoid including linux/log2.h or linux/kernel.h in asm/page.h, plus
> asm-generic/page.h isn't used by all archs (though that's a minor point).

You only have to include linux/log2.h in asm-generic/page.h.  Presumably
the architectures that don't use asm-generic/page.h won't want the new
implementation of get_order() either (I didn't keep the original patch).

Won't you need to include linux/log2.h in some places to get get_order(),
now?  And if I was needing the paging API, I am much more likely to look
for it in {linux,asm}/page.h than in linux/log2.h.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
