Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129492AbQKFBQu>; Sun, 5 Nov 2000 20:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129515AbQKFBQk>; Sun, 5 Nov 2000 20:16:40 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:28713 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129492AbQKFBQ1>; Sun, 5 Nov 2000 20:16:27 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.0-test10-pre6 remove get_module_symbol MTD/DRM/AGP
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 12:16:12 +1100
Message-ID: <2214.973473372@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The get_module_symbol and put_module_symbol functions do not work when
the kernel is compiled with CONFIG_MODVERSIONS.  They are a third
mechanism for modules to pass data to each other, the other two are
exported symbols which are resolved at insmod time or via registration
functions.

Because xxx_module_symbol does not work with CONFIG_MODVERSIONS, is
only used by two areas of code (MTD and DRM/AGP) and because Linus
thinks there are no good uses for get_module_symbol[*], this patch
replaces xxx_module_symbol with inter_module registration routines.

[*] http://www.uwsg.indiana.edu/hypermail/linux/kernel/0010.2/0502.html

These routines should only be used for small amounts of data between
two objects.  If you need to pass data between more than two objects
then you should seriously think about coding specific registration
functions for those objects instead of overloading generic functions.
The only reason these functions exist is to avoid bloating the kernel
with individual registration functions just for a couple of objects.

The patch hits module.[ch], I already had several outstanding bug fixes
and IA64 module support in my tree, waiting for the code freeze to be
lifted.  Since module.[ch] was being hit anyway, I flushed most of my
patch list as part of this patch, these changes are already working in
the IA64 port.

The patch is 66K unzipped, 14K zipped, a bit too big for l-k.  Get it
from ftp://ftp.ocs.com.au/pub/2.4.0-test10-pre6-module-symbol.gz.  It
fits 2.4.0-test10 with some offsets, although I have not tested the
patch on 2.4.0-test10.  MTD says it looks OK, no response from DRM/AGP
after a week, my testing shows it appears to work on DRM/AGP.

Any comments before it goes to Linus?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
