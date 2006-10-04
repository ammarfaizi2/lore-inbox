Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbWJDP47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbWJDP47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWJDP47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:56:59 -0400
Received: from ns2.suse.de ([195.135.220.15]:54418 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161251AbWJDP46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:56:58 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Date: Wed, 4 Oct 2006 17:56:47 +0200
User-Agent: KMail/1.9.3
Cc: Steve Fox <drfickle@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>,
       Ian Campbell <Ian.Campbell@xensource.com>
References: <20060928014623.ccc9b885.akpm@osdl.org> <1159969349.28106.64.camel@flooterbu> <20061004084540.af17fee5.akpm@osdl.org>
In-Reply-To: <20061004084540.af17fee5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041756.47682.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 October 2006 17:45, Andrew Morton wrote:
> On Wed, 04 Oct 2006 08:42:28 -0500
> Steve Fox <drfickle@us.ibm.com> wrote:
> 
> > On Thu, 2006-09-28 at 14:01 -0700, Andrew Morton wrote:
> > > On Thu, 28 Sep 2006 17:50:31 +0000 (UTC)
> > > "Steve Fox" <drfickle@us.ibm.com> wrote:
> > > 
> > > > On Thu, 28 Sep 2006 01:46:23 -0700, Andrew Morton wrote:
> > > > 
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/
> > > > 
> > > > Panic on boot. This machine booted 2.6.18-mm1 fine. em64t machine.
> > > > 
> > > > TCP bic registered
> > > > TCP westwood registered
> > > > TCP htcp registered
> > > > NET: Registered protocol family 1
> > > > NET: Registered protocol family 17
> > > > Unable to handle kernel paging request at ffffffffffffffff RIP: 
> > > >  [<ffffffff8047ef93>] packet_notifier+0x163/0x1a0
> > > > PGD 203027 PUD 2b031067 PMD 0 
> > > > Oops: 0000 [1] SMP 
> > > > last sysfs file: 
> > > > CPU 0 
> > > > Modules linked in:
> > > > Pid: 1, comm: swapper Not tainted 2.6.18-mm2-autokern1 #1
> > > > RIP: 0010:[<ffffffff8047ef93>]  [<ffffffff8047ef93>] packet_notifier+0x163/0x1a0
> > > > RSP: 0000:ffff810bffcbde90  EFLAGS: 00010286
> > > > RAX: 0000000000000000 RBX: ffff810bff4a1000 RCX: 2222222222222222
> > > > RDX: ffff810bff4a1000 RSI: 0000000000000005 RDI: ffffffff8055f5e0
> > > > RBP: ffffffffffffffff R08: 0000000000007616 R09: 000000000000000e
> > > > R10: 0000000000000006 R11: ffffffff803373f0 R12: 0000000000000000
> > > > R13: 0000000000000005 R14: ffff810bff4a1000 R15: 0000000000000000
> > > > FS:  0000000000000000(0000) GS:ffffffff805d8000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> > > > CR2: ffffffffffffffff CR3: 0000000000201000 CR4: 00000000000006e0
> > > > Process swapper (pid: 1, threadinfo ffff810bffcbc000, task ffff810bffcbb510)
> > > > Stack:  ffff810bff4a1000 ffffffff8055f4c0 0000000000000000 ffff810bffcbdef0
> > > >  0000000000000000 ffffffff8042736e 0000000000000000 0000000000000000
> > > >  0000000000000000 ffffffff8061c68d ffffffff806260f0 ffffffff80207182
> > > > Call Trace:
> > > >  [<ffffffff8042736e>] register_netdevice_notifier+0x3e/0x70
> > > >  [<ffffffff8061c68d>] packet_init+0x2d/0x53
> > > >  [<ffffffff80207182>] init+0x162/0x330
> > > >  [<ffffffff8020a9d8>] child_rip+0xa/0x12
> > > >  [<ffffffff8033c2a2>] acpi_ds_init_one_object+0x0/0x82
> > > >  [<ffffffff80207020>] init+0x0/0x330
> > > >  [<ffffffff8020a9ce>] child_rip+0x0/0x12
> > > > 
> > > > 
> > > > Code: 48 8b 45 00 0f 18 08 49 83 fd 02 4c 8d 65 f8 0f 84 f8 fe ff 
> > > > RIP  [<ffffffff8047ef93>] packet_notifier+0x163/0x1a0
> > > >  RSP <ffff810bffcbde90>
> > > > CR2: ffffffffffffffff
> > > >  <0>Kernel panic - not syncing: Attempted to kill init!
> > > > 
> > > 
> > > I'm really struggling to work out what went wrong there.  Comparing your
> > > miserable 20 bytes of code to my object code makes me think that this:
> > > 
> > > 		struct packet_sock *po = pkt_sk(sk);
> > > 
> > > returned -1, perhaps in %ebp.  But it's all very crude.
> > > 
> > > Perhaps you could compile that kernel with CONFIG_DEBUG_INFO, rerun it (the
> > > addresses might change) then have a poke around with `gdb vmlinux' (or
> > > maybe just addr2line) to work out where it's really oopsing?
> > > 
> > > I don't see much which has changed in that area recently.
> > 
> > Sorry for the delay. I was finally able to perform a bisect on this. It
> > turns out the patch that causes this is
> > x86_64-mm-re-positioning-the-bss-segment.patch, which seems like a
> > strange candidate, but sure enough I can boot to login: right up until
> > that patch is applied.
> 
> hm, that patch was merged into mainline September 29.  Does mainline work?

Yes we had this earlier already. But without this patch it doesn't 
compile for some people. So it was readded.

And nobody knows why the reposition-bss patch actually breaks things :/

In theory the reposition is ok, so it must be some marginal code
somewhere else that just ends up failing over.

-Andi

