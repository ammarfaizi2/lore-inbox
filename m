Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268047AbTCFNGH>; Thu, 6 Mar 2003 08:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268039AbTCFNGH>; Thu, 6 Mar 2003 08:06:07 -0500
Received: from rzserv1.gsi.de ([140.181.96.11]:35576 "EHLO rzserv1.gsi.de")
	by vger.kernel.org with ESMTP id <S268032AbTCFNFq>;
	Thu, 6 Mar 2003 08:05:46 -0500
Message-ID: <3E674A13.5020203@GSI.de>
Date: Thu, 06 Mar 2003 14:16:03 +0100
From: ChristopherHuhn <c.huhn@gsi.de>
Organization: GSI
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: de-de, en-us, fr-fr
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: linux-smp <linux-smp@vger.kernel.org>, linux-kernel@vger.kernel.org,
       Walter Schoen <w.schoen@GSI.de>, support-gsi@credativ.de
Subject: Re: Kernel Bug at spinlock.h ?!
References: <Pine.LNX.3.95.1030303103332.22802A-100000@chaos> <3E637CDC.3030409@GSI.de> <Pine.LNX.4.50.0303031248220.29455-100000@montezuma.mastecende.com> <3E64B0EA.4080109@GSI.de> <Pine.LNX.4.50.0303042133170.5867-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0303042133170.5867-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

>It looks like a possible race with rpc_execute and possibly the timer, 
>although i can't be certain where the other cpus are. Do the other oopses 
>look somewhat similar? Could you supply them?
>  
>
below are some oopses I gathered yesterday and today, all on different 
machines.
I'd like to remark that we experience massive NFS problems at the moment 
that seem to be caused by our mixed potato 2.2/ woody 2.4 environment, 
i. e. linking apps on a woody system with the sources  mounted via nfs 
from a potato box leads to obscure IO failures like "no space left on 
device" (This never happens with woddy only). So this might be a clue 
here as well.

The oopses are all written down from the screen, I hopefully made little 
"transmission" errors.


