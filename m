Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266507AbUG0SMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266507AbUG0SMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUG0SMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:12:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:58540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266507AbUG0SIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:08:07 -0400
Date: Tue, 27 Jul 2004 10:47:37 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Kconfig.debug: combine Kconfig debug options
Message-Id: <20040727104737.0de2da5b.rddunlap@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0407271451130.19529@waterleaf.sonytel.be>
References: <20040723231158.068d4685.rddunlap@osdl.org>
	<Pine.GSO.4.58.0407271451130.19529@waterleaf.sonytel.be>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 14:55:39 +0200 (MEST) Geert Uytterhoeven wrote:

| On Fri, 23 Jul 2004, Randy.Dunlap wrote:
| > . localizes the following symbols in lib/Kconfig.debug:
| >     DEBUG_KERNEL, MAGIC_SYSRQ, DEBUG_SLAB, DEBUG_SPINLOCK,
| >     DEBUG_SPINLOCK_SLEEP, DEBUG_HIGHMEM, DEBUG_BUGVERBOSE,
| >     DEBUG_INFO
| 
| Which architecture does _not_ use DEBUG_KERNEL or DEBUG_SLAB? The list is quite
| long... Aren't these generic?

Looks like all of them use DEBUG_KERNEL.

DEBUG_SLAB is not available in cris, h8300, m68knommu, sh, sh64,
or v850 AFAICT.  Yes/no ?


| Perhaps DEBUG_SPINLOCK can depend on just SMP only? Or do people want
| to debug spinlock code on machines that don't have SMP?

Yes, sounds good, I'll change that.
| 
| Perhaps DEBUG_HIGHMEM can depend on just HIGHMEM only?

Yes, will change that one also.

| (didn't check the whole list) Perhaps the first instance of DEBUG_INFO
| can depend on !SUPERH64 && !USERMODE only?

It could.  It depends on one's config (or code/patch) philosophy.
I was trying to be explicit about which arches support a config option
by including each arch in a list ("inclusion").  Or I could exclude
certain arches from config options ("exclusion").  The inclusion
method seems safer and more readable/maintainable to me, but that's
just one opinion.

--
~Randy
