Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWERTtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWERTtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 15:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWERTtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 15:49:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:50819 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751388AbWERTtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 15:49:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bjyqrAIUnbid8XktCYEsUTT4Oa75WuBIzwsB6sE8XYifveMbWDz3z3kzvNwgS1TlUbCF8I5Lr29TsDBcYxwMYfSa6askrCgj/BB15E1dPE+TLorsYK5Ckr+wSkLACEN4ITIQGMGQ2bI8K3dFp/Y/k70K8yWkQEX1KeggGSmIrns=
Date: Thu, 18 May 2006 16:48:43 -0300
From: Alberto Bertogli <albertito@gmail.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on x86-64
Message-ID: <20060518194843.GA9593@gmail.com>
References: <20060514182541.GA4980@gmail.com> <20060516191244.GB6337@ccure.user-mode-linux.org> <20060517023942.GI9066@gmail.com> <200605170836.41009.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605170836.41009.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 08:36:40AM +0200, Blaisorblade wrote:
> On Wednesday 17 May 2006 04:39, Alberto Bertogli wrote:
> > On Tue, May 16, 2006 at 03:12:44PM -0400, Jeff Dike wrote:
> > > On Mon, May 15, 2006 at 12:29:58PM -0300, Alberto Bertogli wrote:
> > Here it is. While the patch worked, it was for 2.6.16, and I'm using
> > 2.6.17-rc4, I hope that's not a problem.
> 
> Guess not - I'll test this patch soon because I have the same problem, however 
> are you running a 2.6.16 host?
> 
> If so, can you verify whether on a 2.6.15 host kernel the same binary runs 
> fine (as is the case for me)?

I tried running 2.6.15.1 and 2.6.17-rc1 on the host. Both advanced more
than 2.6.17-rc4, but failed in different ways.

2.6.15.1 was the most successful one, it managed to boot and it kinda
worked, but I got semi-random segmentation faults when running some apps
like apt-get. I reported this some time ago to Jeff Dike.

2.6.17-rc1 didn't got that far, and 'panic'ed when starting runlevel 2;
I attach the output below.

Do you want me to try anything else?

Thanks,
		Alberto


Initializing random number generator...done.
INIT: Entering runlevel: 2
INIT: PANIC: segmentation violation! sleeping for 30 seconds.
[42949380.750000] BUG: failure at /usr/src/linux-2.6.17-rc4/include/linux/elfcore.h:95/elf_core_copy_regs()!
[42949380.750000] Kernel panic - not syncing: BUG!
[42949380.750000]
[42949380.750000] Modules linked in:
[42949380.750000] Pid: 444, comm: init Not tainted 2.6.17-rc4
[42949380.750000] RIP: 0033:[<0000000040145896>]
[42949380.750000] RSP: 0000007f7f811f30  EFLAGS: 00000246
[42949380.750000] RAX: 0000000000000000 RBX: 0000000040017600 RCX: ffffffffffffffff
[42949380.750000] RDX: 0000000000000000 RSI: 0000007f7f811f48 RDI: 0000000000000002
[42949380.750000] RBP: 0000000000000000 R08: 00000000000001bc R09: 000000000000000b
[42949380.750000] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000002
[42949380.750000] R13: 00000000005096bc R14: 0000000000406b21 R15: 0000000000406b21
[42949380.750000] Call Trace:
[42949380.750000] 67efb768:  [<6001a10a>] panic_exit+0x2a/0x50
[42949380.750000] 67efb778:  [<60044acc>] notifier_call_chain+0x1c/0x30
[42949380.750000] 67efb798:  [<600348cf>] panic+0xcf/0x170
[42949380.750000] 67efb7b8:  [<600c336f>] ext3_mark_iloc_dirty+0xf/0x20
[42949380.750000] 67efb7f8:  [<600c7000>] ext3_orphan_del+0x1d0/0x280
[42949380.750000] 67efb808:  [<600c3528>] ext3_dirty_inode+0x78/0xa0
[42949380.750000] 67efb838:  [<6009d1c2>] __mark_inode_dirty+0x102/0x1b0
[42949380.750000] 67efb848:  [<600285b4>] set_signals+0x14/0x30
[42949380.750000] 67efb858:  [<600742c8>] kmem_cache_alloc+0x48/0x70
[42949380.750000] 67efb878:  [<600aa4e4>] elf_core_dump+0x264/0x2f0
[42949380.750000] 67efb938:  [<6007554d>] do_truncate+0x5d/0x70
[42949380.750000] 67efb9a8:  [<600842e7>] do_coredump+0x2c7/0x370
[42949380.750000] 67efba48:  [<60040bd9>] recalc_sigpending+0x19/0x20
[42949380.750000] 67efba58:  [<60041064>] __dequeue_signal+0x84/0xf0
[42949380.750000] 67efbad8:  [<600432e3>] get_signal_to_deliver+0x3e3/0x400
[42949380.750000] 67efbb68:  [<60065b6d>] __handle_mm_fault+0x23d/0x280
[42949380.750000] 67efbb88:  [<6013f13e>] __up_read+0x1e/0xc0
[42949380.750000] 67efbbe8:  [<60017866>] kern_do_signal+0x86/0x230
[42949380.750000] 67efbc00:  [<6001b370>] copy_chunk_from_user+0x0/0x40
[42949380.750000] 67efbc18:  [<600197cb>] segv+0x21b/0x300
[42949380.750000] 67efbcb8:  [<6002b8f8>] wait_stub_done+0x58/0x110
[42949380.750000] 67efbce8:  [<600434de>] sys_rt_sigprocmask+0x7e/0x120
[42949380.750000] 67efbd28:  [<60017a30>] do_signal+0x20/0x30
[42949380.750000] 67efbd38:  [<60016795>] interrupt_end+0x45/0x60
[42949380.750000] 67efbd58:  [<6002be8c>] userspace+0x15c/0x2f0
[42949380.750000] 67efbd78:  [<6001b502>] copy_to_user_skas+0x72/0x90
[42949380.750000] 67efbde8:  [<6001a8fe>] fork_handler+0xee/0x100
[42949380.750000]
[42949380.750000]  * route del -host 192.168.0.2 dev tap0
[42949380.750000] * bash -c echo 0 > /proc/sys/net/ipv4/conf/tap0/proxy_arp


