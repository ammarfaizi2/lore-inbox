Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVBVJtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVBVJtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 04:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVBVJtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 04:49:11 -0500
Received: from math.ut.ee ([193.40.36.2]:36317 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261811AbVBVJtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 04:49:02 -0500
Date: Tue, 22 Feb 2005 11:48:31 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au
Subject: 2.4 compile errors in 32-bit sys_revcmsg fixes
Message-ID: <Pine.SOC.4.61.0502221140040.6097@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is todays 2.4.30-pre1+BK snapshot on a sparc64:

gcc -D__ASSEMBLY__ -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -m64 -mcpu=ultrasparc -Wa,--undeclared-regs -ansi  -c -o sys32.o sys32.S
gcc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs -finline-limit=100000   -nostdinc -iwithprefix include -DKBUILD_BASENAME=sys_sparc32  -c -o 
sys_sparc32.o sys_sparc32.c
sys_sparc32.c: In function `cmsg32_recvmsg_fixup':
sys_sparc32.c:2683: error: called object is not a function
make[1]: *** [sys_sparc32.o] Error 1

The lines in question are
if ((clen64 < CMSG_ALIGN(sizeof(*ucmsg)))
                  (clen64 > (orig_cmsg_len + wp - workbuf))) {

Is a "||" missing, or something else?

It appears the same lines are in most fixed architectures so probably 
more architectures don't compile.

-- 
Meelis Roos (mroos@linux.ee)
