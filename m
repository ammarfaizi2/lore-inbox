Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbWJCTUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWJCTUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWJCTUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:20:05 -0400
Received: from knopper.net ([217.160.111.144]:30081 "EHLO knopper.net")
	by vger.kernel.org with ESMTP id S1030490AbWJCTUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:20:01 -0400
Date: Tue, 3 Oct 2006 21:20:00 +0200
From: Klaus Knopper <knopper@knopper.net>
To: linux-kernel@vger.kernel.org
Subject: compile error for 2.6.18-git19 with CONFIG_RWSEM_GENERIC_SPINLOCK=y
Message-ID: <20061003192000.GG6710@knopper.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Knopper Networks
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Since the "reporting bugs" FAQ told me to post here in case I can't
identify the right person to ask, and have not found any mention of this
problem on the list and anywhere else yet, I do.

Problem description: Compiling 2.6.18-git19 (gcc-3.3 and 4.1) fails for
processor family i386 (when CONFIG_RWSEM_GENERIC_SPINLOCK=y) is set,
with

arch/i386/lib/lib.a(semaphore.o): In function `call_rwsem_down_read_failed':
arch/i386/lib/semaphore.S:(.sched.text+0x5f): undefined reference to `rwsem_down_read_failed'
arch/i386/lib/lib.a(semaphore.o): In function `call_rwsem_down_write_failed':
arch/i386/lib/semaphore.S:(.sched.text+0x6a): undefined reference to `rwsem_down_write_failed'
arch/i386/lib/lib.a(semaphore.o): In function `call_rwsem_wake':
arch/i386/lib/semaphore.S:(.sched.text+0x76): undefined reference to `rwsem_wake'
arch/i386/lib/lib.a(semaphore.o): In function `call_rwsem_downgrade_wake':
arch/i386/lib/semaphore.S:(.sched.text+0x7f): undefined reference to `rwsem_downgrade_wake'

This option is present in .config when setting processor family to
plain "i386" in make menuconfig.

Using CONFIG_RWSEM_XCHGADD_ALGORITHM=y INSTEAD of
CONFIG_RWSEM_GENERIC_SPINLOCK=y (i486 and up) kind of "fixes" the
compile error, but I'm not sure if the resulting code would still run on
a real i386.

This problem also exists for ealier gits, but I can't tell exactly when
it started.

Regards
-Klaus Knopper
PS: Please CC any answers to me, since I'm not a subscriber to this list.
