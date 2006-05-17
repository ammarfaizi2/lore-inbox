Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWEQGZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWEQGZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 02:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWEQGZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 02:25:14 -0400
Received: from ws9.cdotb.ernet.in ([202.41.72.121]:18384 "EHLO
	ws9.cdotb.ernet.in") by vger.kernel.org with ESMTP id S932433AbWEQGZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 02:25:13 -0400
From: "Vijayalakshmi Hadimani" <vijaya_h@cdotb.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: frequency at which kill_fasync can be called
Date: Wed, 17 May 2006 23:24:54 +0630
Message-Id: <20060517164203.M21196@universe.cdotb.ernet.in>
X-Mailer: Open WebMail 2.41 20040926
X-OriginatingIP: 192.168.12.173 (vijaya_h)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

   I need a timer of resolution 5ms in my linux application. I have used 
the timer device and registered using fasync_helper. I use the timer
provided by the processor. I handle the timer interrupt s at the rate of 1 ms.
When the application starts the timer for 1hr, the kernel crashes and I on the
stack the following dump is present:

Oops: kernel access of bad area, sig: 11
Oops: kernel access of bad area, sig: 11
NIP: C0812B14 XER: 00000000 LR: C08129E0 SP: C1FC3BF0 REGS: c1fc3b40 TRAP:
0300    Tainted: GF
MSR: 00809032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: FFFFFFF8, DSISR: 20000000
TASK = c1fc2000[346] 'timer-ppc-sigio' Last syscall: 178 
last math c1fc2000 last altivec 00000000
GPR00: 0000000C C1FC3BF0 C1FC2000 FFFFFFD4 00809032 C0998F40 00000001 C09993D8 
GPR08: C2442000 00000073 C09993DC 00080000 FFFFFFFF 10025004 00000000 7F7FFFFF 
GPR16: 7F7FF710 00000022 0FFD4258 00000000 00009032 01FC3E20 00008000 C08061CC 
GPR24: C080E6C4 00000000 00000000 00000001 00000001 00000000 C2442000 C1FC3BF0 
Call backtrace: 
C08129E0 C0813880 C08184B4 C08182C4 C08063EC C080EA2C C080E9D4 
C08061CC 7F7FFC00 C080A210 C0805EBC 0FEB6E0C 0FFD3ED0 10000ED8 
0FFD0C08 0FF52F7C 
Oops: kernel access of bad area, sig: 11
NIP: C0812B14 XER: 00000000 LR: C08129E0 SP: C1FC3750 REGS: c1fc36a0 TRAP:
0300    Tainted: GF
MSR: 00809032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: FFFFFFF8, DSISR: 20000000
TASK = c1fc2000[346] 'timer-ppc-sigio' Last syscall: 178 
last math c1fc2000 last altivec 00000000
GPR00: 0000000C C1FC3750 C1FC2000 FFFFFFD4 00809032 C0998F40 00000001 C09993D8 
GPR08: C1FC2000 00000073 C09993DC 00080000 44004082 10025004 00000000 7F7FFFFF 
GPR16: 7F7FF710 00000022 0FFD4258 00000000 00009032 000122D0 80000001 C08060EC 
GPR24: C1FC3990 C20EE860 00020001 00000005 00000001 00000000 C1FC2000 C1FC3750 
Call backtrace: 
C08129E0 C0812B90 C0823C04 C0823CDC C082424C C0851B38 C0851BEC 
C0851E2C C0851E74 D97B1520 C08072C8 C0807428 C08074A4 C08060EC 
C08063F4 C080EA2C C080E9D4 C08061CC C08129E0 C0813880 C08184B4 
C08182C4 C08063EC C080EA2C C080E9D4 C08061CC 7F7FFC00 C080A210 
C0805EBC 0FEB6E0C 0FFD3ED0 10000ED8 0FFD0C08 
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Can anybody help on this?

Thanks in advance
Vijayalakshmi

