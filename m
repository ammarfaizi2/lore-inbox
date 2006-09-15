Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWIOBfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWIOBfT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 21:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWIOBfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 21:35:18 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:52948 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751416AbWIOBfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 21:35:17 -0400
Date: Fri, 15 Sep 2006 11:35:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/7] Alter get_order() so that it can make use of
 ilog2() on a constant [try #3]
Message-Id: <20060915113516.ae2c788c.sfr@canb.auug.org.au>
In-Reply-To: <21308.1158234724@warthog.cambridge.redhat.com>
References: <20060914112435.4ce28290.sfr@canb.auug.org.au>
	<20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
	<20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com>
	<21308.1158234724@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, 14 Sep 2006 12:52:04 +0100 David Howells <dhowells@redhat.com> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > After this patch, you don't need to include <linux/compiler.h> any more
> > (and, in fact, the file ends up essentially empty).
> 
> True.  I could possibly delete the whole file, depending on who else has
> designs on it.

I think the patch consolidating PAGE_SIZE may want it.

> > Is there a good reason to move this function out of asm-generic/page.h?
> 
> So that all the general log2-based functions are grouped together was what I
> was thinking (at least their primary interfaces).

Except the get_order() interface is purely related to pages (the fact
that you have reimplemented it using the log2-based functions is just an
implementation detail.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
