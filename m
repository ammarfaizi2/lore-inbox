Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261987AbTCHCDc>; Fri, 7 Mar 2003 21:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbTCHCDc>; Fri, 7 Mar 2003 21:03:32 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:50979
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261987AbTCHCDa>; Fri, 7 Mar 2003 21:03:30 -0500
Date: Fri, 7 Mar 2003 21:11:12 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andrew Morton <akpm@digeo.com>, "" <linux-kernel@vger.kernel.org>
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
In-Reply-To: <Pine.LNX.4.50.0303071656160.18716-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303072007190.1339-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
 <20030306222328.14b5929c.akpm@digeo.com>
 <Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
 <20030306233517.68c922f9.akpm@digeo.com>
 <Pine.LNX.4.50.0303070351060.18716-100000@montezuma.mastecende.com>
 <20030307010539.3c0a14a3.akpm@digeo.com> <3E68F552.1010807@colorfullife.com>
 <Pine.LNX.4.50.0303071656160.18716-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Zwane Mwaikambo wrote:

> > >  
> > >
> > No, CONFIG_FRAME_POINTER is only needed for __builtin_return_address(x, 
> > x>0). _address(0) always works.
> > 
> > I've attached a patch that records the last kfree address and prints 
> > that if a poison check fails.
> > 
> > Zwane, could you try to reproduce the bug?
> 
> I can almost always witness it given approx 30minutes of runtime, however 
> i still don't know how to trigger it by on demand. I'll apply your patch 
> and get back to you when it triggers next.

Just triggered an oops, looks like debris from something else though. 
still no slab debug messages.

Unable to handle kernel NULL pointer dereference at virtual address 00000001
 printing eip:
c01da9a6
*pde = 245f2001
*pte = 00000000
Oops: 0002
CPU:    1
EIP:    0060:[<c01da9a6>]    Not tainted
EFLAGS: 00010246
EIP is at number+0x1b6/0x2c0
eax: 00000004   ebx: 00000000   ecx: 00000000   edx: 00000006
esi: 00000000   edi: 00000001   ebp: 00000003   esp: e390be24
ds: 007b   es: 007b   ss: 0068
Process sadc (pid: 1205, threadinfo=e390a000 task=e3d398e0)
Stack: 00000000 e390be38 00000006 c02ae560 2000002c 31323335 c0143333 
e59ff060 
       e59cfbfc 00000779 c0135fd6 e390be50 e390be50 c3a82a9c 00000001 00000000 
       e390a000 c0128640 00000000 c03b4444 c03b4444 00000001 c034fa08 ffffffdd 
Call Trace:
 [<c0143333>] cache_grow+0x2e3/0x360
 [<c0135fd6>] rcu_process_callbacks+0x1a6/0x1c0
 [<c0128640>] tasklet_action+0x80/0xd0
 [<c01dad52>] vsnprintf+0x2a2/0x430
 [<c01796a9>] seq_printf+0x29/0x50
 [<c010cc38>] show_interrupts+0x298/0x2f0
 [<c0179148>] seq_read+0x108/0x2c0
 [<c01593b8>] vfs_read+0xa8/0x160
 [<c01596aa>] sys_read+0x2a/0x40
 [<c010ad9b>] syscall_call+0x7/0xb

Code: c6 07 20 89 e8 47 4d 85 c0 7f ef 80 7c 24 12 00 74 0e 3b 7c 

-- 
function.linuxpower.ca
