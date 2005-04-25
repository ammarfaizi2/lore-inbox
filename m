Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVDYXPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVDYXPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVDYXPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:15:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:14291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261166AbVDYXOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:14:41 -0400
Date: Mon, 25 Apr 2005 16:13:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: roland@topspin.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050425161330.32c32b4b.akpm@osdl.org>
In-Reply-To: <426D725C.4070103@ammasso.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
	<52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org>
	<5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org>
	<52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org>
	<4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org>
	<4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org>
	<426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com>
	<20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com>
	<20050425151459.1f5fb378.akpm@osdl.org>
	<426D6DFA.4090908@ammasso.com>
	<20050425153542.70197e6a.akpm@osdl.org>
	<426D725C.4070103@ammasso.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> wrote:
>
> Andrew Morton wrote:
> 
> > This is because there is no file descriptor or anything else associated
> > with the pages which permits the kernel to clean stuff up on unclean
> > application exit.  Also there are the obvious issues with permitting
> > pinning of unbounded amounts of memory.
> 
> Then that might explain the "bug" that we're seeing with get_user_pages().  We've been 
> assuming that get_user_pages() mappings are permanent.

They are permanent until someone runs put_page() against all the pages. 
What I'm saying is that all current callers of get_user_pages() _do_ run
put_page() within the same syscall or upon I/O termination.

> Well, I was just about to re-implement get_user_pages() support in our driver to 
> demonstrate the bug.  I guess I'll hold off on that.
> 
> If you look at the Infiniband code that was recently submitted, I think you'll see it does 
> exactly that: after calling mlock(), the driver calls get_user_pages(), and it stores the 
> page mappings for future use.

Where?

bix:/usr/src/linux-2.6.12-rc3> grep -rl get_user_pages .
./arch/i386/lib/usercopy.c
./arch/sparc64/kernel/ptrace.c
./drivers/video/pvr2fb.c
./drivers/media/video/video-buf.c
./drivers/scsi/sg.c
./drivers/scsi/st.c
./include/asm-ia64/pgtable.h
./include/linux/mm.h
./include/asm-um/archparam-i386.h
./include/asm-i386/fixmap.h
./fs/nfs/direct.c
./fs/aio.c
./fs/binfmt_elf.c
./fs/bio.c
./fs/direct-io.c
./kernel/futex.c
./kernel/ptrace.c
./mm/memory.c
./mm/nommu.c
./mm/rmap.c
./mm/mempolicy.c
