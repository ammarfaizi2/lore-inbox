Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUG0Uef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUG0Uef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266614AbUG0Uef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:34:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:40114 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266613AbUG0UeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:34:20 -0400
Date: Tue, 27 Jul 2004 13:14:15 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: geert@linux-m68k.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Kconfig.debug: combine Kconfig debug options
Message-Id: <20040727131415.51260cca.rddunlap@osdl.org>
In-Reply-To: <20040727190210.GE20740@linux-sh.org>
References: <20040723231158.068d4685.rddunlap@osdl.org>
	<Pine.GSO.4.58.0407271451130.19529@waterleaf.sonytel.be>
	<20040727104737.0de2da5b.rddunlap@osdl.org>
	<20040727190210.GE20740@linux-sh.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 15:02:11 -0400 Paul Mundt wrote:

| On Tue, Jul 27, 2004 at 10:47:37AM -0700, Randy.Dunlap wrote:
| > DEBUG_SLAB is not available in cris, h8300, m68knommu, sh, sh64,
| > or v850 AFAICT.  Yes/no ?
| > 
| This can be set for sh/sh64 just fine, it is pretty much generic anyways.
| So placing this in a common Kconfig seems reasonable.

Changed that, thanks.

| > | (didn't check the whole list) Perhaps the first instance of DEBUG_INFO
| > | can depend on !SUPERH64 && !USERMODE only?
| > 
| > It could.  It depends on one's config (or code/patch) philosophy.
| > I was trying to be explicit about which arches support a config option
| > by including each arch in a list ("inclusion").  Or I could exclude
| > certain arches from config options ("exclusion").  The inclusion
| > method seems safer and more readable/maintainable to me, but that's
| > just one opinion.
| > 
| There's no need for the !SUPERH64 dependancy for DEBUG_INFO either, so
| feel free to drop that if that's the way you end up going.

Changed that one also.

Along with 3 changes in response to Geert:
- DEBUG_KERNEL applies to all arch-es;
- DEBUG_SPINLOCK depends only on DEBUG_KERNEL && SMP;
- DEBUG_HIGHMEM depends only on DEBUG_KERNEL && HIGHMEM;

Updated patch (applies to 2.6.8-rc2-bk6) is now available at
  http://developer.osdl.org/rddunlap/kconfig/kconfig-debug-268rc2bk6.patch

(approx. 133 KB)

---

Localize Kconfig debug options into one file (lib/Kconfig.debug)
for easier maintenance and searching.


Summary of changes:

. localizes the following symbols in lib/Kconfig.debug:
    DEBUG_KERNEL, MAGIC_SYSRQ, DEBUG_SLAB, DEBUG_SPINLOCK,
    DEBUG_SPINLOCK_SLEEP, DEBUG_HIGHMEM, DEBUG_BUGVERBOSE,
    DEBUG_INFO
  and FRAME_POINTER for some instances of it (if it's freely
  user-selectable) but not for the cases where it's forced or
  it depends on some other options.
. adds DEBUG_KERNEL requirement to some DEBUG_vars;
. DEBUG_KERNEL applies to all arch-es;
. remove KALLSYMS from S390-specific kernel hacking menu;
  use KALLSYMS in the EMBEDDED menu instead;
. add CRIS and M68KNOMMU symbols for use in lib/Kconfig.debug;
. eliminate duplicate "General setup" labels in sparc64 config;
. whitespace cleanup;
. fixed a few trival typos;


Portions of the original patch were also done by
Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
--
