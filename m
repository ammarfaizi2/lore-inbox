Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311948AbSD0Ivp>; Sat, 27 Apr 2002 04:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSD0Ivp>; Sat, 27 Apr 2002 04:51:45 -0400
Received: from linux.kappa.ro ([194.102.255.131]:44740 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S311948AbSD0Ivn>;
	Sat, 27 Apr 2002 04:51:43 -0400
Date: Sat, 27 Apr 2002 11:54:25 +0300
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] linux-2.4.19-pre7-rmap13
Message-ID: <20020427085425.GA5573@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware overview:
root@games:~# lspci
00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1647 (rev 02)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247
00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 0b)

CPU: Athlon XP 1700+

(the distribution is Slackware-8.0)

I got today this: kernel BUG at page_alloc.c:110!
and then I got this OOPS on a games server running 4 servers of hlds/counter-strike:

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012bca8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0100001c   ebx: c129922c   ecx: c0225b24   edx: cb874e30
esi: 00000000   edi: 001b4000   ebp: 0c400000   esp: dd787e30
ds: 0018   es: 0018   ss: 0018
Process hlds (pid: 10202, stackpage=dd787000)
Stack: c129922c 00400000 001b4000 0c400000 0001eff0 c155b9ac c0225b24 c103400c
       c0225b64 00000213 cb874e30 00400000 001b4000 c012c56b c012c9f3 c129922c
       c0120930 c129922c de0d36d0 c0120d72 0cca8067 defb1ec0 de4a8d80 0804d000
Call Trace: [<c012c56b>] [<c012c9f3>] [<c0120930>] [<c0120d72>] [<c01233d5>]
   [<c01136b6>] [<c011778d>] [<c011c41a>] [<c0108581>] [<c0111870>] [<c01b253b>]
   [<c01087cc>] [<c0108714>]
Code: 0f 0b 6e 00 7c bf 1f c0 89 d8 2b 05 d0 55 27 c0 69 c0 c5 4e


>>EIP; c012bca8 <__free_pages_ok+48/280>   <=====

>>eax; 0100001c Before first symbol
>>ebx; c129922c <END_OF_CODE+10024f8/????>
>>ecx; c0225b24 <contig_page_data+e4/3e0>
>>edx; cb874e30 <END_OF_CODE+b5de0fc/????>
>>edi; 001b4000 Before first symbol
>>ebp; 0c400000 Before first symbol
>>esp; dd787e30 <END_OF_CODE+1d4f10fc/????>

Trace; c012c56b <__free_pages+1b/20>
Trace; c012c9f3 <free_page_and_swap_cache+33/40>
Trace; c0120930 <__free_pte+40/50>
Trace; c0120d72 <zap_page_range+192/240>
Trace; c01233d5 <exit_mmap+b5/120>
Trace; c01136b6 <mmput+26/50>
Trace; c011778d <do_exit+8d/240>
Trace; c011c41a <sig_exit+9a/a0>
Trace; c0108581 <do_signal+1f1/260>
Trace; c0111870 <do_page_fault+0/494>
Trace; c01b253b <sys_socketcall+17b/200>
Trace; c01087cc <error_code+34/3c>
Trace; c0108714 <signal_return+14/18>

Code;  c012bca8 <__free_pages_ok+48/280>
0000000000000000 <_EIP>:
Code;  c012bca8 <__free_pages_ok+48/280>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012bcaa <__free_pages_ok+4a/280>
   2:   6e                        outsb  %ds:(%esi),(%dx)
Code;  c012bcab <__free_pages_ok+4b/280>
   3:   00 7c bf 1f               add    %bh,0x1f(%edi,%edi,4)
Code;  c012bcaf <__free_pages_ok+4f/280>
   7:   c0 89 d8 2b 05 d0 55      rorb   $0x55,0xd0052bd8(%ecx)
Code;  c012bcb6 <__free_pages_ok+56/280>
   e:   27                        daa
Code;  c012bcb7 <__free_pages_ok+57/280>
   f:   c0 69 c0 c5               shrb   $0xc5,0xffffffc0(%ecx)
Code;  c012bcbb <__free_pages_ok+5b/280>
  13:   4e                        dec    %esi


2 warnings issued.  Results may not be reliable.

// The 2 warnings are:
Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?



-- 
      Teodor Iacob,
Astral TELECOM Internet
