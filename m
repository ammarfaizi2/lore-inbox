Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281746AbRKQM7s>; Sat, 17 Nov 2001 07:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281745AbRKQM7j>; Sat, 17 Nov 2001 07:59:39 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:17281 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S281744AbRKQM7Z>; Sat, 17 Nov 2001 07:59:25 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 17 Nov 2001 04:59:21 -0800
Message-Id: <200111171259.EAA08496@adam.yggdrasil.com>
To: andre@linux-ide.org
Subject: Notes on ATA/133 patch (ide.2.4.14.11062001.patch)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andre,

	Thank you very much for implementing the 48-bit ATA controller
support in your recent IDE kernel patches (ide.2.4.14.11062001.patch).
I am using a Maxtor 160GB hard disk with your patches on linux-2.4.15-pre5,
and it seems to be working well so far (two hours).

	I do have a couple of minor notes about your patch.  I could
generate some diffs, but they're simple and I'm not completely sure
about the right solution.

	1. Your patch creates a circular dependency between the ide-mod.o
and ide-probe-mod.o modules, which is only noticible when IDE support
is compiled as a module.  The problem is that ide.c has the
EXPORT_SYMBOL declarations for export_ide_init_queue and
export_probe_for_drive in ide-probe.c.  At the moment, I have
moved the two EXPORT_SYMBOL declarations to the ide-probe.c, but I
believe the correct solution is just to remove the two routines
from your patch, since it appears that nothing uses them yet.

	2. A while ago, I posted a change that modularizes partition
support (in reality, I never use the kernel-based partition code, but
that's another matter).  Your declaration of ide_xlate_1024_hook to
fs/partitions/msdos.c creates a circular dependency in my kernel (but
not in Linus's), which I fixed by moving the declatation to
fs/partitions/check.c.  I do not yet understand the purpose of
ide_xlate_1024 to understand whether it really is specific to the
MSDOS style of partition labeling.

	Anyhow, I hope this information is helpful.  Please let me know
if you want me to geneate a patch or test anything.  So far, your patch
seems to be working very well.  Thank you very much for developing it.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
