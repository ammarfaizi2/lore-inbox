Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292617AbSCMHhe>; Wed, 13 Mar 2002 02:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292595AbSCMHhY>; Wed, 13 Mar 2002 02:37:24 -0500
Received: from [202.135.142.196] ([202.135.142.196]:5645 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S292635AbSCMHhQ>; Wed, 13 Mar 2002 02:37:16 -0500
Date: Wed, 13 Mar 2002 18:40:28 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Message-Id: <20020313184028.7fdb8541.rusty@rustcorp.com.au>
In-Reply-To: <a6gctg$eb6$1@penguin.transmeta.com>
In-Reply-To: <a6bjgl$a0j$1@cesium.transmeta.com>
	<E16jVSZ-0008FH-00@the-village.bc.nu>
	<a6gctg$eb6$1@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2002 19:41:36 +0000 (UTC)
torvalds@transmeta.com (Linus Torvalds) wrote:

> And no, it's not worth discontinuing i386 support.  It just isn't
> painful enough to maintain. 

How about just dropping 386 + SMP support?

Then it would be a nobrainer to have cmpxchg a generic operation, AND
export it to userspace in the proposed "kernel routine page".

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/arch/i386/config.in working-2.5.6-futex-6/arch/i386/config.in
--- linux-2.5.6/arch/i386/config.in	Wed Feb 20 17:56:59 2002
+++ working-2.5.6-futex-6/arch/i386/config.in	Sat Mar  9 15:17:18 2002
@@ -177,7 +177,9 @@
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
-bool 'Symmetric multi-processing support' CONFIG_SMP
+if [ "$CONFIG_M386" != "y" ]; then
+	bool 'Symmetric multi-processing support' CONFIG_SMP
+fi
 bool 'Preemptible Kernel' CONFIG_PREEMPT
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC

Thanks!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
