Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSAXRtI>; Thu, 24 Jan 2002 12:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288756AbSAXRs7>; Thu, 24 Jan 2002 12:48:59 -0500
Received: from e22.nc.us.ibm.com ([32.97.136.228]:18866 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288736AbSAXRsz>; Thu, 24 Jan 2002 12:48:55 -0500
Date: Thu, 24 Jan 2002 09:47:15 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: mingo@elte.hu
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ingo's O(1) scheduler vs. wait_init_idle
Message-ID: <154900000.1011894435@flay>
In-Reply-To: <Pine.LNX.4.33.0201241020230.4694-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201241020230.4694-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I was trying to test this in my 8 way NUMA box, but this patch seems
>> to have lost half of the wait_init_idle fix that I put in a while
>> back. [...]
> 
> please check out the -J5 2.4.17/18 patch, thats the first 2.4 patch that
> has the correct idle-thread fixes. (which 2.5.3-pre3 has as well.) Do you
> still have booting problems?

Yes ... tried J6 on 2.4.18-pre4. If you want the garbled panic, it's attatched
below. What you're doing in J6 certainly looks different, but appears not
to be correct still. I'll look at  it some more, and try to send you a patch
against J6 today.

On the upside, the perfomance of the your J4 patch with the added fix I
sent yesterday seems to be a great improvment - before I was getting 
about 16% of my total system time spent in default_idle on a 
make -j16 bzImage. Now it's 0% ... we're actually feeding those CPUs ;-)
Kernel compile time is under a minute (56s) for the first time ever on the
8 way ... more figures later.

Martin.

checking TSC synchronization across CPUs: 
BIOS BUG: CPU#0 improperly initialized, has 52632 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 52632 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has 52632 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has 52632 usecs TSC skew! FIXED.
BIOS BUG: CPU#4 improperly initialized, has -52632 usecs TSC skew! FIXED.
BIOS BUG: CPU#5 improperly initialized, has -52632 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has -52632 usecs TSC skew! FIXED.
BIOS BUG: CPU#7 improperly initialized, has -52633 usecs TSC skew! FIXED.
tecpu 1 has don0 init idl0, do246>c u_idot tai 0idle
ee doin0000u_idle().
00cpu 09  s done idat i0   edoinf cau_00
().
   i: cpu 6 has done  00000d1e  doin: f7d_idl8   
dydinitieli  ds                                  sp:Cf7dadab0e
                3CPU#  slready initialiess 
apperblp1>: 0, sta4,pagreaddlre00)presenack: >c01e<Uc0 l0000 to4ha0dl00ha1d po26
2900 ointe5f36 00000246 00000001 c021def0 
       00000282 00000001 00000015 00000000 c0295ef5 c0295ef7 c0118910 00000c2d 
       00000004 00000000 00000000 c023624f 
Call Trace: [<c0118910>] 

Code:  Bad EIP value.
 in0>Kernop randc: A00
pted to k 2
            tEI i  e ta10!
                          <c0I3 ed2e]   k - noainteding
F AGS: 00010002
eax: 00000029   ebx: 00010007   ecx: c021df08   edx: 00003ffc
esi: c0233b1a   edi: 0000001e   ebp: f7db5fa8   esp: f7da9fb0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=f7da9000)
Stack: c01ee3c0 00000002 00000002 c0262a00 c0235f36 00000246 00000001 c021def0 
       00000282 00000001 00000015 00000000 c0295ef5 c0295ef7 c0118910 00000c35 
       00000006 00000000 00000000 c023624f 
Call Trace: [<c0118910>] 

Code: 0f 0b 83 c4 0c a1 84 74 2a c0 8d 90 c8 00 00 00 eb 0f 0f a3 
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing


