Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbTEBTup (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 15:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbTEBTuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 15:50:44 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:38664 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S263139AbTEBTum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 15:50:42 -0400
Subject: inconsistant use of pid_t and patches
To: linux-kernel@vger.kernel.org
Date: Fri, 2 May 2003 22:03:05 +0200 (MEST)
Cc: danielebellucci@libero.it
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19BgkL-000Lzp-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,
we noticed that kernel_thread() returned diffent types. A quick
"grep -r kernel_thread() arch " will show pid_t, long and int
(for 2.4.20). So we started to clean up.
Everyone interessted can download the patches for 2.4.20 from
www.getenv.de/~walter
contact:
danielebellucci@libero.it

These are several patches. i dont want to bomb the ML so
no attachment to this mail.


As a first step we cleaned the definition in several architectures.
The changes are small as possible. Some architectures use pure asm
no understanding  -> no changes

The following architectures have changed:
sh i386 mips mips64 s390x s390 ia64 m68k 
changes occur in:
arch/<ARCH>/kernel/process.c    
< change return type kernel_thread() to  pid_t kernel_thread() >

include/asm-<ARCH>/processor.h
< add linux/types.h for pid_t >
< definiton change return type kernel_thread() to  pid_t kernel_thread() >

additionaly we started to clean the kernel

rch/i386/kernel/ptrace.c: 
changed type of sys_ptrace pid argument from to pid_t (original: long) 

include/linux/fs.h: 
changed type of pid member of struct fown_struct to pid_t (original: int) 

fs/proc/base.c: 
change type of pid variable in proc_pid_lookup to pid_t (original: unsigned int) [See Above] 

include/linux/sched.h: 
change type of find_task_by_pid argument (pid) from to pid_t (original: int) 

kernel/capability.c: 
in sys_capget: change type of pid variable to pid_t (original: int) 
in sys_capset: change type of pid variable to pid_t (original: int) 

kernel/signal.c: 
in sys_tkill: changed type of pid argument to pid_t (original: int) 

-- 
