Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKXM63>; Fri, 24 Nov 2000 07:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129145AbQKXM6U>; Fri, 24 Nov 2000 07:58:20 -0500
Received: from [209.249.10.20] ([209.249.10.20]:39083 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S129091AbQKXM6J>; Fri, 24 Nov 2000 07:58:09 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 24 Nov 2000 04:28:08 -0800
Message-Id: <200011241228.EAA28061@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: RFC: Security fix for demand loading of filesystem and network interface modules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I want to slightly change the way filesystems and network
drivers are demand loaded via request_module.

	Currently, querying a nonexistant network interface named,
say, "eth0" results in a result_module call for "eth0".  I want
to change that to "if-eth0".  This will make it impossible for
users to pass things like "-C/my/bogus/modules.config", or to
cause the loading of legitimate but buggy module to crash the
system.  The changes to modutils that Keith Owens posted address the
former problem, but not the latter, which is a pretty real possibility
given that our current builds install 786 modules.  This renaming
is also useful because it will make it possible to make generic
rules for modprobe that handle names that are unrecognized but are
know to be a networking interface (for example, "if-funkylan0" might load
all relevant modules that have PCI or USB class information indicating
that they are network interfaces and which correspond to hardware that
is present).

	Likewise, I want to change request_module calls that load
file system modules (in fs/supser.c and fs/fat/cvf.c) to prefix
them with "fs-".

	Of course these changes will add string length checking.

	Comments?  Are the "fs-" and "if-" prefixes OK?  (There
are currently no real modules that have names beginning with those
strings.)

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
