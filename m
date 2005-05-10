Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVEJO4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVEJO4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 10:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVEJO4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 10:56:00 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:16468 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261664AbVEJOzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 10:55:46 -0400
Date: Tue, 10 May 2005 16:55:44 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: KC <kcc1967@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.x driver compiler options
Message-ID: <20050510145544.GA11302@harddisk-recovery.com>
References: <5eb4b0650505100108179ba1b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eb4b0650505100108179ba1b6@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 04:08:30PM +0800, KC wrote:
> Instead of using Linux kconfig build system, can someone tell me
> what's the compiler options used to build a device driver (.ko file) ?

That depends on the architecture (i386, x86_64, arm, ppc, etc.),
compiler version (gcc 3.3, 3.4, 4.0, etc.), and kernel configuration
(single CPU, SMP, preempt, regparms, etc.). Kbuild knows about all
those things.

> Or, how can I integrate kconfig with GNU tool chain (automake, autoconf ...)

Create a file Makefile.kbuild with the usual stuff kbuild needs (see
http://lwn.net/Articles/21823/ ). Then make an automake Makefile.am
file like this:

all:
	$(MAKE) -f ${srcdir}/Makefile.kbuild -C ${KERNEL_DIR} \
		M=${srcdir} O=${builddir} modules

Have configure.in AC_SUBST(KERNEL_DIR), and you should be set.
I haven't tested this, but I think it should work.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
