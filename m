Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVIUUa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVIUUa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVIUUa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:30:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964817AbVIUUaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:30:25 -0400
Date: Wed, 21 Sep 2005 13:29:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] uml: avoid fixing faults while atomic
In-Reply-To: <20050921124957.437cf069.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0509211328150.2553@g5.osdl.org>
References: <200509211923.21861.blaisorblade@yahoo.it>
 <20050921172908.10219.57644.stgit@zion.home.lan> <20050921124957.437cf069.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Sep 2005, Andrew Morton wrote:
>
> There's an extremely special-case in the pagefault handlers where we fail
> the fault if in_atomic().  It's unrelated to spinlocks (spinlocks don't
> even cause in_atomic() to become true if !CONFIG_PREEMPT).

There's a few other places where we use those semantics, though.

Like "get_futex_value_locked()".

> So I think this change is only needed if UML implements kmap_atomic, as in
> arch/i386/mm/highmem.c, which it surely does not do?

No. Every architecture needs to honor it, or they are screwed.

		Linus
