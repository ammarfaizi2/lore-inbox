Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUGJTm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUGJTm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 15:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266363AbUGJTm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 15:42:29 -0400
Received: from witte.sonytel.be ([80.88.33.193]:60131 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266362AbUGJTmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 15:42:21 -0400
Date: Sat, 10 Jul 2004 21:41:44 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Linus Torvalds <torvalds@osdl.org>, Miles Bader <miles@gnu.org>,
       "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, chrisw@osdl.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       sds@epoch.ncsc.mil, jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <Pine.LNX.4.58.0407091313570.20635@scrub.home>
Message-ID: <Pine.GSO.4.58.0407102126150.10242@waterleaf.sonytel.be>
References: <20040707122525.X1924@build.pdx.osdl.net>
 <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <20040707202746.1da0568b.davem@redhat.com>
 <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
 <buosmc3gix6.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org>
 <Pine.LNX.4.58.0407091313570.20635@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2004, Roman Zippel wrote:
> On Thu, 8 Jul 2004, Linus Torvalds wrote:
> > I have one. It's in my head. It's called the Linux Kernel C standard. Some
> > of it is documented in CodinggStyle, others is just codified in existing
> > practice.
>
> So far we have been quite liberal in style questions, what annoys me here
> is that people send warning patches directly to you without even notifying
> the maintainers. If you want people to conform people to a certain
> CodingStyle please document officially in the kernel, sparse isn't
> distributed with the kernel and the sparse police is silently changing the
> kernel all over the place with sometimes questionable benefit. Only the

I agree, when you're talking about the `if ((x = f())' cases. We already added
the extra parentheses to shut up gcc...

> __user warnings had really found the bugs, but the rest I've seen changes
> perfectly legal code.

Sparse also found the following for me:
  - #if NEVER_DEFINED_DEFINE
  - `return f();' in a function returning void (where f() returns void as well)
  - `retval k_and_r_func(/* missing void */) { ... }'
  - `extern' keywords at function definition
  - inline functions used before definition
  - const pointer assigned to non-const pointer (strange, because usually gcc
    tells me as well)
  - `if (x &= mask)' instead of `if (x & mask)'
  - floating point constants assigned to integers
  - `struct x { .field initializer };' (i.e. missing `=')

BTW, the hardest part is adding the __user annotations and making sure
<asm/uaccess.h> does it right (speaking about macros).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
