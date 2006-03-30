Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWC3CIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWC3CIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWC3CIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:08:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751439AbWC3CIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:08:47 -0500
Date: Wed, 29 Mar 2006 18:08:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
Message-Id: <20060329180830.50666eff.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
References: <20060329122841.GC8186@suse.de>
	<20060329143758.607c1ccc.akpm@osdl.org>
	<Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
>  > - why is the `flags' arg to sys_splice() unsigned long?  Can it be `int'?
> 
>  flags are always unsigned long, haven't you noticed?

<does `man 2 open', gets confused>

> Besides, they should 
>  never be signed, if you do bitmasks and shifting on them: "int" is 
>  strictly worse than "unsigned" when we're talking flags.

Sure, but is there any gain in making flags 64-bit on 64-bit machines when
we cannot use more than 32 bits in there anyway?

> Right now "flags" doesn't do anything at all, and you should just pass in 
> zero.

In that case perhaps we should be enforcing flags==0 so that future
flags-using applications will reliably fail on old flags-not-understanding
kernels.

But that won't work if we later define a bit in flags to mean "behave like
old kernels used to".  So perhaps we should require that bits 0-15 of
`flags' be zero and not care about bits 16-31.

IOW: it might be best to make `flags' just go away, and add new syscalls in
the future as appropriate.

