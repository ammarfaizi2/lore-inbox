Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVL1OkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVL1OkP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVL1OkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:40:14 -0500
Received: from mx.pathscale.com ([64.160.42.68]:40364 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964827AbVL1OkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:40:12 -0500
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, akpm@osdl.org,
       hch@infradead.org
In-Reply-To: <adazmmmc9hl.fsf@cisco.com>
References: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com>
	 <adazmmmc9hl.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 28 Dec 2005 06:40:03 -0800
Message-Id: <1135780804.1527.82.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 17:10 -0800, Roland Dreier wrote:

> I think the principle of least surprise calls for memcpy_toio32 to be
> ordered the same way memcpy_toio is.  In other words there should be a
> wmb() after the loop.

Will do.

> Also, no need for the { } for the while loop.

Fine.  There doesn't seem to be much consistency in whether to use
curlies for single-line blocks.

> You're adding this symbol and exporting it even if the arch will
> supply its own version.  So this is pure kernel .text bloat...

I don't know what you'd prefer, so let me enumerate a few alternatives,
and you can either tell me which you'd prefer, or point out something
I've missed that would be even better.  I'm entirely flexible on this.

      * Use the __HAVE_ARCH_* mechanism that include/asm-*/string.h
        uses.  Caveat: Linus has lately come out as hating this style.
        It makes for the smallest patch, though.
      * Define the generic code in lib/, and have each arch that really
        uses it export it.
      * Put generic code in include/asm-generic/algo-memcpy_toio32.h,
        and have each arch that needs it #include it somewhere and use
        it.

Have I missed anything?

	<b

