Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262228AbTC1GOw>; Fri, 28 Mar 2003 01:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262229AbTC1GOw>; Fri, 28 Mar 2003 01:14:52 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:767
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262228AbTC1GOn>; Fri, 28 Mar 2003 01:14:43 -0500
Date: Fri, 28 Mar 2003 01:22:18 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: task_struct slab cache use after free in 2.5.66
In-Reply-To: <Pine.LNX.4.50.0303272323330.2884-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303280119480.2884-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303272211180.2884-100000@montezuma.mastecende.com>
 <20030327202348.75021c5d.akpm@digeo.com> <Pine.LNX.4.50.0303272323330.2884-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Zwane Mwaikambo wrote:

> On Thu, 27 Mar 2003, Andrew Morton wrote:
> 
> > That's the second report of this.  Someone did a put_task_struct against a
> > freed task_struct.  I'll cook up a debug patch to trap it.  Something like
> > this:
> 
> Well there is also the detach_pid bug which suddenly vanished... I'm not 
> aware of anyone sending a patch for that (but i can't be certain i havent 
> been keeping up with lkml lately). I posted some debug information for 
> that one about a week ago:
> 
> Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com

I thought i was home free after the smp_call_function_interrupt bug :(

detach_pid is back...

Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c0134b8c
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0134b8c>]    Not tainted
EFLAGS: 00010046
EIP is at detach_pid+0x1c/0xf0
eax: 6b6b6b6b   ebx: 6b6b6b6b   ecx: 6b6b6b6b   edx: c39bc6b0
esi: 00000000   edi: bffff228   ebp: 00000000   esp: c245bf08
ds: 007b   es: 007b   ss: 0068
Process find (pid: 1892, threadinfo=c245a000 task=c5bd8100)
Stack: c39bc660 00000000 bffff228 00000000 c012391c c39bc660 c0123a0c c39bc660 
       c39bc660 c39bcc24 c39bc660 00005608 c01257fb c39bc660 bffff228 bffff228 
       c39bc704 c39bc660 c5bd8100 c5bd819c c0125cb1 c39bc660 bffff228 00000000 
Call Trace:
 [<c012391c>] __unhash_process+0x10c/0x170
 [<c0123a0c>] release_task+0x8c/0x200
 [<c01257fb>] wait_task_zombie+0x15b/0x1c0
 [<c0125cb1>] sys_wait4+0x241/0x290
 [<c011d110>] default_wake_function+0x0/0x20
 [<c011d110>] default_wake_function+0x0/0x20
 [<c0109497>] syscall_call+0x7/0xb

-- 
function.linuxpower.ca
