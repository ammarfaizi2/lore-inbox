Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUDPSHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUDPSHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:07:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:4324 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263561AbUDPSHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:07:07 -0400
Date: Fri, 16 Apr 2004 11:01:49 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] use Kconfig.debug (v3-proposed) (was: Re: [PATCH] use
 Kconfig.debug (v2))
Message-Id: <20040416110149.3e353333.rddunlap@osdl.org>
In-Reply-To: <200404161042.21164@WOLK>
References: <20040415220338.3e351293.rddunlap@osdl.org>
	<200404161042.21164@WOLK>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004 10:42:21 +0200 Marc-Christian Petersen wrote:

| On Friday 16 April 2004 07:03, Randy.Dunlap wrote:
| 
| Hi Randy,
| 
| > Use generic lib/Kconfig.debug and arch-specific arch/*/Kconfig.debug.
| > Move KALLSYMS to generic debugging menu.
| > Changes from version 1:
| > 1.  remove global !CRIS && !H8300 from lib/Kconfig.debug;
| > 2.  for CRIS and H8300, don't source lib/Kconfig.debug (not used);
| > 3.  corrected several lib/Kconfig.debug ARCH usages;
| > 4.  small change in generic debug menu order (moved SPINLOCK
| > 	options together);
| > Ready for testing IMO.  More comments?
| 
| yes. I'd like to see it this way:
| 
| Changes from version 2:
| 1.  Early Printk should not depend on EMBEDDED
| 2.  change "if foobar" to "depend on"

These mean the same thing to the config software, so I don't
care which way it's done.

| 3.  remove endif's superfluous because of 2.
| 4.  Move KALLSYMS some places lower

Then let's move KALLSYMS to the very end of the menu.
At the very least it should be after the last "depends on
DEBUG_KERNEL" entry, but it still interferes with that
dependency chain as either of us has it.

| 5.  Add some more "depend on DEBUG_KERNEL" to indent the menu
| 6.  Remove trailing new lines in some arch specific Kconfig.debug
| 7.  move depends on DEBUG_KERNEL for arch/m68k/Kconfig.debug to
|     the menu so you only see that menu if you select DEBUG_KERNEL
|     You can't select anything there if DEBUG_KERNEL is N.

Maybe do the same for parisc and s390, so that they don't show up
at all?

sparc is the same way:  only entry(s) depend on DEBUG_KERNEL.
Same for x86_64.

However, I did it that way for "future-proofing".  Makes it
easy for someone to add an entry without having to think about
higher-level parameters/values etc.

| 8.  Whitespace cleanups
| 
| Comments?

Yes... and you?


| Everything else is fine with me.
| 
| All-in-One v3-proposed is here:
|  http://www.kernel.org/pub/linux/kernel/people/mcp/linux-2.6/kconf-debug-v3-proposed-2.6.6-rc1.patch
| 
| Update from v2 to v3-proposed is here too:
|  http://www.kernel.org/pub/linux/kernel/people/mcp/linux-2.6/kconf-debug-v2-to-v3-proposed-2.6.6-rc1.patch


Thanks,
--
~Randy
