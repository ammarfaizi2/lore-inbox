Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTKUWg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 17:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbTKUWg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 17:36:26 -0500
Received: from maggie.ininet.com ([207.22.50.134]:6533 "EHLO maggie.ininet.com")
	by vger.kernel.org with ESMTP id S261492AbTKUWgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 17:36:24 -0500
Subject: Re: Kernel oops at boot with 2.6.0-test9, 2.4.21ELsmp on Opteron
	248
From: Paul Venezia <pvenezia@ininet.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1069453947.3807.2341.camel@soul.jpj.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Nov 2003 17:32:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I meant to include more complete traces in my previous post, but I'm
having some odd problem with serial consoles on this box so I only get
partial clean output. Here's what I can gather at the moment:


2.6.0-test9 (snip):

Call Trace:<ffffffff8014aed4>{__kmalloc+186}
<ffffffff80186f64>{proc_create+100} 
       <ffffffff801870f2>{create_proc_entry+96}
<ffffffff801321ce>{register_proc_table+176} 
       <ffffffff801321ff>{register_proc_table+225}
<ffffffff801321ff>{register_proc_table+225} 
       <ffffffff803f0688>{sysctl_init+20}
<ffffffff803e56ec>{do_basic_setup+11} 
       <ffffffff8010b05b>{init+32} <ffffffff8010b03b>{init+0} 
       <ffffffff80110acf>{child_rip+8} <ffffffff8010b03b>{init+0} 
       <ffffffff80110ac7>{child_rip+0} 
Slab corruption: start=0000010037f08748, expend=0000010037f08807,
problemat=0000010037f0874c
Last user: [<0000000000000000>](0x0)
Data: ....00 00 00 00 ....00 00 00 00 ....00 00 00 00 ....00 00 00 00
....00 00 00 00 ....00 00 00 00 ....00 00 00 00 ....00 00 00 00 ....00
00 00 Next: 71 F0 2C .00 00 00 00 00 00 00 00 00 00 00 00 A5 C2 0F 17 00
00 00 00 84 10 0C 00 00 00 00 00 
slab error in check_poison_obj(): cache `size-192': object was modified
after freeing



2.4.21EL-4.0smp:

RIP: 0010:[<000000008010de3e>]
RSP: 0018:00000100077cbfc8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff8010de20 RCX: 00000000ffffffff
RDX: 00000100077ca000 RSI: 0000000000000001 RDI: ffffffff806031c0
RBP: ffffffff8010de20 R08: 00000000ffffffff R09: 0000000000000003
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff805fb580(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 000000008010de3e CR3: 00000000079b9000 CR4: 00000000000006e0

Call Trace: [<ffffffff8010de20>]{default_idle+0}
[<ffffffff8010dec9>]{cpu_idle+73} 
       
Process swapper (pid: 0, stackpage=100077cb000)
Stack: 00000100077cbfc8 0000000000000018 ffffffff8010de20
ffffffff8010dec9 
       0000000000000010 0000000000000405 0000000000000001
ffffffff8063abef 
       0000000000000000 0000000000000002 
Call Trace: [<ffffffff8010de20>]{default_idle+0}
[<ffffffff8010dec9>]{cpu_idle+73} 
       

Code: Bad RIP value.

Kernel panic: Fatal exception
In idle task - not syncing
