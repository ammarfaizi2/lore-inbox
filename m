Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281009AbRLQQO7>; Mon, 17 Dec 2001 11:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281005AbRLQQOu>; Mon, 17 Dec 2001 11:14:50 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:5822 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S281129AbRLQQOb>; Mon, 17 Dec 2001 11:14:31 -0500
Message-ID: <3C1E19E7.88C62DAC@redhat.com>
Date: Mon, 17 Dec 2001 11:14:31 -0500
From: Bob Matthews <bmatthews@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Cerberus testing of 2.4.17-rc1
In-Reply-To: <3C1A6E09.497899C7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Matthews wrote:
 
> Hardware:  8 x PIII, 16G RAM, 20G Swap, 2 x Sym53c899.
> Kernel: 2.4.17-rc1, configured with SMP, HIGHMEM=64G, plus necessary
> drivers.
> 
> After 10-30 minutes of testing (it's different each time) the machine
> starts to slow down.  Eventually, the machine appears to stall
> completely.  The timer for the test harness continues to tick, and I can
> change virtual consoles, so the machine is not completely hung.  When
> the machine gets into this state, the test suite stops making progress.
> Also, input typed to the virtual consoles is not echoed.
> 
> <SysRq><P> <T> and <M> print only the column headings, but not any data,
> so that is as complete a bug report as I can give you at this time.

The machine never made any more observable progress, and eventually
oopsed after approx. 48 hours.

invalid operand: 0000
CPU:    5
EIP:    0010:[<c012c082>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c6000000   ecx: c600001c   edx: d35e3bdc
esi: d35e3bdc   edi: 00000013   ebp: 00000002   esp: f6bf9d80
ds: 0018   es: 0018   ss: 0018
Process memtst (pid: 854, stackpage=f6bf9000)
Stack: 00000020 000001d2 00000006 00000020 c012c124 0000002c c02f9bd0
00000006 
       000001d2 c02f9bd0 00000000 c012c18c 00000020 f6bf8000 000001d2
c02f9bd0 
       c012ca3e 00000000 00000000 c02f9ca8 0000021f 00000000 00000010
c012ccab 
Call Trace: [<c012c124>] [<c012c18c>] [<c012ca3e>] [<c012ccab>]
[<c012d2d4>] 
   [<c012272b>] [<c0122776>] [<c0122ce4>] [<c0110237>] [<c010b55a>]
[<c01125aa>] 
   [<c019e1dc>] [<c0118f0d>] [<c011bf36>] [<c011c186>] [<c0113559>]
[<c01123f0>] 
   [<c010700c>] 
Code: 0f 0b 8d b6 00 00 00 00 8d bf 00 00 00 00 8b 43 18 a9 80 00 

>>EIP; c012c082 <refill_inactive+a2/100>   <=====
Trace; c012c124 <shrink_caches+44/80>
Trace; c012c18c <try_to_free_pages+2c/50>
Trace; c012ca3e <balance_classzone+5e/1b0>
Trace; c012ccab <__alloc_pages+11b/180>
Trace; c012d2d4 <read_swap_cache_async+64/a0>
Trace; c012272b <swapin_readahead+3b/50>
Trace; c0122776 <do_swap_page+36/180>
Trace; c0122ce4 <handle_mm_fault+a4/120>
Trace; c0110237 <smp_call_function_interrupt+27/40>
Trace; c010b55a <call_call_function_interrupt+5/b>
Trace; c01125aa <do_page_fault+1ba/580>
Trace; c019e1dc <batch_entropy_process+ac/b0>
Trace; c0118f0d <__run_task_queue+5d/70>
Trace; c011bf36 <update_wall_time+16/50>
Trace; c011c186 <timer_bh+36/2b0>
Trace; c0113559 <schedule+459/510>
Trace; c01123f0 <do_page_fault+0/580>
Trace; c010700c <error_code+34/3c>
Code;  c012c082 <refill_inactive+a2/100>
00000000 <_EIP>:
Code;  c012c082 <refill_inactive+a2/100>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c084 <refill_inactive+a4/100>
   2:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c012c08a <refill_inactive+aa/100>
   8:   8d bf 00 00 00 00         lea    0x0(%edi),%edi
Code;  c012c090 <refill_inactive+b0/100>
   e:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012c093 <refill_inactive+b3/100>
  11:   a9 80 00 00 00            test   $0x80,%eax


-- 
Bob Matthews
Red Hat, Inc.
