Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVEIVxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVEIVxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 17:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVEIVxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 17:53:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:10449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261536AbVEIVxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 17:53:52 -0400
Date: Mon, 9 May 2005 14:54:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219
Message-Id: <20050509145424.6ffba49a.akpm@osdl.org>
In-Reply-To: <200505092239.37834.rjw@sisk.pl>
References: <200505092239.37834.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> I get this from 2.6.12-rc3-mm3 on a UP AMD64 box (Asus L5D), 100% of the time:
> 
> ]--snip--[
> ACPI: bus type pci registered
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> kmem_cache_create: Early error in slab <NULL>
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at "mm/slab.c":1219
> invalid operand: 0000 [1]
> CPU 0
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.12-rc3-mm3
> RIP: 0010:[<ffffffff80179eeb>] <ffffffff80179eeb>{kmem_cache_create+139}
> RSP: 0000:ffff810001ca1eb8  EFLAGS: 00010292
> RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000dd3 RDI: ffffffff804167e0
> RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000010 R11: 0000000000000008 R12: 0000000000042000
> R13: 0000000000000000 R14: 0000ffffffff8010 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff8055a840(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000004000 CR3: 0000000000101000 CR4: 00000000000006e0
> Process swapper (pid: 1, threadinfo ffff810001ca0000, task ffff810001c5a7a0)
> Stack: fffffffffffffff8 0000000000000000 0000000000000000 0000000000000000
>        0000000000000010 0000000000000000 0000000000000005 0000000000000006
>        00000000ffffffff 0000ffffffff8010
> Call Trace:<ffffffff8057a11d>{init_bio+93} <ffffffff8010c0f2>{init+178}
>        <ffffffff8010fc37>{child_rip+8} <ffffffff8010c040>{init+0}
>        <ffffffff8010fc2f>{child_rip+0}
> 

Something kooky is happening.

Clearly init_bio() is not passing in a NULL `name' parameter.  Maybe the
backtrace is screwed due to dopey gcc autoinlining and the bad caller is
really biovec_init_slabs().  Try removing the
__cacheline_aligned_mostly_readonly from the declaration of bvec_slabs[].

Please tell us what gcc and binutils versions you're using.
