Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTJDBr1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 21:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbTJDBr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 21:47:27 -0400
Received: from office.itanets.com ([193.200.14.52]:14990 "EHLO
	office.itanets.com") by vger.kernel.org with ESMTP id S261699AbTJDBrY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 21:47:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Delian Krustev <krustev@krustev.net>
To: linux-kernel@vger.kernel.org
Subject: permissions inside linux-2.6.0-test6.tar.bz2
Date: Sat, 4 Oct 2003 04:47:02 +0300
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200310040447.04808.krustev@krustev.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First excuse me if this has already been posted but a quick search
showed me it hadn't. The problem is trivial and it should have been
resolved if it has been reported.

Here it is:

# tar xjf linux-2.6.0-test6.tar.bz2
# find . -not -perm -444 -exec ls -al "{}" \;
-rw-r-----    1 1046     1046        27217 Sep 28 03:51
./linux-2.6.0-test6/drivers/net/arm/ether00.c
-rw-r-----    1 1046     1046        13235 Sep 28 03:51
./linux-2.6.0-test6/drivers/char/agp/isoch.c
-rw-r-----    1 1046     1046        17188 Sep 28 03:51
./linux-2.6.0-test6/drivers/input/joystick/grip_mp.c
-rw-r-----    1 1046     1046         1992 Sep 28 03:50
./linux-2.6.0-test6/arch/arm/mach-integrator/lm.c
-rw-r-----    1 1046     1046         5363 Sep 28 03:50
./linux-2.6.0-test6/arch/arm/mach-integrator/impd1.c
-rw-r-----    1 1046     1046          422 Sep 28 03:50
./linux-2.6.0-test6/arch/arm/mach-integrator/Kconfig
-rw-r-----    1 1046     1046          698 Sep 28 03:50
./linux-2.6.0-test6/arch/arm/common/platform.c
-rw-r-----    1 1046     1046         6062 Sep 28 03:50
./linux-2.6.0-test6/arch/arm/common/amba.c
-rw-r-----    1 1046     1046         3352 Sep 28 03:51
./linux-2.6.0-test6/arch/arm/common/icst525.c
-rw-r-----    1 1046     1046         8717 Sep 28 03:50
./linux-2.6.0-test6/arch/arm/mm/Kconfig
-rw-r-----    1 1046     1046        11559 Sep 28 03:50
./linux-2.6.0-test6/arch/arm/mm/proc-arm1026.S
-rw-r-----    1 1046     1046        12538 Sep 28 03:50
./linux-2.6.0-test6/arch/arm/mm/proc-arm1020e.S
-rw-r-----    1 1046     1046        11806 Sep 28 03:51
./linux-2.6.0-test6/arch/arm/mm/proc-arm1022.S
-rw-r-----    1 1046     1046         1091 Sep 28 03:51
./linux-2.6.0-test6/arch/arm/mm/mmu.c
-rw-r-----    1 1046     1046          581 Sep 28 03:50
./linux-2.6.0-test6/include/asm-arm/arch-integrator/lm.h
-rw-r-----    1 1046     1046          512 Sep 28 03:50
./linux-2.6.0-test6/include/asm-arm/arch-integrator/impd1.h
-rw-r-----    1 1046     1046          350 Sep 28 03:50
./linux-2.6.0-test6/include/asm-arm/traps.h
-rw-r-----    1 1046     1046         1152 Sep 28 03:50
./linux-2.6.0-test6/include/asm-arm/hardware/icst525.h
-rw-r-----    1 1046     1046         1179 Sep 28 03:50
./linux-2.6.0-test6/include/asm-arm/hardware/amba.h
-rw-r-----    1 1046     1046           34 Sep 28 03:50
./linux-2.6.0-test6/include/asm-arm/sections.h
-rw-r-----    1 1046     1046         5926 Sep 28 03:50
./linux-2.6.0-test6/include/video/neomagic.h
-rw-r-----    1 1046     1046         1593 Sep 28 03:51
./linux-2.6.0-test6/Documentation/scsi/ChangeLog.megaraid


So, these files are not world readable as they should be.
I bumped into this while trying to compile the kernel from user.
Anyone trying to do so and trying to use one of these files is
affected.
It's really a matter of running chmod -R but there might be some cases
where this is not possible.

One more thing I want to recommend. Please use the tar options
--owner 0 --group 0 when creating the archive. The uid/gid 1046
combination might already be present on the system(or appear in
the future) and might bring security risks for the unwary.

Regards
Delian Krustev
