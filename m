Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267134AbSLREps>; Tue, 17 Dec 2002 23:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbSLREps>; Tue, 17 Dec 2002 23:45:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:9373 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267134AbSLREpp>;
	Tue, 17 Dec 2002 23:45:45 -0500
Message-ID: <3DFFFF52.1290377D@digeo.com>
Date: Tue, 17 Dec 2002 20:53:38 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212172005500.1230-100000@home.transmeta.com> <20021218154023.29726d09.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2002 04:53:38.0864 (UTC) FILETIME=[6E0C0B00:01C2A651]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> 
> Hi Linus, Andrew,
> 
> On Tue, 17 Dec 2002 20:07:53 -0800 (PST) Linus Torvalds <torvalds@transmeta.com> wrote:
> >
> > Btw, on another tangent - Andrew Morton reports that APM is unhappy about
> > the fact that the fast system call stuff required us to move the segments
> > around a bit. That's probably because the APM code has the old APM segment
> > numbers hardcoded somewhere, but I don't see where (I certainly knew about
> > the segment number issue, and tried to update the cases I saw).
> 
> I looked at this yesterday and decided that it was OK as well.
> 
> > Debugging help would be appreciated, especially from somebody who knows
> > the APM code.
> 
> It would help to know what "unhappy" means :-)

The lcall seems to be going awry.  It oopses when apmd starts up,
and the sysenter patch is the trigger.

CPU:    0
EIP:    00b8:[<000044d7>]    Not tainted
EFLAGS: 00010202
EIP is at 0x44d7
eax: 000000c8   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: c02e0091   edi: 000000ff   ebp: ceed1ec4   esp: ceed1e74
ds: 0000   es: 0000   ss: 0068
Process apmd (pid: 679, threadinfo=ceed0000 task=cfa058a0)
Stack: 0000530a 00b844e8 00000000 ceed1ec4 c0112739 00000060 ceed1ec4 000000ff 
       00000068 00000068 ceed1f32 c02e0091 000000ff 00000202 ceed0000 cf706c24 
       00000000 00000000 c0130000 c1740000 ceed1f04 c0112b72 0000530a 00000001 
Call Trace:
 [<c0112739>] apm_bios_call+0x75/0xf4
 [<c0130000>] cache_init_objs+0x34/0xd8
 [<c0112b72>] apm_get_power_status+0x42/0x84
 [<c012d843>] __alloc_pages+0x77/0x244
 [<c0113828>] apm_get_info+0x38/0xe4
 [<c016982d>] proc_file_read+0xa9/0x1ac
 [<c0141b53>] vfs_read+0xb7/0x138
 [<c0141dee>] sys_read+0x2a/0x40
 [<c0108e67>] syscall_call+0x7/0xb

> Does the following fix it for you? Untested, assumes cache lines are 32
> bytes.
> 

I cleverly left the laptop at work.  Shall test tomorrow.
