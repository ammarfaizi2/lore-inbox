Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRCWRDT>; Fri, 23 Mar 2001 12:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbRCWRDJ>; Fri, 23 Mar 2001 12:03:09 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:39428 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S131276AbRCWRDA>; Fri, 23 Mar 2001 12:03:00 -0500
Date: Fri, 23 Mar 2001 12:02:57 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.2-ac23 compile error on i686
Message-ID: <Pine.LNX.4.33.0103231149390.15152-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

2.4.2-ac23 doesn't compile in arch/i386/kernel/setup.c. Somebody has
changed CONFIG_TSC to CONFIG_X86_TSC, probably without testing the
resulting code.

CONFIG_TSC was never defined, so it was an error. However, what we have
now is that tsc_disable is declared if CONFIG_X86_TSC is not defined, but
is used if it is defined.

I think we should be a little more consistent here. Possible solutions:

1) "notsc" should be enabled in the kernels for old processors the the
case if they run on a better processor and the user may need to disable
TSC (ifndef CONFIG_X86_TSC everywhere in setup.c)

2) "notsc" should be enabled in the kernels for the new processors. It
would save few bytes in the kernels for i386, but the code for i686 will
function even if "notsc" is used (ifdef CONFIG_X86_TSC everywhere in
setup.c)

3) Remove all those silly if[n]defs. We have the "cpu_has_tsc"  variable
on all platforms. clear_bit() and set_in_cr4() are already used on all
processors. It should be safe.

Regards,
Pavel Roskin

