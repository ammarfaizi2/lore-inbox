Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbUARUfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 15:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUARUfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 15:35:41 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:33168 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S263518AbUARUfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 15:35:01 -0500
Date: Sun, 18 Jan 2004 21:34:59 +0100
From: Sander <sander@humilis.net>
To: Sander <sander@humilis.net>
Cc: Andi Kleen <ak@colin2.muc.de>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: several oopses during boot (was: Re: [PATCH] Add CONFIG for -mregparm=3)
Message-ID: <20040118203459.GB8500@favonius>
Reply-To: sander@humilis.net
References: <20040114090603.GA1935@averell> <20040117201639.GA16420@favonius> <20040117205302.GA16658@colin2.muc.de> <20040117210715.GA15172@favonius> <20040117212857.GA28114@colin2.muc.de> <20040118054442.GA32278@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118054442.GA32278@favonius>
X-Uptime: 21:05:09 up 32 days, 10:53, 40 users,  load average: 1.50, 1.20, 1.20
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote (ao):
> Andi Kleen wrote (ao):
> > On Sat, Jan 17, 2004 at 10:07:15PM +0100, Sander wrote:
> > > > > Without the REGPARM option the system boots and runs fine.
> > > > > 
> > > > > Should I post the oopses, the result of ksymoops, a dmesg and
> > > > > kernel config or is this an already known issue?
> > > > 
> > > > Not known. Please post the decoded oopses.  Also give your
> > > > compiler version.
> > > 
> > > Hope this helps. The system runs fine with the option disabled.
> > 
> > Can you perhaps save your .config, do a make distclean and try
> > to compile the kernel from scratch again? Maybe you had some stale
> > object files around. 
> 
> I'm terrible sorry to say that I can't reproduce the oopses
> anymore ..  :-(  Maybe something went wrong during the tftp of the
> kernel, or I made a mistake ..
> 
> Sorry for wasting your time ..

I got another oops now, and discovered that I had kksymoops (KALLSYMS)
already enabled as Mike requested.

kernel 2.6.1-mm4, C3 cpu (via mini-itx mobo)
gcc (GCC) 3.3.3 20040110 (prerelease) (Debian)

I have no idea if it is hardware or software related, and if it has got
anything to do with the REGPARM option, but I entered this thread
because the kernel oopsed the first time I booted it and the first time
I enabled this option.

Btw, I always do rm -rf linux-2.6.1 ; tar jxf linux-2.6.1.tar.bz2 etc
before a compile.

I'll provide the .config if needed, but thought this message is long
enough already. Is this report of any use?

This is the oops I got now when doing an apt-get install. It was idle for
some hours after an afternoon of stress testing:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c029fa14
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c029fa14>]    Not tainted VLI
EFLAGS: 00010282
EIP is at proc_dodebug+0xa74/0x10c0
eax: fffffed0   ebx: 00000000   ecx: 00000003   edx: db098d20
esi: db098d3a   edi: cc380010   ebp: 000004f8   esp: c0357ce4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0356000 task=c02eba60)
Stack: 000000d0 000005c8 000000d0 c0248c60 db098d2a cc380000 000000d0 00000000 
       00000000 00000000 00000001 00000000 c0357da0 c0126bba 00000000 00000001 
       000000d0 00001000 00000b90 00001088 c0248dec dacd1be0 000004f8 cc380000 skb_copy_and_csum_bits+0x50/0x2a0
 [<c0126bba>] update_process_times+0x2a/0x30
 [<c0248dec>] skb_copy_and_csum_bits+0x1dc/0x2a0
 [<c0291828>] skb_read_and_csum_bits+0x28/0x60
 [<c029b025>] xdr_partial_copy_from_skb+0x105/0x150
 [<c02918b4>] csum_partial_copy_to_xdr+0x54/0x100
 [<c0291800>] skb_read_and_csum_bits+0x0/0x60
 [<c0291a75>] udp_data_ready+0x115/0x1f0
 [<c027db48>] 

(ends here)

And this are the first few oopses from yesterdays report during startup:

Unable to handle kernel paging request at virtual address 249579f8
 printing eip:
c012c19d
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c012c19d>]    Not tainted VLI
EFLAGS: 00010046
EIP is at sys_setsid+0x7d/0xa0
eax: c1557940   ebx: c1554000   ecx: c1557a4c   edx: c1557990
esi: 0000000d   edi: bffffaa0   ebp: c1554000   esp: c1555fb8
ds: 007b   es: 007b   ss: 0068
Process init (pid: 13, threadinfo=c1554000 task=c1557940)
Stack: bffffba0 bffffb20 c02a01d7 bffffba0 00002323 23232323 bffffb20 bffffaa0 
       bffffcc8 00000042 0000007b 0000007b 00000042 400c8b17 00000073 00000202 
       bffff9fc 0000007b 
Call Trace:
 [<c02a01d7>] syscall_call+0x7/0xb

Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8
 printing eip:
c012c19d
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c012c19d>]    Not tainted VLI
EFLAGS: 00010046
EIP is at sys_setsid+0x7d/0xa0
eax: c1557940   ebx: c1554000   ecx: c1557a4c   edx: c1557990
esi: 0000000e   edi: bffffaa0   ebp: c1554000   esp: c1555fb8
ds: 007b   es: 007b   ss: 0068
Process init (pid: 14, threadinfo=c1554000 task=c1557940)
Stack: bffffba0 bffffb20 c02a01d7 bffffba0 61630053 32323232 bffffb20 bffffaa0 
       bffffcc8 00000042 0000007b 0000007b 00000042 400c8b17 00000073 00000246 
       bffff9fc 0000007b 
