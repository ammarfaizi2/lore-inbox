Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbUCASRy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 13:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbUCASRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 13:17:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:51671 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261392AbUCASRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 13:17:50 -0500
Date: Mon, 1 Mar 2004 10:17:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kliment Yanev <Kliment.Yanev@helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
Message-Id: <20040301101706.3a606d35.rddunlap@osdl.org>
In-Reply-To: <40419A1C.5070103@helsinki.fi>
References: <40408852.8040608@helsinki.fi>
	<20040228104105.5a699d32.rddunlap@osdl.org>
	<40419A1C.5070103@helsinki.fi>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004 09:51:56 +0200 Kliment Yanev wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| 
| 
| Randy.Dunlap wrote:
| | All those errors should go away if you build the module correctly.
| | Please read Documentation/kbuild/m*.txt or see LWN.net article
| | on building modules:
| |   http://lwn.net/Articles/21823/
| 
| Okay, using a kbuild makefile I still get tons of errors, though most of
| the original ones are gone:
| 
| make -C /lib/modules/2.6.3-rc2-mm1/build
| SUBDIRS=/home/kliment/Desktop/nokia_c110/src modules
| make[1]: Entering directory `/usr/src/linux-2.6.3-rc2-mm1'
| *** Warning: Overriding SUBDIRS on the command line can cause
| ***          inconsistencies
| make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
| ~  CHK     include/asm-i386/asm_offsets.h
| ~  CC [M]  /home/kliment/Desktop/nokia_c110/src/dmodule.o
| In file included from /home/kliment/Desktop/nokia_c110/src/nokia_info.h:89,
| ~                 from /home/kliment/Desktop/nokia_c110/src/dmodule.c:35:
| /home/kliment/Desktop/nokia_c110/src/nokia_priv.h:43:1: warning: "HZ"
| redefined

This shouldn't define HZ -- or make it conditional.

| In file included from include/linux/sched.h:4,
| ~                 from include/linux/module.h:10,
| ~                 from /home/kliment/Desktop/nokia_c110/src/nokia_info.h:42,
| ~                 from /home/kliment/Desktop/nokia_c110/src/dmodule.c:35:
| include/asm/param.h:5:1: warning: this is the location of the previous
| definition
| /home/kliment/Desktop/nokia_c110/src/dmodule.c:57: warning: static
| declaration for `cs_error' follows non-static

'cs_error' is a function in the kernel.  Rename this local one.

| /home/kliment/Desktop/nokia_c110/src/dmodule.c: In function `cs_error':
| /home/kliment/Desktop/nokia_c110/src/dmodule.c:61: warning: implicit
| declaration of function `CardServices'
| /home/kliment/Desktop/nokia_c110/src/dmodule.c: In function `d_init_module':
| /home/kliment/Desktop/nokia_c110/src/dmodule.c:115: warning: implicit
| declaration of function `register_pcmcia_driver'
| /home/kliment/Desktop/nokia_c110/src/dmodule.c: In function
| `d_cleanup_module':
| /home/kliment/Desktop/nokia_c110/src/dmodule.c:124: warning: implicit
| declaration of function `unregister_pccard_driver'
| /home/kliment/Desktop/nokia_c110/src/dmodule.c: In function
| `d_driver_attach':
| /home/kliment/Desktop/nokia_c110/src/dmodule.c:182: error: structure has
| no member named `release'
| /home/kliment/Desktop/nokia_c110/src/dmodule.c:183: error: structure has
| no member named `release'
| /home/kliment/Desktop/nokia_c110/src/dmodule.c: In function
| `d_driver_event':
| /home/kliment/Desktop/nokia_c110/src/dmodule.c:401: error: structure has
| no member named `release'
| /home/kliment/Desktop/nokia_c110/src/dmodule.c:402: error: structure has
| no member named `release'
| /home/kliment/Desktop/nokia_c110/src/dmodule.c:407: error: structure has
| no member named `bus'
| make[2]: *** [/home/kliment/Desktop/nokia_c110/src/dmodule.o] Error 1
| make[1]: *** [/home/kliment/Desktop/nokia_c110/src] Error 2
| make[1]: Leaving directory `/usr/src/linux-2.6.3-rc2-mm1'
| make: *** [default] Error 2
| 
| 
| Other than the param.h error, all the errors related to kernel headers
| are gone now. Thank you for the suggestion. However, what do I do next?
| I got the pci-pcmcia converter working btw. It needed its base address
| entered manually as well as irq scanning disabled and it would hang the
| machine otherwise...Therefore I can test this now if it compiles.

All of the kernel interface functions to PCMCIA Card Services have
changed in 2.6 so quite a bit of code will have to be changed here.
You can ask Nokia for a 2.6 update since it is now released, or
you can ask for help from the linux-wlan (or wlan-ng) project people,
or you can compare a 2.4 PCMCIA kernel driver to a 2.6 PCMCIA kernel
driver to see what changes are required.

--
~Randy
