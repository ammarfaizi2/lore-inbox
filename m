Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266943AbSKUXwx>; Thu, 21 Nov 2002 18:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbSKUXww>; Thu, 21 Nov 2002 18:52:52 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:58067 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266943AbSKUXwv>; Thu, 21 Nov 2002 18:52:51 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 21 Nov 2002 15:59:47 -0800
Message-Id: <200211212359.PAA16061@adam.yggdrasil.com>
To: zippel@linux-m68k.org
Subject: Re: [RFC] module fs or how to not break everything at once
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here are some more comments on modfs or modules in general:

	4. Regarding what I said about leaving symbol tracking to
user space, I'd like to add a note about reliability.  It is not
necessary for rmmod to reliably remove symbols from these tables.
insmod can check for symbols that map to places that are no longer
allocated to modules and remove stale symbols before attempting to
load a new module.

	5. You should not need to do anything special in modfs
to support init sections.  That can be done by loading two separate
modules and then removing the one corresponding to an init section.

	6. For module_init functions, consider taking a pointer to
an array of init functions and a count.  That would be compatible
with the system for built-in kernel object files, so it would
eliminate a difference in linux/include/init.h.  You could also do
the same for module_exit functions.  This change would also
allow linking .o's together more or less arbitrarily into single
modules, which would allow loading of modules that have reference
loops among them.

	7. Instead of module parameters, consider just supporting
__setup() declarations used in kernel objects.  These would then
process a string that you'd pass.  insmod might want to prepend the
contents of /proc/cmdline to that string so that people could pass
command lines at the boot prompt even if the driver they wanted to
talk to were a module.  This change would eliminate another difference
between module and core kernel objects.  Ultimately, I would like
eliminate any compilation difference between kernel and module
objects.  This would allow deferring the decision about what should be
in modules and what should be in the kernel until link time.  Not only
would this slightly simplify the build process and modules' source
code, but it would also allow binary distributions for a wider
variety of uses.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
