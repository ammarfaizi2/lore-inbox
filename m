Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311213AbSCLO1m>; Tue, 12 Mar 2002 09:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311212AbSCLO10>; Tue, 12 Mar 2002 09:27:26 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:35346 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S311211AbSCLO1H>;
	Tue, 12 Mar 2002 09:27:07 -0500
Date: Mon, 11 Mar 2002 21:49:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Message-ID: <20020311204955.GE332@elf.ucw.cz>
In-Reply-To: <a6bjgl$a0j$1@cesium.transmeta.com> <E16jVSZ-0008FH-00@the-village.bc.nu> <a6gctg$eb6$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6gctg$eb6$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >So if anything its just not worth the effort of breaking the 386 setup
> >either 8). 386 SMP is a different issue but I don't see any lunatics doing
> >a 386 based sequent port thankfully.
> 
> Since the only person that comes to mind that would be crazy enough to
> even _try_ to use Linux on 386-SMP is you, Alan, I'm really relieved to
> hear you say that ;)
> 
> And no, it's not worth discontinuing i386 support.  It just isn't
> painful enough to maintain. 
> 
> Note that the i386 has _long_ been a "stepchild", though: because of the
> lack of WP, the kernel simply doesn't do threaded MM correctly on a 386. 
> Never has, and never will. 
> 
> However, the known "incorrect" case is so obscure that it's not even an
> issue - although I suspect that it means that you should not let
> untrusted users run on a i386 server machine that contains any sensitive
> data.  I could cerrtainly come up with exploits that would work at least
> in theory (whether they are workable in practice I don't know). 

That should mean at least warning during bootup. Checking for WP
bit... message does not suggest that WP not present means security
hole.

--- clean.2.5//arch/i386/mm/init.c	Sun Mar 10 20:06:31 2002
+++ linux/arch/i386/mm/init.c	Mon Mar 11 21:49:14 2002
@@ -383,7 +383,7 @@
 	local_flush_tlb();
 
 	if (!boot_cpu_data.wp_works_ok) {
-		printk("No.\n");
+		printk("No (that's security hole).\n");
 #ifdef CONFIG_X86_WP_WORKS_OK
 		panic("This kernel doesn't support CPU's with broken WP. Recompile it for a 386!");
 #endif

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
