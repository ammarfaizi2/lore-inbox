Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269411AbUICAQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269411AbUICAQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269395AbUICAPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:15:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:33511 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269412AbUICAGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:06:16 -0400
Date: Thu, 2 Sep 2004 17:06:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][1/8] Arch agnostic completely out of line locks / generic
In-Reply-To: <Pine.LNX.4.58.0409021208310.4481@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0409021703440.2295@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409021208310.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Sep 2004, Zwane Mwaikambo wrote:
> +
> +#define __lockfunc fastcall __attribute__((section(".spinlock.text")))
> +
> +int __lockfunc _spin_trylock(spinlock_t *lock)
...

> +int _spin_trylock(spinlock_t *lock);

This is horribly horribly wrong.

The function is a fastcall function, and it needs to be declared that way, 
otherwise the callers will use the wrong semantics for calling.

This can't have worked.

		Linus
