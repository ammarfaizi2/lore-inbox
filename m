Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVAQFrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVAQFrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 00:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVAQFrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 00:47:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40125 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262699AbVAQFre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 00:47:34 -0500
Date: Sun, 16 Jan 2005 21:47:28 -0800
Message-Id: <200501170547.j0H5lSvb026665@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] i386/x86_64 fpu: fix x87 tag word simulation using fxsave
In-Reply-To: Linus Torvalds's message of  Sunday, 16 January 2005 19:48:42 -0800 <Pine.LNX.4.58.0501161929400.8178@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
Emacs: featuring the world's first municipal garbage collector!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, we're not using C++, so we don't do the "const" part of

Or C89, apparently.

> What happens if it was in MMX mode?

I don't really know anything about that stuff, but what the manuals say is
that using any MMX instruction resets the tag bits and clears the TOS field.
So the patch doesn't change anything for that case (tos == 0).

> If I remember correctly, different CPU's do different things for MMX
> (some rotate them so that "mmx0" is always the same as "st(0)", some
> don't, and/or have separate hw registers altogether for it)? I realize we
> don't probably care, I'm just wondering if somebody knows...

I don't really know, but I have two flavors of manual in front of me.
I suspect you remember incorrectly, or perhaps in the past there was
something like that.  AFAICT, it's always the case that MMX clears the TOS
bits and mmx0 = physical fpr0, which also = st(0) since TOS = 0.


Thanks,
Roland