Call Trace:
 [<c02a01d7>] syscall_call+0x7/0xb

Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8
 printing eip:
c012c19d
*pde = 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<c012c19d>]    Not tainted VLI
EFLAGS: 00010046
EIP is at sys_setsid+0x7d/0xa0
eax: c1557940   ebx: c1554000   ecx: c1557a4c   edx: c1557990
esi: 0000000f   edi: bffffaa0   ebp: c1554000   esp: c1555fb8
ds: 007b   es: 007b   ss: 0068
Process init (pid: 15, threadinfo=c1554000 task=c1557940)
Stack: bffffba0 bffffb20 c02a01d7 bffffba0 61630053 32323232 bffffb20 bffffaa0 
       bffffcc8 00000042 0000007b 0000007b 00000042 400c8b17 00000073 00000246 
       bffff9fc 0000007b 
Call Trace:
 [<c02a01d7>] syscall_call+0x7/0xb

Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8
 printing eip:
c012c19d
*pde = 00000000
Oops: 0000 [#4]
CPU:    0
EIP:    0060:[<c012c19d>]    Not tainted VLI
EFLAGS: 00010046
EIP is at sys_setsid+0x7d/0xa0
eax: c1557940   ebx: c1554000   ecx: c1557a4c   edx: c1557990
esi: 00000010   edi: bffffaa0   ebp: c1554000   esp: c1555fb8
ds: 007b   es: 007b   ss: 0068
Process init (pid: 16, threadinfo=c1554000 task=c1557940)
Stack: bffffba0 bffffb20 c02a01d7 bffffba0 61630053 32323232 bffffb20 bffffaa0 
       bffffcc8 00000042 0000007b 0000007b 00000042 400c8b17 00000073 00000246 
       bffff9fc 0000007b 
Call Trace:
 [<c02a01d7>] syscall_call+0x7/0xb

Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8
 printing eip:
c012c19d
*pde = 00000000
Oops: 0000 [#5]
CPU:    0
EIP:    0060:[<c012c19d>]    Not tainted VLI
EFLAGS: 00010046
EIP is at sys_setsid+0x7d/0xa0
eax: c1557940   ebx: c1554000   ecx: c1557a4c   edx: c1557990
esi: 00000011   edi: bffffaa0   ebp: c1554000   esp: c1555fb8
ds: 007b   es: 007b   ss: 0068
Process init (pid: 17, threadinfo=c1554000 task=c1557940)
Stack: bffffba0 bffffb20 c02a01d7 bffffba0 61630053 32323232 bffffb20 bffffaa0 
       bffffcc8 00000042 0000007b 0000007b 00000042 400c8b17 00000073 00000246 
       bffff9fc 0000007b 
Call Trace:
 [<c02a01d7>] syscall_call+0x7/0xb

Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8
 printing eip:
c012c19d
*pde = 00000000
Oops: 0000 [#6]
CPU:    0
EIP:    0060:[<c012c19d>]    Not tainted VLI
EFLAGS: 00010046
EIP is at sys_setsid+0x7d/0xa0
eax: c1557940   ebx: c1554000   ecx: c1557a4c   edx: c1557990
esi: 00000012   edi: bffffaa0   ebp: c1554000   esp: c1555fb8
ds: 007b   es: 007b   ss: 0068
Process init (pid: 18, threadinfo=c1554000 task=c1557940)
Stack: bffffba0 bffffb20 c02a01d7 bffffba0 61630053 32323232 bffffb20 bffffaa0 
       bffffcc8 00000042 0000007b 0000007b 00000042 400c8b17 00000073 00000246 
       bffff9fc 0000007b 
Call Trace:
 [<c02a01d7>] syscall_call+0x7/0xb

Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8
 printing eip:
c012c19d
*pde = 00000000
Oops: 0000 [#7]
CPU:    0
EIP:    0060:[<c012c19d>]    Not tainted VLI
EFLAGS: 00010046
EIP is at sys_setsid+0x7d/0xa0
eax: c1557940   ebx: c1554000   ecx: c1557a4c   edx: c1557990
esi: 00000013   edi: bffffaa0   ebp: c1554000   esp: c1555fb8
ds: 007b   es: 007b   ss: 0068
Process init (pid: 19, threadinfo=c1554000 task=c1557940)
Stack: bffffba0 bffffb20 c02a01d7 bffffba0 61630053 32323232 bffffb20 bffffaa0 
       bffffcc8 00000042 0000007b 0000007b 00000042 400c8b17 00000073 00000246 
       bffff9fc 0000007b 
Call Trace:
 [<c02a01d7>] syscall_call+0x7/0xb

Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8
 printing eip:
c012c19d
*pde = 00000000
Oops: 0000 [#8]
CPU:    0
EIP:    0060:[<c012c19d>]    Not tainted VLI
EFLAGS: 00010046
EIP is at sys_setsid+0x7d/0xa0
eax: c1557940   ebx: c1554000   ecx: c1557a4c   edx: c1557990
esi: 00000014   edi: bffffaa0   ebp: c1554000   esp: c1555fb8
ds: 007b   es: 007b   ss: 0068
Process init (pid: 20, threadinfo=c1554000 task=c1557940)
Stack: bffffba0 bffffb20 c02a01d7 bffffba0 61630053 32323232 bffffb20 bffffaa0 
       bffffcc8 00000042 0000007b 0000007b 00000042 400c8b17 00000073 00000246 
       bffff9fc 0000007b 
Call Trace:
 [<c02a01d7>] syscall_call+0x7/0xb


-- 
Humilis IT Services and Solutions
http://www.humilis.net