Unable to handle kernel paging request at virtual address 5a5a5a5a
5a5a5a5a
*pde = 00000000
Oops: 0000
CPU:  0
EIP: 0010:[<5a5a5a5a>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000002   ebx: 5a5a5a5a     ecx: c03d0208       edx: 00000000
esi: c4c8f124   edi: 00000001     ebp: c8b7be14       esp: c8b7be00
ds: 0018        es: 0018       ss: 0018
Process cp (pid: 15914, stackpage=c8b7b000)
Stack:  c02aca63 c4c8f124 c4c8f124 c02ac908 00000000 c8b7be4c c012566b 
c4c8f124
        00000000 00000000 00000000 00000001 00000000 c03d0600 c03f2c4c 
c03f2c4c
        c8b7be4c daf70d08 f7ed0eec c8b7be58 c01213ba c03d0600 c8b7be70 
c0121283
Call Trace:    [<c02aca63>] [<c02ac980>] [<c012566b>] [<c01213ba>] 
[<c0121283>]
  [<c0120fdd>] [<c010ac4c>] [<c0130da3>] [<c0130889>] [<c0130e8b>] 
[<c0130d38>]
  [<c018a3ff>] [<c0141a08>] [<c01090cf>]
Code: Bad EIP value.


 >>EIP; 5a5a5a5a Before first symbol   <=====

 >>ebx; 5a5a5a5a Before first symbol
 >>ecx; c03d0208 <irq_stat+8/400>
 >>esi; c4c8f124 <_end+4877160/384eb09c>
 >>ebp; c8b7be14 <_end+8763e50/384eb09c>
 >>esp; c8b7be00 <_end+8763e3c/384eb09c>

Trace; c02aca63 <rpc_run_timer+e3/f0>
Trace; c02ac980 <rpc_run_timer+0/f0>
Trace; c012566b <timer_bh+2ff/488>
Trace; c01213ba <bh_action+52/e0>
Trace; c0121283 <tasklet_hi_action+63/a0>
Trace; c0120fdd <do_softirq+5d/e0>
Trace; c010ac4c <do_IRQ+198/1a8>
Trace; c0130da3 <file_read_actor+6b/d8>
Trace; c0130889 <do_generic_file_read+255/504>
Trace; c0130e8b <generic_file_read+7b/10c>
Trace; c0130d38 <file_read_actor+0/d8>
Trace; c018a3ff <nfs_file_read+9b/ac>
Trace; c0141a08 <sys_read+98/188>
Trace; c01090cf <system_call+33/38>

 <0>Kernel panic: Aiee, killing interrupt handler!



Call Trace: [<c02c6783>][<c02c66a0>][<c012564b>][<c012139a>][<c0121263>]
Code: 02 00 00 00 40 01 00 00 00 00 00 00 00 00 00 c0 80 3d 35 c0
Using defaults from ksymoops -t elf32-i386 -a i386


Trace; c02c6783 <rpc_run_timer+e3/f0>
Trace; c02c66a0 <rpc_run_timer+0/f0>
Trace; c012564b <timer_bh+2ff/488>
Trace; c012139a <bh_action+52/e0>
Trace; c0121263 <tasklet_hi_action+63/a0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   02 00                     add    (%eax),%al
Code;  00000002 Before first symbol
   2:   00 00                     add    %al,(%eax)
Code;  00000004 Before first symbol
   4:   40                        inc    %eax
Code;  00000005 Before first symbol
   5:   01 00                     add    %eax,(%eax)
Code;  0000000f Before first symbol
   f:   c0 80 3d 35 c0 00 00      rolb   $0x0,0xc0353d(%eax)




Unable to handle kernel NULL pointer dereferende at virtual address 00000002
f6a9dd50
*pde = 00000000
Oops: 0002
CPU:  0
EIP: 0010:[<f6a9dd50>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000002   ebx: f6a9dd50     ecx: c03f9208       edx: 00000000
esi: f6a9dce4   edi: 00000001     ebp: f7ee7ecc       esp: f7ee7eb8
ds: 0018        es: 0018       ss: 0018
Process ksoftirqd_CPU0 (pid: 3, stackpage=f7ee7000)
Stack:  c02c6783 f6a9dce4 f6a9dce4 c02c66a0 00000000 f7ee7f04 c012564b 
f6a9dce4
        00000000 00000000 00000000 00000001 00000000 c03f9600 c041c30c 
c041c30c
        f7ee7f04 f64e9f28 f7ed0eec f7ee7f10 c012139a c03f9600 f7ee7f28 
c0121263
Call Trace:    [<c02c6783>] [<c02c66a0>] [<c012564b>] [<c012139a>] 
[<c0121263>]
  [<c0120fdd>] [<c010ac2c>] [<c0117e93>] [<c01215ce>] [<c0107448>]
Code: 00 10 e9 f7 78 dd a9 f6 18 af 28 c0 c4 1c e5 f7 00 00 00 00


 >>EIP; f6a9dd50 <_end+3665c5ec/384c18fc>   <=====

 >>ebx; f6a9dd50 <_end+3665c5ec/384c18fc>
 >>ecx; c03f9208 <irq_stat+8/400>
 >>esi; f6a9dce4 <_end+3665c580/384c18fc>
 >>ebp; f7ee7ecc <_end+37aa6768/384c18fc>
 >>esp; f7ee7eb8 <_end+37aa6754/384c18fc>

Trace; c02c6783 <rpc_run_timer+e3/f0>
Trace; c02c66a0 <rpc_run_timer+0/f0>
Trace; c012564b <timer_bh+2ff/488>
Trace; c012139a <bh_action+52/e0>
Trace; c0121263 <tasklet_hi_action+63/a0>
Trace; c0120fdd <do_softirq+7d/e0>
Trace; c010ac2c <do_IRQ+198/1a8>
Trace; c0117e93 <schedule+2e3/710>
Trace; c01215ce <ksoftirqd+92/cc>
Trace; c0107448 <kernel_thread+28/38>

Code;  f6a9dd50 <_end+3665c5ec/384c18fc>
00000000 <_EIP>:
Code;  f6a9dd50 <_end+3665c5ec/384c18fc>   <=====
   0:   00 10                     add    %dl,(%eax)   <=====
Code;  f6a9dd52 <_end+3665c5ee/384c18fc>
   2:   e9 f7 78 dd a9            jmp    a9dd78fe <_EIP+0xa9dd78fe> 
a087564e Before first symbol
Code;  f6a9dd57 <_end+3665c5f3/384c18fc>
   7:   f6 18                     negb   (%eax)
Code;  f6a9dd59 <_end+3665c5f5/384c18fc>
   9:   af                        scas   %es:(%edi),%eax
Code;  f6a9dd5a <_end+3665c5f6/384c18fc>
   a:   28 c0                     sub    %al,%al
Code;  f6a9dd5c <_end+3665c5f8/384c18fc>
   c:   c4 1c e5 f7 00 00 00      les    0xf7(,8),%ebx



Unable to handle kernel paging request at virtual address 5a5a5a5a
5a5a5a5a
*pde = 00000000
Oops: 0000
CPU:  0
EIP: 0010:[<5a5a5a5a>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000002   ebx: 5a5a5a5a     ecx: c03d0208       edx: 00000000
esi: f28b23e4   edi: 00000001    ebp: ed151f1c      esp: ed151f08
ds: 0018        es: 0018       ss: 0018
Process ncsh.exe (pid: 8328, stackpage=ed151000)
Stack:  c02c6783 f28b23e4 f28b23e4 c02c66a0 00000000 ed151f54 c012564b 
f28b23e4
        00000000 00000000 00000000 00000001 00000000 c03f9600 c041c30c 
c041c30c
        ed151f54 f28b2588 f7ed0eec ed151f60 c012139a c03f9600 ed151f78 
c0121263
Call Trace:    [<c02c6783>] [<c02c66a0>] [<c012564b>] [<c012139a>] 
[<c0121263>]
  [<c0120fdd>] [<c010ac2c>]
Code: Bad EIP value.


 >>EIP; 5a5a5a5a Before first symbol   <=====

 >>ebx; 5a5a5a5a Before first symbol
 >>ecx; c03d0208 <softnet_data+6e8/3400>
 >>esi; f28b23e4 <_end+32470c80/384c18fc>
 >>ebp; ed151f1c <_end+2cd107b8/384c18fc>
 >>esp; ed151f08 <_end+2cd107a4/384c18fc>

Trace; c02c6783 <rpc_run_timer+e3/f0>
Trace; c02c66a0 <rpc_run_timer+0/f0>
Trace; c012564b <timer_bh+2ff/488>
Trace; c012139a <bh_action+52/e0>
Trace; c0121263 <tasklet_hi_action+63/a0>
Trace; c0120fdd <do_softirq+7d/e0>
Trace; c010ac2c <do_IRQ+198/1a8>

 <0>Kernel panic: Aiee, killing interrupt handler!



Unable to handle kernel NULL pointer dereferende at virtual address 00000002
f7467d5c
*pde = 00000000
Oops: 0002
CPU:  0
EIP: 0010:[<f7467d5c>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000002   ebx: f7467d5c     ecx: c03f9208       edx: 00000000
esi: f7467cf0   edi: 00000001     ebp: f7ee7ecc       esp: f7ee7eb8
ds: 0018        es: 0018       ss: 0018
Process ksoftirqd_CPU0 (pid: 3, stackpage=f7ee7000)
Stack:  c02c6783 f7467cf0 f7467cf0 c02c66a0 1320dcce f7ee7f04 c012564b 
f7467cf0
        00000000 00000000 c03f9614 00000000 c042e864 f7ed0ed4 c0361da8 
f7ee7f1c
        c01f59f4 f7467f28 f7ed0eec f7ee7f10 c012139a c03f9600 f7ee7f28 
c0121263
Call Trace:    [<c02c6783>] [<c02c66a0>] [<c012564b>] [<c01f59f4>] 
[<c012139a>]
  [<c0121263>] [<c0120fdd>] [<c010ac2c>] [<c0117eb7>] [<c01215ce>] 
[<c0107448>]
Code: 00 10 e9 f7 84 7d 46 f7 18 af 28 c0 c4 1c e5 f7 00 00 00 00


 >>EIP; f7467d5c <_end+370265f8/384c18fc>   <=====

 >>ebx; f7467d5c <_end+370265f8/384c18fc>
 >>ecx; c03f9208 <irq_stat+8/400>
 >>esi; f7467cf0 <_end+3702658c/384c18fc>
 >>ebp; f7ee7ecc <_end+37aa6768/384c18fc>
 >>esp; f7ee7eb8 <_end+37aa6754/384c18fc>

Trace; c02c6783 <rpc_run_timer+e3/f0>
Trace; c02c66a0 <rpc_run_timer+0/f0>
Trace; c012564b <timer_bh+2ff/488>
Trace; c01f59f4 <ide_intr+1c0/284>
Trace; c012139a <bh_action+52/e0>
Trace; c0121263 <tasklet_hi_action+63/a0>
Trace; c0120fdd <do_softirq+7d/e0>
Trace; c010ac2c <do_IRQ+198/1a8>
Trace; c0117eb7 <schedule+307/710>
Trace; c01215ce <ksoftirqd+92/cc>
Trace; c0107448 <kernel_thread+28/38>

Code;  f7467d5c <_end+370265f8/384c18fc>
00000000 <_EIP>:
Code;  f7467d5c <_end+370265f8/384c18fc>   <=====
   0:   00 10                     add    %dl,(%eax)   <=====
Code;  f7467d5e <_end+370265fa/384c18fc>
   2:   e9 f7 84 7d 46            jmp    467d84fe <_EIP+0x467d84fe> 
3dc4025a Before first symbol
Code;  f7467d63 <_end+370265ff/384c18fc>
   7:   f7 18                     negl   (%eax)
Code;  f7467d65 <_end+37026601/384c18fc>
   9:   af                        scas   %es:(%edi),%eax
Code;  f7467d66 <_end+37026602/384c18fc>
   a:   28 c0                     sub    %al,%al
Code;  f7467d68 <_end+37026604/384c18fc>
   c:   c4 1c e5 f7 00 00 00      les    0xf7(,8),%ebx



Unable to handle kernel NULL pointer dereferende at virtual address 00000002
f6df1d50
*pde = 00000000
Oops: 0002
CPU:  0
EIP: 0010:[<f6df1d50>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000002   ebx: f6df1d50     ecx: c03f9208       edx: 00000000
esi: f6df1ce4   edi: 00000001     ebp: ce1bdf1c       esp: ce1bdf08
ds: 0018        es: 0018       ss: 0018
Process ncsh.exe (pid: 18791, stackpage=ce1bd000)
Stack:  c02c6783 f6df1ce4 f6df1ce4 c02c66a0 00000000 ce1bdf54 c012564b 
f6df1ce4
        00000000 00000000 00000000 00000001 00000000 c03f9600 c041c30c 
c041c30c
        ce1bdf54 f6df00e8 f7ed0eec ce1bdf60 c012139a c03f9600 ce1bdf78 
c0121263
Call Trace:    [<c02c6783>] [<c02c66a0>] [<c012564b>] [<c012139a>] 
[<c0121263>]
  [<c0120fdd>] [<c010ac2c>]
Code: 00 10 e9 f7 78 1d df f6 18 af 28 c0 c4 1c e5 f7 00 00 00 00


 >>EIP; f6df1d50 <_end+369b05ec/384c18fc>   <=====

 >>ebx; f6df1d50 <_end+369b05ec/384c18fc>
 >>ecx; c03f9208 <irq_stat+8/400>
 >>esi; f6df1ce4 <_end+369b0580/384c18fc>
 >>ebp; ce1bdf1c <_end+dd7c7b8/384c18fc>
 >>esp; ce1bdf08 <_end+dd7c7a4/384c18fc>

Trace; c02c6783 <rpc_run_timer+e3/f0>
Trace; c02c66a0 <rpc_run_timer+0/f0>
Trace; c012564b <timer_bh+2ff/488>
Trace; c012139a <bh_action+52/e0>
Trace; c0121263 <tasklet_hi_action+63/a0>
Trace; c0120fdd <do_softirq+7d/e0>
Trace; c010ac2c <do_IRQ+198/1a8>

Code;  f6df1d50 <_end+369b05ec/384c18fc>
00000000 <_EIP>:
Code;  f6df1d50 <_end+369b05ec/384c18fc>   <=====
   0:   00 10                     add    %dl,(%eax)   <=====
Code;  f6df1d52 <_end+369b05ee/384c18fc>
   2:   e9 f7 78 1d df            jmp    df1d78fe <_EIP+0xdf1d78fe> 
d5fc964e <_end+15b87eea/384c18fc>
Code;  f6df1d57 <_end+369b05f3/384c18fc>
   7:   f6 18                     negb   (%eax)
Code;  f6df1d59 <_end+369b05f5/384c18fc>
   9:   af                        scas   %es:(%edi),%eax
Code;  f6df1d5a <_end+369b05f6/384c18fc>
   a:   28 c0                     sub    %al,%al
Code;  f6df1d5c <_end+369b05f8/384c18fc>
   c:   c4 1c e5 f7 00 00 00      les    0xf7(,8),%ebx

 <0>Kernel panic: Aiee, killing interrupt handler!



Unable to handle kernel paging request at virtual address 00010000
00010000
*pde = 00000000
Oops: 0000
CPU:  0
EIP: 0010:[<00010000>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000002   ebx: 00010000     ecx: c03f9208       edx: 00000000
esi: d44a7cf0   edi: 00000001     ebp: e2c69d84       esp: e2c69d70
ds: 0018        es: 0018       ss: 0018
Process rhomesu2b.x (pid: 29390, stackpage=e2c69000)
Stack:  c02c6783 d44a7cf0 d44a7cf0 c02c66a0 c03f9614 e2c69dbc c012564b 
d44a7cf0
        00000000 00000000 c03f9614 c03cfb50 00000000 12286799 00000040 
00000001
        e2c69de0 d44a7d04 f7ed0eec e2c69dc8 c012139a c03f9600 e2c69de0 
c0121263
Call Trace:    [<c02c6783>] [<c02c66a0>] [<c012564b>] [<c012139a>] 
[<c0121263>]
  [<c0120fdd>] [<c010ac2c>] [<c010f223>] [<c01086cc>] [<c01087f9>] 
[<c0108bb1>]
  [<c0108f38>] [<c0120fdd>] [<c010ac2c>] [<c01090f0>]
Code: Bad EIP value.


 >>EIP; 00010000 Before first symbol   <=====

 >>ebx; 00010000 Before first symbol
 >>ecx; c03f9208 <irq_stat+8/400>
 >>esi; d44a7cf0 <_end+1406658c/384c18fc>
 >>ebp; e2c69d84 <_end+22828620/384c18fc>
 >>esp; e2c69d70 <_end+2282860c/384c18fc>

Trace; c02c6783 <rpc_run_timer+e3/f0>
Trace; c02c66a0 <rpc_run_timer+0/f0>
Trace; c012564b <timer_bh+2ff/488>
Trace; c012139a <bh_action+52/e0>
Trace; c0121263 <tasklet_hi_action+63/a0>
Trace; c0120fdd <do_softirq+7d/e0>
Trace; c010ac2c <do_IRQ+198/1a8>
Trace; c010f223 <save_i387+37/230>
Trace; c01086cc <setup_sigcontext+dc/12c>
Trace; c01087f9 <setup_frame+dd/1b4>
Trace; c0108bb1 <handle_signal+71/154>
Trace; c0108f38 <do_signal+2a4/2ed>
Trace; c0120fdd <do_softirq+7d/e0>
Trace; c010ac2c <do_IRQ+198/1a8>
Trace; c01090f0 <signal_return+14/18>

 <0>Kernel panic: Aiee, killing interrupt handler!



Unable to handle kernel paging request at virtual address 5a5a5a5a
5a5a5a5a
*pde = 00000000
Oops: 0000
CPU:  0
EIP: 0010:[<5a5a5a5a>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000002   ebx: 5a5a5a5a     ecx: c03d0208       edx: 00000000
esi: e27cb7d4   edi: 00000001     ebp: f7ee7f5c       esp: f7ee7f48
ds: 0018        es: 0018       ss: 0018
Process ksoftirqd_CPU0 (pid: 3, stackpage=f7ee7000)
Stack:  c02aca63 e27cb7d4 e27cb7d4 c02ac908 00000000 f7ee7f94 c012566b 
e27cb7d4
        00000000 00000000 00000000 00000001 00000000 c03d0600 c03f2c4c 
c03f2c4c
        f7ee7f94 e1902c18 f7ed0eec f7ee7fa0 c01213ba c03d0600 f7ee7fb8 
c0121283
Call Trace:    [<c02aca63>] [<c02ac980>] [<c012566b>] [<c01213ba>] 
[<c0121283>]
  [<c0120fdd>] [<c0121609>] [<c0107448>]
Code: Bad EIP value.


 >>EIP; 5a5a5a5a Before first symbol   <=====

 >>ebx; 5a5a5a5a Before first symbol
 >>ecx; c03d0208 <irq_stat+8/400>
 >>esi; e27cb7d4 <_end+223b3810/384eb09c>
 >>ebp; f7ee7f5c <_end+37acff98/384eb09c>
 >>esp; f7ee7f48 <_end+37acff84/384eb09c>

Trace; c02aca63 <rpc_run_timer+e3/f0>
Trace; c02ac980 <rpc_run_timer+0/f0>
Trace; c012566b <timer_bh+2ff/488>
Trace; c01213ba <bh_action+52/e0>
Trace; c0121283 <tasklet_hi_action+63/a0>
Trace; c0120fdd <do_softirq+5d/e0>
Trace; c0121609 <ksoftirqd+ad/cc>
Trace; c0107448 <kernel_thread+28/38>

 <0>Kernel panic: Aiee, killing interrupt handler!



Unable to handle kernel NULL pointer dereferende at virtual address ffffffff
ffffffff
*pde = 00003063
Oops: 0000
CPU:  0
EIP: 0010:[<ffffffff>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000002   ebx: ffffffff     ecx: c03f9208       edx: 00000000
esi: f70b1cb0   edi: 00000001     ebp: f77dddf4       esp: f77ddde0
ds: 0018        es: 0018       ss: 0018
Process timeoutd (pid: 556, stackpage=f77dd000)
Stack:  c02c6783 f70b1cb0 f70b1cb0 c02c66a0 00000000 f77dde2c c012564b 
f70b1cb0
        00000000 00000000 00000000 00000001 00000000 c03f9600 c041c30c 
c041c30c
        f77dde2c f70b1d44 f7ed0eec f77dde38 c012139a c03f9600 f77dde50 
c0121263
Call Trace:    [<c02c6783>] [<c02c66a0>] [<c012564b>] [<c012139a>] 
[<c0121263>]
  [<c0120fdd>] [<c010ac2c>] [<c0152056>] [<c014e6d8>] [<c014e719>] 
[<c014e8e6>]
  [<c014ef4b>] [<c0140eee>] [<c014124e>] [<c01090b7>]
Code: Bad EIP value.


 >>EIP; ffffffff <END_OF_CODE+76e343f/????>   <=====

 >>ebx; ffffffff <END_OF_CODE+76e343f/????>
 >>ecx; c03f9208 <irq_stat+8/400>
 >>esi; f70b1cb0 <_end+36c7054c/384c18fc>
 >>ebp; f77dddf4 <_end+3739c690/384c18fc>
 >>esp; f77ddde0 <_end+3739c67c/384c18fc>

Trace; c02c6783 <rpc_run_timer+e3/f0>
Trace; c02c66a0 <rpc_run_timer+0/f0>
Trace; c012564b <timer_bh+2ff/488>
Trace; c012139a <bh_action+52/e0>
Trace; c0121263 <tasklet_hi_action+63/a0>
Trace; c0120fdd <do_softirq+7d/e0>
Trace; c010ac2c <do_IRQ+198/1a8>
Trace; c0152056 <.text.lock.namei+9/4b3>
Trace; c014e6d8 <link_path_walk+c5c/c80>
Trace; c014e719 <path_walk+1d/24>
Trace; c014e8e6 <path_lookup+1e/2c>
Trace; c014ef4b <open_namei+6b/75c>
Trace; c0140eee <filp_open+3a/5c>
Trace; c014124e <sys_open+36/b4>
Trace; c01090b7 <system_call+2f/34>

 <0>Kernel panic: Aiee, killing interrupt handler!



Unable to handle kernel NULL pointer dereferende at virtual address 00000002
f1cddcfc
*pde = 00000000
Oops: 0002
CPU:  0
EIP: 0010:[<f1cddcfc>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000002   ebx: f1cddcfc     ecx: c03d0208      edx: 00000000
esi: f1cddcb0   edi: 00000001     ebp: c0375ee0       esp: c0375ecc
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 0, stackpage=c0375000)
Stack:  c02aca63 f1cddcb0 f1cddcb0 c02ac980 c03d063c c0375f18 c012566b 
f1cddcb0
        00000000 00000000 c03d063c 00000001 00000000 c03d0600 c03f2c4c 
c03f2c4c
        c0375f18 f68abd18 f7ed0eec c0375f24 c01213ba c03d0600 c0375f3c 
c0121283
Call Trace:    [<c02aca63>] [<c02ac980>] [<c012566b>] [<c01213ba>] 
[<c0121283>]
  [<c0120fdd>] [<c010ac4c>] [<c0106ff0>] [<c0106ff0>] [<c0106ff0>] 
[<c0106ff0>]
  [<c010701f>] [<c0107092>] [<c0105000>] [<c010507c>]
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 8d b6 00


 >>EIP; f1cddcfc <_end+318c5d38/384eb09c>   <=====

 >>ebx; f1cddcfc <_end+318c5d38/384eb09c>
 >>ecx; c03d0208 <irq_stat+8/400>
 >>esi; f1cddcb0 <_end+318c5cec/384eb09c>
 >>ebp; c0375ee0 <init_task_union+1ee0/2000>
 >>esp; c0375ecc <init_task_union+1ecc/2000>

Trace; c02aca63 <rpc_run_timer+e3/f0>
Trace; c02ac980 <rpc_run_timer+0/f0>
Trace; c012566b <timer_bh+2ff/488>
Trace; c01213ba <bh_action+52/e0>
Trace; c0121283 <tasklet_hi_action+63/a0>
Trace; c0120fdd <do_softirq+5d/e0>
Trace; c010ac4c <do_IRQ+198/1a8>
Trace; c0106ff0 <default_idle+0/38>
Trace; c0106ff0 <default_idle+0/38>
Trace; c0106ff0 <default_idle+0/38>
Trace; c0106ff0 <default_idle+0/38>
Trace; c010701f <default_idle+2f/38>
Trace; c0107092 <cpu_idle+42/58>
Trace; c0105000 <_stext+0/0>
Trace; c010507c <rest_init+7c/80>

Code;  f1cddcfc <_end+318c5d38/384eb09c>   <=====
00000000 <_EIP>:   <=====
Code;  f1cddd0c <_end+318c5d48/384eb09c>
  10:   a8 8d                     test   $0x8d,%al
Code;  f1cddd0e <_end+318c5d4a/384eb09c>
  12:   b6 00                     mov    $0x0,%dh

 <0>Kernel panic: Aiee, killing interrupt handler!



Unable to handle kernel NULL pointer dereferende at virtual address ffffffff
ffffffff
*pde = 00003063
Oops: 0000
CPU:  0
EIP: 0010:[<ffffffff>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000002   ebx: ffffffff     ecx: c03f9208       edx: 00000000
esi: f7a3fcb0   edi: 00000001     ebp: c039dee0       esp: c039decc
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 0, stackpage=c039d000)
Stack:  c02c6783 f7a3fcb0 f7a3fcb0 c02c66a0 00000000 c039df18 c012564b 
f7a3cfb0
        00000000 00000000 00000000 00000001 00000000 c03f9600 c041c30c 
c041c30c
        c039df18 f7a3fd44 f7ed0eec c039df24 c012139a c03f9600 c039fd3c 
c0121263
Call Trace:    [<c02c6783>] [<c02c66a0>] [<c012564b>] [<c012139a>] 
[<c0121263>]
  [<c0120fdd>] [<c010ac2c>] [<c0106ff0>] [<c0106ff0>] [<c0106ff0>] 
[<c0106ff0>]
  [<c010701f>] [<c0107092>] [<c0105000>] [<c010507c>]
Code: Bad EIP value.


 >>EIP; ffffffff <END_OF_CODE+76e343f/????>   <=====

 >>ebx; ffffffff <END_OF_CODE+76e343f/????>
 >>ecx; c03f9208 <irq_stat+8/400>
 >>esi; f7a3fcb0 <_end+375fe54c/384c18fc>
 >>ebp; c039dee0 <init_task_union+1ee0/2000>
 >>esp; c039decc <init_task_union+1ecc/2000>

Trace; c02c6783 <rpc_run_timer+e3/f0>
Trace; c02c66a0 <rpc_run_timer+0/f0>
Trace; c012564b <timer_bh+2ff/488>
Trace; c012139a <bh_action+52/e0>
Trace; c0121263 <tasklet_hi_action+63/a0>
Trace; c0120fdd <do_softirq+7d/e0>
Trace; c010ac2c <do_IRQ+198/1a8>
Trace; c0106ff0 <default_idle+0/38>
Trace; c0106ff0 <default_idle+0/38>
Trace; c0106ff0 <default_idle+0/38>
Trace; c0106ff0 <default_idle+0/38>
Trace; c010701f <default_idle+2f/38>
Trace; c0107092 <cpu_idle+42/58>
Trace; c0105000 <_stext+0/0>
Trace; c010507c <rest_init+7c/80>

 <0>Kernel panic: Aiee, killing interrupt handler!



Unable to handle kernel NULL pointer dereferende at virtual address 00000058
c02c5247
*pde = 00000000
Oops: 0000
CPU:  0
EIP: 0010:[<c02c5247>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000002   ebx: 00000000     ecx: c366e624       edx: 00000001
esi: c73c88e8   edi: 00000001     ebp: d553ff04       esp: d553feec
ds: 0018        es: 0018       ss: 0018
Process flukahp (pid: 15178, stackpage=d553f000)
Stack:  c02c51cc c366e624 00000001 00000800 00000000 c73c8000 d553ff1c 
c02c6783
        c366e624 c366e624 c02c66a0 00000000 d553ff54 c012564b c366e624 
00000000
        00000000 00000000 c03cfb50 00000000 0f68a4a4 00000040 00000001 
00000086
Call Trace:    [<c02c51cc>] [<c02c6783>] [<c02c66a0>] [<c012564b>] 
[<c012139a>]
  [<c0121263>] [<c0120fdd>] [<c010ac2c>]
Code: Bad EIP value.


 >>EIP; c02c5247 <xprt_timer+7b/158>   <=====

 >>ecx; c366e624 <_end+322cec0/384c18fc>
 >>esi; c73c88e8 <_end+6f87184/384c18fc>
 >>ebp; d553ff04 <_end+150fe7a0/384c18fc>
 >>esp; d553feec <_end+150fe788/384c18fc>

Trace; c02c51cc <xprt_timer+0/158>
Trace; c02c6783 <rpc_run_timer+e3/f0>
Trace; c02c66a0 <rpc_run_timer+0/f0>
Trace; c012564b <timer_bh+2ff/488>
Trace; c012139a <bh_action+52/e0>
Trace; c0121263 <tasklet_hi_action+63/a0>
Trace; c0120fdd <do_softirq+7d/e0>
Trace; c010ac2c <do_IRQ+198/1a8>

 <0>Kernel panic: Aiee, killing interrupt handler!


That' it.

Have a nice day,

Christopher

