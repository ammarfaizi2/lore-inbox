Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266806AbUHCTC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266806AbUHCTC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 15:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUHCTC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 15:02:26 -0400
Received: from aun.it.uu.se ([130.238.12.36]:46292 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266807AbUHCTCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 15:02:25 -0400
Date: Tue, 3 Aug 2004 21:02:22 +0200 (MEST)
Message-Id: <200408031902.i73J2MNx000087@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: updated gcc-3.4 patches for 2.4.27-rc4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend. 1st post seems to have gone into a /dev/null somewhere.]

The gcc-3.4 patches for the 2.4.27-rc4 kernel have been updated:
http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc34-fastcall-fixes-2.4.27-rc4
http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc34-lvalue-fixes-2.4.27-rc4
http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc34-misc-fixes-2.4.27-rc4
Download and apply all three of them.

After a careful review of all patches, the following changes were made:
- i386' smp_send_reschedule() now has proper fastcall declarations.
  The previous patches removed the FASTCALL from <linux/smp.h>,
  but the new patches instead preserve the behaviour from gcc < 3.4.
- Several functions had their fastcall annotations moved around a
  little to match exactly their 2.6.8-rc2 versions.
- A few void* casts used for cast-as-lvalue fixes were reformatted
  to match exactly their 2.6.8-rc2 versions.
- Cleaned up the cast-as-lvalue fix in
  arch/x86_64/ia32/ia32_ioctl.c:blkpg_ioctl_trans().

The cast-as-lvalue fixes for kernel/sysctl.c result in code doing
pointer arithmetic on void* values. There has been some discussion
about replacing those with char* values. I decided against that
because (1) the diff became larger, and (2) the functions in sysctl.c
already do void* pointer arithmetic, and there is no strong reason
for eliminating that (ab)use in the 2.4 kernel.

The cast-as-lvalue fixes are also needed to silence warnings from
gcc-3.3.4.

/Mikael
