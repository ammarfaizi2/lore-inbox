Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbSKAIV2>; Fri, 1 Nov 2002 03:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265662AbSKAIV2>; Fri, 1 Nov 2002 03:21:28 -0500
Received: from dp.samba.org ([66.70.73.150]:10724 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265661AbSKAIVZ>;
	Fri, 1 Nov 2002 03:21:25 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Subject: [RELEASE] More modules fun!
Date: Fri, 01 Nov 2002 19:06:57 +1100
Message-Id: <20021101082753.D3D922C0CD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, the basic patch has been running stress_modules.sh for hours on my
dual box.  This is the newer, friendlier more-backwards-compatible
module rewrite.

You'll want the replacement modutils as well (don't worry, moves the
old ones to .old and calls them if you're running an older kernel, so
you can leave them installed):
	http://www.kernel.org/pub/linux/kernel/people/rusty/module-init-tools-0.6.tar.gz

Minimal: (x86 only, no param support, v. well tested on .45):
	http://www.kernel.org/pub/linux/kernel/people/rusty/patches/module-x86-31-10-2002.2.5.45.diff.gz

Supreme: (other archs untested, param support etc, untested on .45):
	http://www.kernel.org/pub/linux/kernel/people/rusty/patches/module-all-31-10-2002.2.5.45.diff.gz

Breakdown of patches is on my www.kernel.org page:
	"x86" is just core and x86 support patches,
	"all" is all patches up to and including the "documentation" patch,

Bug reports welcome,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

>From the main patch documentation:

D: This is an implementation of the in-kernel module loader extending
D: the try_inc_mod_count() primitive and making its use compulsory.
D: This has the benifit of simplicity, and similarity to the existing
D: scheme.  To reduce the cost of the constant increments and
D: decrements, reference counters are lockless and per-cpu.
D:
D: Eliminated (coming in following patches):
D: o Modversions
D: o Module parameters
D: o kallsyms
D: o EXPORT_SYMBOL_GPL and MODULE_LICENCE checks
D: o DEVICE_TABLE support.
D:
D: New features:
D: o Typesafe symbol_get/symbol_put
D: o Single "insert this module" syscall interface allows trivial userspace.
D: o Raceless loading and unloading
D:
D: You will need the trivial replacement module utilities from:
D: http://www.kernel.org/pub/linux/people/rusty/module-init-tools-0.6.tar.gz
