Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbTGORXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269148AbTGORXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:23:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3289 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269144AbTGORXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:23:19 -0400
Date: Tue, 15 Jul 2003 10:36:08 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Carl Thompson <cet@carlthompson.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems compiling modules outside of tree in 2.6.0test1
Message-Id: <20030715103608.38bf17f8.rddunlap@osdl.org>
In-Reply-To: <1058251587.eec14da73ec3b@carlthompson.net>
References: <1058251587.eec14da73ec3b@carlthompson.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 23:46:27 -0700 Carl Thompson <cet@carlthompson.net> wrote:

| [This problem still exists in Linux 2.6.0test1]
| 
| I am not on the kernel mailing list so please CC with any responses.  I am
| new to this kernel / module stuff so if I am doing something obviously
| wrong please correct me gently!
| 
| Hello,
| 
|      I have noticed a problem when compiling kernel modules outside of the
| kernel tree for 2.5(.75).  I am compiling a 3rd party network module for
| 2.5 and it needs to include "linux/netdevice.h" .  This file includes a
| bunch of other kernel headers which in turn include more kernel headers.
| This eventually gets to "asm/irq.h" and on my architechture (i386) this
| file has the line
| 
|    #include "irq_vectors.h"
| 
|      The problem is that this "irq_vectors.h" file is not found in the same
| directory as "irq.h" but in a different directory that is explicitly added
| to the include path for the kernel in "arch/i386/Makefile" .   This is just
| fine for kernel compiles using the kernel makefiles, but for stuff outside
| of the tree it means that "irq_vectors.h" won't be found.  A solution would
| be to to duplicate the relevant sections of the kernel's architecture
| specific makefile stuff to calculate and add the include path myself, but
| this seems unclean and would require me to add more architecture specific
| voodoo for each architecture to be supported.
| 
|      I believe the proper solution would be for the kernel build system to
| create a symbolic link to "irq_vectors.h" in "asm-i386/" just as "asm/"
| itself is a symbolic link to "asm-i386/" instead of adding an include path
| in the architecture specific makefile that breaks out-of-tree compiles.

Are you using the expected style of Makefile?
See linux/Documentation/modules.txt and
linux/Documentation/kbuild/makefiles.txt .

For a outside-the-kernel-tree module that I just built, I don't
have this problem.  I modified this external module to printk()
the value of NR_IRQS (from irq_vectors.h) with no problems.

Here is my Makefile:
# makefile for oops_test/dump*.c
# Randy Dunlap, 2003-03-12
# usage:
# cd /path/to/kernel/source && make SUBDIRS=/path/to/source/oops_test/ modules

CONFIG_OOPS_TEST=m

obj-m := dump_test.o

# dump_test-objs := dump_test.o

clean-files := *.o

# fini;



--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
