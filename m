Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWIMQvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWIMQvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWIMQvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:51:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54185 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750772AbWIMQvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:51:16 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060913155734.GA6355@intel.com> 
References: <20060913155734.GA6355@intel.com>  <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com> <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com> 
To: "Luck, Tony" <tony.luck@intel.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/6] Implement a general log2 facility in the kernel 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 13 Sep 2006 17:50:52 +0100
Message-ID: <4005.1158166252@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony <tony.luck@intel.com> wrote:

> > This facility provides three entry points:
> > 
> > 	log2()		Log base 2 of u32
> > 	ll_log2()	Log base 2 of u64
> > 	long_log2()	Log base 2 of unsigned long
> 
> The names are rather counter-intuitive. "ll" sounds like "long long", so
> why does it opearte on *unsigned* 64-bit?  Ditto for "long_log2()".
> Perhaps they should be log2_u32(), log2_u64(), etc.

Well, given that you can't represent a log of a negative number, I'm not sure
it matters.

Note that long_log2() already exists and is of arch-dependent size.

> Even better if someone can come up with the right pre-processor magic
> using sizeof/typeof so that you could just use "log2(any type)"

I then end up with 32 of these per usage if I pass in a definite 32-bit value:

	warning: comparison is always false due to limited range of data type

because of the:

		n >= (1ULL << 63) ? 63 :	\
		n >= (1ULL << 62) ? 62 :	\
		n >= (1ULL << 61) ? 61 :	\
	...

in ll_log2().

David
