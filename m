Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbSKLWdr>; Tue, 12 Nov 2002 17:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbSKLWdr>; Tue, 12 Nov 2002 17:33:47 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:24546 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266994AbSKLWdo>; Tue, 12 Nov 2002 17:33:44 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 13 Nov 2002 09:40:28 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15825.33628.787612.506995@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: PATCH - avoid 'defined but not used' warning in xor.h on i386
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This causes i386 to test the speed of the new prefetching generic
xor_block functions ... which turn out to be even slower than
the non-prefetch version on my P4-Xeon


 ----------- Diffstat output ------------
 include/asm-i386/xor.h |    2 ++
 1 files changed, 2 insertions(+)

diff include/asm-i386/xor.h~current~ include/asm-i386/xor.h
--- include/asm-i386/xor.h~current~	2002-11-12 15:42:25.000000000 +1100
+++ include/asm-i386/xor.h	2002-11-12 15:42:25.000000000 +1100
@@ -868,7 +868,9 @@ static struct xor_block_template xor_blo
 #define XOR_TRY_TEMPLATES				\
 	do {						\
 		xor_speed(&xor_block_8regs);		\
+		xor_speed(&xor_block_8regs_p);		\
 		xor_speed(&xor_block_32regs);		\
+		xor_speed(&xor_block_32regs_p);		\
 	        if (cpu_has_xmm)			\
 			xor_speed(&xor_block_pIII_sse);	\
 	        if (cpu_has_mmx) {			\
