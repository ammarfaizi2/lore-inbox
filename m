Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbSLFSIQ>; Fri, 6 Dec 2002 13:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbSLFSIQ>; Fri, 6 Dec 2002 13:08:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15883 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265681AbSLFSIP>; Fri, 6 Dec 2002 13:08:15 -0500
Date: Fri, 6 Dec 2002 10:16:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Miles Bader <miles@gnu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Make `hash_long' function work if bits parameter is 0.
In-Reply-To: <20021206175806.GB15923@gnu.org>
Message-ID: <Pine.LNX.4.44.0212061013170.23118-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Fri, 6 Dec 2002, Miles Bader wrote:
>
> The reason I sent the patch is because I ran into a case where the return
> value _should_ be zero -- on a machine with very little memory (1MB), the
> page wait-queue hash-table ends up having only one bucket (it has 256 pages,
> and the code tries to make a wait-queue for every 256 pages....).  The 0 is
> returned by the `wait_table_bits' function in mm/page_alloc.c.

Ahh, ok. Fair enough, but I do have to say that I consider a hash of size
1 to be kind of useless, so even then I think the right approach is:

> I suppose an alternative in this case is to special-case above
> calculation to peg the minimum at 1.

Yup. It needs a special case _somewhere_, and I suspect it's clearer to
just make the special case be where the issue is.

		Linus

