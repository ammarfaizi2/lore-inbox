Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288949AbSAFNik>; Sun, 6 Jan 2002 08:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288950AbSAFNib>; Sun, 6 Jan 2002 08:38:31 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:55817 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288949AbSAFNiS>;
	Sun, 6 Jan 2002 08:38:18 -0500
Date: Mon, 7 Jan 2002 00:33:26 +1100
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove 8 bytes from struct page on 64bit archs
Message-ID: <20020106133326.GD30292@krispykreme>
In-Reply-To: <20020106123913.GA5407@krispykreme> <20020106051134.E10391@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020106051134.E10391@holomorphy.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi Bill,

> Very true. I devised something to address this that appears to work on
> multiple architectures already by folding ->zone into ->flags, which
> could be useful. (Dave Jones recommended I just let arch maintainers
> for things other than i386 mess with page_address() for other arches.)
> OTOH, I'm more interested in getting it trimmed down than getting credit.

For archs that need ->zone, merging it with ->flags sounds like a
great idea. Id like to cram something into ->flags on 64 bit archs
since its only a long due to bitop constraints. I had thought of
stuffing ->count in the high word but now Im just getting silly
since all non atomic accesses to ->flags would then have to be word
ones.

> My i386 version, which makes ->virtual conditional on CONFIG_HIGHMEM as
> well, is at:

Id like to do redo some profiling, on ppc64 we had page_address() doing
pointer arithmetic (instead of page->virtual) and the compiler created
an awful sequence of instructions in the acenic interrupt handler.
A zero copy TCP benchmark made it rather obvious.

Anton
