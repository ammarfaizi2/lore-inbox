Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSFOJuT>; Sat, 15 Jun 2002 05:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSFOJuS>; Sat, 15 Jun 2002 05:50:18 -0400
Received: from 217-79-104-247.adsl.griffin.net.uk ([217.79.104.247]:4903 "EHLO
	lemur.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S315222AbSFOJuQ>; Sat, 15 Jun 2002 05:50:16 -0400
Date: Sat, 15 Jun 2002 10:50:16 +0100
To: linux-kernel@vger.kernel.org
Subject: [BUG] Qlogic ISP driver hangs on 2.4.18/9
Message-ID: <20020615095016.GA470@beezly.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Andrew Beresford <beezly@beezly.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running a qlogic isp card (actually on a Sun Sunswift PCI card) in
an x86 machine and I keep seeing the following oops

This problem appears with 2.4.18, 2.4.18-pre9, 2.4.18-pre10 and
2.4.18-pre10-ac2

PLEASE NOTE! The following information was copied out **by hand** so I
don't vouch it for being 100% accurate (and it's late here)... but it
certainly seems to be pointing the error in the way of the qlogicisp
driver.

Any help is greatly appreciated!!!

ksymoops 2.4.5 on i586 2.4.19-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre10/ (default)
     -m /boot/System.map-2.4.19-pre10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000184
c8850896
*pde = 00000000
Oops:   0002
CPU:    0
EIP:    0010:[<c8850896>]  Not Tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 0010046
eax: 00000000   ebx: c79bc000     ecx: 00007000       edx: 00000000
esi: 24000001   edi: 0000000a     ebp: 00000000       esp: c0221f2c
ds: 0018        es:0018        ss: 0018
Process swapper (pid: 0, stackpage=c0221000)
Stack:  c79bc000 00000002 24000001 0000000a c0221fac 00000001 00000001 c7d8c47c
        c7d8c400 c88506a8 0000000a c7d8c400 c0221fac c7b85720 c01099bc 0000000a
        c7d8c400 c0221fac 00000140 c0257a40 0000000a c0221fa4 c0109b22 0000000a
Call Trace: [<c88506a8>] [<c01099bc>] [<c0109b22>] [<c0106d40>] [<c010b908>] 
            [<c0106d40>] [<c0106d63>] [<c0106dc7>] [<c0105000>] [<c0105020>]
Code: 89 85 84 01 00 83 c4 04 eb 0a c7 85 84 01 00 00 00 00 07


>>EIP; c8850896 <[qlogicisp]isp1020_intr_handler+1e6/280>   <=====

>>ebx; c79bc000 <_end+77336b8/85866b8>
>>ecx; 00007000 Before first symbol
>>esi; 24000001 Before first symbol
>>esp; c0221f2c <init_task_union+1f2c/2000>

Trace; c88506a8 <[qlogicisp]do_isp1020_intr_handler+18/20>
Trace; c01099bc <handle_IRQ_event+34/60>
Trace; c0109b22 <do_IRQ+6a/a8>
Trace; c0106d40 <default_idle+0/28>
Trace; c010b908 <call_do_IRQ+5/d>
Trace; c0106d40 <default_idle+0/28>
Trace; c0106d63 <default_idle+23/28>
Trace; c0106dc7 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105020 <rest_init+20/28>

Code;  c8850896 <[qlogicisp]isp1020_intr_handler+1e6/280>
00000000 <_EIP>:
Code;  c8850896 <[qlogicisp]isp1020_intr_handler+1e6/280>   <=====
   0:   89 85 84 01 00 83         mov    %eax,0x83000184(%ebp)   <=====
Code;  c885089c <[qlogicisp]isp1020_intr_handler+1ec/280>
   6:   c4 04 eb                  les    (%ebx,%ebp,8),%eax
Code;  c885089f <[qlogicisp]isp1020_intr_handler+1ef/280>
   9:   0a c7                     or     %bh,%al
Code;  c88508a1 <[qlogicisp]isp1020_intr_handler+1f1/280>
   b:   85 84 01 00 00 00 00      test   %eax,0x0(%ecx,%eax,1)
Code;  c88508a8 <[qlogicisp]isp1020_intr_handler+1f8/280>
  12:   07                        pop    %es


1 warning issued.  Results may not be reliable.

