Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUHTKxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUHTKxo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUHTKxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:53:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:55741 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266273AbUHTKx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:53:27 -0400
Date: Fri, 20 Aug 2004 03:51:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: vherva@viasys.com
Cc: petr@vandrovec.name, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-Id: <20040820035142.3bcdb1cb.akpm@osdl.org>
In-Reply-To: <20040820104230.GH23741@viasys.com>
References: <20040820104230.GH23741@viasys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva <vherva@viasys.com> wrote:
>
> Andrew, I know you are not interested in closed source vmware, I'm just
> blatantly Cc'ing you in case you would have some suggestion of the top of
> your head. As stuff slowly trickles from -mm to mainline, this could
> eventually end up biting more people.
> 
> In short, there are two (afaict) separate problem:
> 
> (1) vmmon.ko gives this:
> 
> 	vmmon: Your kernel is br0ken. get_user_pages(current, current->mm, b7dd1000, 1, 1, 0, &page, NULL) returned -14.
> 	vmmon: I'll try accessing page tables directly, but you should know that your
> 	vmmon: kernel is br0ken and you should uninstall all additional patches you
> 	vmmon: have installed!
> 	vmmon: FYI, copy_from_user(b7dd1000) returns 0 (if not 0 maybe your kernel is not br0ken)
> 
> (2) vmware fails to start any guest os, telling it cannot allocate memory:
> 
> 	VMX|[msg.msg.noMem] Cannot allocate memory.
> 
> 
> (1) happened with 2.6.6-mm4 and with 2.6.8.1-mm2.
> (2) only happened with 2.6.8.1-mm2 (with 2.6.6-mm4 vmware worked despite the
> warning.

Try -mm3, please.  It'll have the same problem.

> So I backed out these patches from 2.6.8.1-mm2:
> 
> 	flexible-mmap-2.6.7-mm3-A8.patch
> 	flex-mmap-for-ppc64.patch
> 	flex-mmap-for-s390x.patch
> 	sysctl-tunable-for-flexmmap.patch

These have all been lumped together in mm3.

Try setting /proc/sys/vm/legacy_va_layout to 1

> 	get_user_pages-latency-fix.patch

It won't be this.

> 	increase-mlock-limit-to-32k.patch
> 	mlock-as-user-for-268-rc2-mm2.patch

Unlikely to be these.

> 	(All conveniently available for reference at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm2/broken-out/
>          if anyone is interested)
> 
> I had a vague hunch that flex-mmap stuff might affect (2) and
> get_user_pages patch perhaps (1).
> 
> After this, problem (1) went away for 2.6.8.1-mm2, but problem (2) remained.

Try setting /proc/sys/vm/overcommit_memory to 1

> Then I tried 2.6.8.1 vanilla. It does NOT suffer from either (1) or (2).
> 
> All experiments are done with Petr Vandrovec's newest
> vmware-any-any-update81 (apart from 2.6.6-mm4 that had some older any-to-any
> patch) and VMwareWorkstation-3.2.0-2230.

Maybe Peter could take a look sometime?

> Before I continue backing stuff out: does anyone have ideas or suggestions
> what -mm patches might be suspectible problem (2)? 2.6.8.1 -> 2.6.8.1-mm2 is
> rather large patch and so is 2.6.6-mm4 -> 2.6.8.1-mm2, and the patches
> listed above were everything I thought might be suspectible.
> 
> Could get_user_pages-latency-fix.patch explain (1)? My kernel expertise is
> not sufficient to tell.

Doubtful.
