Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133116AbRDLMhM>; Thu, 12 Apr 2001 08:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135173AbRDLMhE>; Thu, 12 Apr 2001 08:37:04 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:28909 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S133117AbRDLMgv>; Thu, 12 Apr 2001 08:36:51 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 12 Apr 2001 05:36:49 -0700
Message-Id: <200104121236.FAA03613@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: List of all-zero .data variables in linux-2.4.3 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	For anyone who is interested, I have produced a list of all
of the .data variables that contain all zeroes and could be moved to
.bss within the kernel and all of the modules (all of the modules
that we build at Yggdrasil for x86, which is almost all).  These
are global or static variables that have been declared

	int foo = 0;

instead of

	int foo;	/* = 0 */

	The result is that the .o files are bigger than they have
to be.  The kernel memory image is not bigger, and gzip shrinks the
runs of zeroes down to almost nothing, so it does not have a huge effect
on bootable disks.  Still, it would be nice to save the disk space of
the approximately 75 kilobytes of zeroes and perhaps squeeze in another
sector or two when building boot floppies.

	I have also included a copy of the program that I wrote to
find these all-zero .data variables.

	The program and the output are FTPable from
ftp://ftp.yggdrasil.com/private/adam/linux/zerovars/.  Files with no
all-zero .data variables are not included in the listing.  If you maintain
any code in the kernel, you might want to look at the output to see
how your code stacks up.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
