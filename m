Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266557AbUGKKy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266557AbUGKKy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUGKKy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:54:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55715 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266557AbUGKKyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:54:15 -0400
Date: Sun, 11 Jul 2004 11:54:13 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040711105413.GT12308@parcelfarce.linux.theplanet.co.uk>
References: <20040707122525.X1924@build.pdx.osdl.net> <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <20040707202746.1da0568b.davem@redhat.com> <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org> <buosmc3gix6.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org> <Pine.LNX.4.58.0407091313570.20635@scrub.home> <Pine.GSO.4.58.0407102126150.10242@waterleaf.sonytel.be> <Pine.GSO.4.58.0407111226350.3963@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0407111226350.3963@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 12:29:51PM +0200, Geert Uytterhoeven wrote:
> But why does sparse complain about
> 
>     p->thread.fs = get_fs().seg;
> 
> with
> 
>     linux-m68k-2.6.7/arch/m68k/kernel/process.c:265:23: warning: expected lvalue for member dereference
> 
> ? Looks valid to me?

It is valid and should be left alone.  sparse doesn't handle that area and
unless somebody feels heroic it will stay that way.

Note that there are very scary critters in that part of language - among
other things it contains such fun as arrays that can't be converted to
pointers in normal way, etc. (arrays that have no address, while we are
at it).
