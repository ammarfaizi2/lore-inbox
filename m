Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWADT7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWADT7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbWADT6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:58:10 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:55015 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965284AbWADT5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:37 -0500
Message-Id: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:20 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>
Subject: [PATCH 00/13] spufs fixes and cleanups
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a review almost a month ago, Al Viro found numerous
problems in the current spufs code. I now finally found
some time to go through those and attempt to fix them.

There are also a few other changes in this series that
should also help, in particular improved interrupt
sending and an abstraction for priviledged register
access (as suggested by  Masato Noguchi and Geoff Levand).

Please apply to powerpc.git before sending spufs upstream.

Al, could you have a look over this to see if it addresses
all the concerns you had and if I broke it in new ways?

	Arnd <><

 arch/powerpc/platforms/cell/Makefile         |    5
 arch/powerpc/platforms/cell/interrupt.c      |   42 ++--
 arch/powerpc/platforms/cell/interrupt.h      |    1
 arch/powerpc/platforms/cell/spu_base.c       |   67 +++----
 arch/powerpc/platforms/cell/spu_priv1.c      |  133 ++++++++++++++
 arch/powerpc/platforms/cell/spufs/Makefile   |    2
 arch/powerpc/platforms/cell/spufs/file.c     |  167 +----------------
 arch/powerpc/platforms/cell/spufs/hw_ops.c   |   19 --
 arch/powerpc/platforms/cell/spufs/inode.c    |  156 ++++++++-------
 arch/powerpc/platforms/cell/spufs/run.c      |  131 ++++++++++++++
 arch/powerpc/platforms/cell/spufs/sched.c    |   13 +
 arch/powerpc/platforms/cell/spufs/spufs.h    |   35 +++
 arch/powerpc/platforms/cell/spufs/switch.c   |  139 +++++----------
 arch/powerpc/platforms/cell/spufs/syscalls.c |    5
 arch/powerpc/platforms/cell/spufs/context.c  |   11 -
 include/asm-powerpc/spu.h                    |   42 +++-
  20 files changed, 565 insertions(+), 407 deletions(-)


