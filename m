Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWGNIlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWGNIlh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 04:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWGNIlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 04:41:36 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:13934 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S932323AbWGNIlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 04:41:36 -0400
Date: Fri, 14 Jul 2006 10:39:19 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, bibo.mao@intel.com,
       Michael Grundy <grundym@us.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch -mm] s390: kprobes compile fix
Message-ID: <20060714083919.GA9561@osiris.boeblingen.de.ibm.com>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add missing flush_insn_slot define to let kprobes compile on s390.

Cc: bibo,mao <bibo.mao@intel.com>
Cc: Michael Grundy <grundym@us.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

ia64-kprobe-invalidate-icache-of-jump-buffer.patch breaks kprobes on s390
which comes with git-s390.patch.

 include/asm-s390/kprobes.h |    3 +++
 1 files changed, 3 insertions(+)

diff -purN a/include/asm-s390/kprobes.h b/include/asm-s390/kprobes.h
--- a/include/asm-s390/kprobes.h	2006-07-14 10:33:40.000000000 +0200
+++ b/include/asm-s390/kprobes.h	2006-07-14 10:28:48.000000000 +0200
@@ -96,6 +96,9 @@ void arch_remove_kprobe(struct kprobe *p
 void kretprobe_trampoline(void);
 int  is_prohibited_opcode(kprobe_opcode_t *instruction);
 void get_instruction_type(struct arch_specific_insn *ainsn);
+
+#define flush_insn_slot(p)	do { } while (0)
+
 #endif	/* _ASM_S390_KPROBES_H */
 
 #ifdef CONFIG_KPROBES
