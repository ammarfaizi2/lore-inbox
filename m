Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUGKQOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUGKQOO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 12:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266623AbUGKQOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 12:14:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:55948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266622AbUGKQON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 12:14:13 -0400
Date: Sun, 11 Jul 2004 09:14:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <Pine.GSO.4.58.0407111226350.3963@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58.0407110909570.1764@ppc970.osdl.org>
References: <20040707122525.X1924@build.pdx.osdl.net>
 <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <20040707202746.1da0568b.davem@redhat.com>
 <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
 <buosmc3gix6.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org>
 <Pine.LNX.4.58.0407091313570.20635@scrub.home>
 <Pine.GSO.4.58.0407102126150.10242@waterleaf.sonytel.be>
 <Pine.GSO.4.58.0407111226350.3963@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Jul 2004, Geert Uytterhoeven wrote:
> 
> But why does sparse complain about
> 
>     p->thread.fs = get_fs().seg;

Sparse bug. Hey, it's not perfect, and this case is actually very easy to 
just parse, but harder to build a nice internal representation of it.

In particular, sparse internally really _should_ re-write the above as

	fnret = get_fs();
	p->thread.fs = fnret.seg;

since that is what would happen in real life, but since it never came up
in early testing, I didn't ever really get around to doing it that way.  
Oh, well.

So please don't take _all_ sparse warnings too seriously. Some of them 
literally are still due to sparse limitations. I'm happy to say that they 
are fairly few these days.

			Linus
