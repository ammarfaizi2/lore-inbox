Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWESBUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWESBUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWESBUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:20:50 -0400
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:1159 "HELO
	smtp010.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932173AbWESBUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:20:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=LbGjB4bioMx8LxoAvYSD67MjD/PbUFGYt4TKyYa3AozQaI+jI0YLnIMBC3BbexiEkWQb/gF2xbOznpx7R2F5oXs3Oj0amgpyP5HY54MKkY5mkABCiHWEvYohgWzrLKkajUUwo/RLuUzie8WAQxemZBwjMITUuvERkFUWCu1sMIo=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Alberto Bertogli <albertito@gmail.com>
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on x86-64
Date: Fri, 19 May 2006 03:20:47 +0200
User-Agent: KMail/1.8.3
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <20060514182541.GA4980@gmail.com> <200605170836.41009.blaisorblade@yahoo.it> <20060518194843.GA9593@gmail.com>
In-Reply-To: <20060518194843.GA9593@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605190320.47833.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 May 2006 21:48, Alberto Bertogli wrote:
> On Wed, May 17, 2006 at 08:36:40AM +0200, Blaisorblade wrote:
> > On Wednesday 17 May 2006 04:39, Alberto Bertogli wrote:
> > > On Tue, May 16, 2006 at 03:12:44PM -0400, Jeff Dike wrote:
> > > > On Mon, May 15, 2006 at 12:29:58PM -0300, Alberto Bertogli wrote:
> > >
> > > Here it is. While the patch worked, it was for 2.6.16, and I'm using
> > > 2.6.17-rc4, I hope that's not a problem.
> >
> > Guess not - I'll test this patch soon because I have the same problem,
> > however are you running a 2.6.16 host?
> >
> > If so, can you verify whether on a 2.6.15 host kernel the same binary
> > runs fine (as is the case for me)?
>
> I tried running 2.6.15.1 and 2.6.17-rc1 on the host. Both advanced more
> than 2.6.17-rc4, but failed in different ways.
>
> 2.6.15.1 was the most successful one, it managed to boot and it kinda
> worked, but I got semi-random segmentation faults when running some apps
> like apt-get. I reported this some time ago to Jeff Dike.
>
> 2.6.17-rc1 didn't got that far, and 'panic'ed when starting runlevel 2;
> I attach the output below.

Interesting, I'll test ASAP, meanwhile please verify if a 2.6.16 guest kernel 
works fine at least on 2.6.15 host (as it does here). So we'll know that the 
semi-random segfault is a bug in 2.6.17-rc guests.

I've built all 2.6.16-rc releases to start doing binary search to insulate 
where was the host change.

> Initializing random number generator...done.
> INIT: Entering runlevel: 2
> INIT: PANIC: segmentation violation! sleeping for 30 seconds.
> [42949380.750000] BUG: failure at
> /usr/src/linux-2.6.17-rc4/include/linux/elfcore.h:95/elf_core_copy_regs()!
> [42949380.750000] Kernel panic - not syncing: BUG!
> [42949380.750000]
> [42949380.750000] Modules linked in:
> [42949380.750000] Pid: 444, comm: init Not tainted 2.6.17-rc4
> [42949380.750000] RIP: 0033:[<0000000040145896>]
> [42949380.750000] RSP: 0000007f7f811f30  EFLAGS: 00000246
> [42949380.750000] RAX: 0000000000000000 RBX: 0000000040017600 RCX:
> ffffffffffffffff [42949380.750000] RDX: 0000000000000000 RSI:
> 0000007f7f811f48 RDI: 0000000000000002 [42949380.750000] RBP:
> 0000000000000000 R08: 00000000000001bc R09: 000000000000000b
> [42949380.750000] R10: 0000000000000008 R11: 0000000000000246 R12:
> 0000000000000002 [42949380.750000] R13: 00000000005096bc R14:
> 0000000000406b21 R15: 0000000000406b21 [42949380.750000] Call Trace:
> [42949380.750000] 67efb768:  [<6001a10a>] panic_exit+0x2a/0x50
> [42949380.750000] 67efb778:  [<60044acc>] notifier_call_chain+0x1c/0x30
> [42949380.750000] 67efb798:  [<600348cf>] panic+0xcf/0x170
> [42949380.750000] 67efb7b8:  [<600c336f>] ext3_mark_iloc_dirty+0xf/0x20
> [42949380.750000] 67efb7f8:  [<600c7000>] ext3_orphan_del+0x1d0/0x280
> [42949380.750000] 67efb808:  [<600c3528>] ext3_dirty_inode+0x78/0xa0
> [42949380.750000] 67efb838:  [<6009d1c2>] __mark_inode_dirty+0x102/0x1b0
> [42949380.750000] 67efb848:  [<600285b4>] set_signals+0x14/0x30
> [42949380.750000] 67efb858:  [<600742c8>] kmem_cache_alloc+0x48/0x70
> [42949380.750000] 67efb878:  [<600aa4e4>] elf_core_dump+0x264/0x2f0
> [42949380.750000] 67efb938:  [<6007554d>] do_truncate+0x5d/0x70
> [42949380.750000] 67efb9a8:  [<600842e7>] do_coredump+0x2c7/0x370
> [42949380.750000] 67efba48:  [<60040bd9>] recalc_sigpending+0x19/0x20
> [42949380.750000] 67efba58:  [<60041064>] __dequeue_signal+0x84/0xf0
> [42949380.750000] 67efbad8:  [<600432e3>] get_signal_to_deliver+0x3e3/0x400
> [42949380.750000] 67efbb68:  [<60065b6d>] __handle_mm_fault+0x23d/0x280
> [42949380.750000] 67efbb88:  [<6013f13e>] __up_read+0x1e/0xc0
> [42949380.750000] 67efbbe8:  [<60017866>] kern_do_signal+0x86/0x230
> [42949380.750000] 67efbc00:  [<6001b370>] copy_chunk_from_user+0x0/0x40
> [42949380.750000] 67efbc18:  [<600197cb>] segv+0x21b/0x300
> [42949380.750000] 67efbcb8:  [<6002b8f8>] wait_stub_done+0x58/0x110
> [42949380.750000] 67efbce8:  [<600434de>] sys_rt_sigprocmask+0x7e/0x120
> [42949380.750000] 67efbd28:  [<60017a30>] do_signal+0x20/0x30
> [42949380.750000] 67efbd38:  [<60016795>] interrupt_end+0x45/0x60
> [42949380.750000] 67efbd58:  [<6002be8c>] userspace+0x15c/0x2f0
> [42949380.750000] 67efbd78:  [<6001b502>] copy_to_user_skas+0x72/0x90
> [42949380.750000] 67efbde8:  [<6001a8fe>] fork_handler+0xee/0x100
> [42949380.750000]
> [42949380.750000]  * route del -host 192.168.0.2 dev tap0
> [42949380.750000] * bash -c echo 0 > /proc/sys/net/ipv4/conf/tap0/proxy_arp

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	
	
		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com
