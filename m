Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVH2R46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVH2R46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVH2R46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:56:58 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:11169 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751246AbVH2R4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:56:54 -0400
Date: Mon, 29 Aug 2005 19:56:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 8/10] s390: compat system calls.
Message-ID: <20050829175649.GH6796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 8/10] s390: compat system calls.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Use TIF bit to tell if a process is running in 31 bit mode instead of
checking the addressing mode bits of the PSW.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/entry64.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2005-08-29 19:18:06.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2005-08-29 19:18:11.000000000 +0200
@@ -214,8 +214,8 @@ sysc_nr_ok:
 sysc_do_restart:
 	larl    %r10,sys_call_table
 #ifdef CONFIG_S390_SUPPORT
-        tm      SP_PSW+3(%r15),0x01  # are we running in 31 bit mode ?
-        jo      sysc_noemu
+	tm	__TI_flags+5(%r9),(_TIF_31BIT>>16)  # running in 31 bit mode ?
+	jno	sysc_noemu
 	larl    %r10,sys_call_table_emu  # use 31 bit emulation system calls
 sysc_noemu:
 #endif
