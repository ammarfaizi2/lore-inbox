Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUFNLF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUFNLF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 07:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUFNLF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 07:05:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:21440 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262380AbUFNLFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 07:05:19 -0400
Date: Mon, 14 Jun 2004 04:04:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated >
 MAX_ORDER size [try #3]
Message-Id: <20040614040417.29e7497b.akpm@osdl.org>
In-Reply-To: <18241.1087210067@redhat.com>
References: <20040611150110.73fadefb.akpm@osdl.org>
	<567.1086950642@redhat.com>
	<6567.1086963705@redhat.com>
	<18241.1087210067@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> > What's the attribute((pure)) for?
> 
> It tells gcc that the function's result only depends on its arguments... it
> makes no references at all to external data. It's like __attribute__((const))
> but stronger. This means that gcc can generate code that caches the result.

Of course, but we could use it in zillions of places and we don't.  Does it
actually help?

> > It generates a warning on older gcc - please use __attribute_pure__.
> 
> We still support gcc's that old?

yup.  And gcc-3.4 complains that log2() conflicts with an inbuilt function,
but you renamed it.

> > The other four or five implementations of log2() use ffx(~n).
> 
> Yes... but ffs() and ffz() take int args, not long args. I suspect that
> shouldn't matter (that would require the hash table to be calculated at 4Gig
> buckets in size or greater to be a problem), but why take the chance when we
> can avoid it easily?

No, ffz() takes an unsigned long argument.


It's still not clear to me why we cannot simply increase MAX_ORDER.  If
that exposes shortcomings in the buddy allocator, that should be where we
expend effort?
