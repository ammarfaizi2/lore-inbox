Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbTHVTBI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 15:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTHVTBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 15:01:08 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:6507 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S263312AbTHVTBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 15:01:05 -0400
Date: Fri, 22 Aug 2003 20:02:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: "David S. Miller" <davem@redhat.com>, <willy@debian.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, <drepper@redhat.com>
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
    tst-mmap-eofsync in glibc on parisc)
In-Reply-To: <1061577688.2090.285.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0308221954570.2256-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Aug 2003, James Bottomley wrote:
> On Fri, 2003-08-22 at 13:34, Hugh Dickins wrote:
> > Might the problem be in parisc's __flush_dcache_page,
> > which only examines i_mmap_shared?
> 
> This is the issue: we do treat them differently.
> 
> Semantics differ between privately mapped data (where there's no
> coherency guarantee) and shared data (where there is).  Flushing the
> virtual cache is expensive on pa, so we only do it for the i_mmap_shared
> list.
> 
> The difficulty is that a mmap of a read only file with MAP_SHARED is
> expecting the shared cache semantics, but gets added to the non shared
> list.
> 
> Since flushing the caches is a performance hog, we'd like do be able to
> distinguish the cases where we have to do the flush MAP_SHARED mappings
> from those we don't (MAP_PRIVATE).

The naming "i_mmap_shared" does suggest that once upon a time those
lists were as you'd like; and that at some point it was changed.

Perhaps some arches prefer the coherency guarantee I'm familiar with
in MAP_PRIVATE (yes, when you modify a page yourself, it cows off and
becomes private; but in i386 it's shared up until then), and other
arches (like yours) would prefer to avoid the overhead.

Hugh

