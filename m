Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVAMPE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVAMPE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVAMPE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:04:57 -0500
Received: from leithammel.gnuher.de ([217.160.128.103]:16025 "EHLO
	leithammel.gnuher.de") by vger.kernel.org with ESMTP
	id S261637AbVAMO7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:59:52 -0500
Date: Thu, 13 Jan 2005 15:59:02 +0100
From: Sven Geggus <sven@geggus.net>
To: linux-kernel@vger.kernel.org
Subject: oops in set_mtrr_state in Kernel 2.6.11-rc1 (AMD Opteron)
Message-ID: <20050113145901.GA20283@geggus.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
X-giggls-priority: very high :P
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi there,

starting from 2.6.10 our 32-bit Kernel refuses too boot our Dual Opteron
Machines. 2.6.9 worked fine though.

Here is the oops I get (vanilla Kernel, .config attached).

--cut--
ksymoops 2.4.3 on i686 2.6.11-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.11-rc1/ (default)
     -m /boot/System.map-2.6.11-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
CPU:    1         
EIP:    0060:[<c010ca4c>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006   (2.6.11-rc1)             
eax: 1e1e1e1e   ebx: 00000008   ecx: 00000250   edx: 1e1e1e1e
esi: 06060606   edi: c04ca344   ebp: 00000000   esp: dff33f14
ds: 007b   es: 007b   ss: 0068                               
Stack: 06060606 00000008 00000000 00000c00 00000000 c010cbb2 c04ca344 dfffb470 
       00000086 00000082 00000020 c010cce3 00000c00 00000000 dff31f6c 00000082 
       c010b62c c0468248 0000000a 00000046 dff32000 00000000 dff32000 c0110bdd 
Call Trace:                                                                    
 [<c010cbb2>] set_mtrr_state+0x22/0x90
 [<c010cce3>] generic_set_all+0x23/0x50
 [<c010b62c>] ipi_handler+0x7c/0x80    
 [<c0110bdd>] smp_call_function_interrupt+0x3d/0x60
 [<c0103290>] call_function_interrupt+0x1c/0x24    
 [<c01006d3>] default_idle+0x23/0x30           
 [<c010077f>] cpu_idle+0x5f/0x70    
Code: b9 50 02 00 00 31 ed 57 56 53 83 ec 04 8b 7c 24 18 0f 32 89 04 24 89 d6 8b 07 3b 04 24 0f 84 80 00 00 00 8b 57 04 b9 

>>EIP; c010ca4c <set_fixed_ranges+2c/c0>   <=====
Trace; c010cbb2 <set_mtrr_state+22/90>
Trace; c010cce2 <generic_set_all+22/50>
Trace; c010b62c <ipi_handler+7c/80>
Trace; c0110bdc <smp_call_function_interrupt+3c/60>
Trace; c0103290 <call_function_interrupt+1c/24>
Trace; c01006d2 <default_idle+22/30>
Trace; c010077e <cpu_idle+5e/70>
Code;  c010ca4c <set_fixed_ranges+2c/c0>
00000000 <_EIP>:
Code;  c010ca4c <set_fixed_ranges+2c/c0>   <=====
   0:   b9 50 02 00 00            mov    $0x250,%ecx   <=====
Code;  c010ca50 <set_fixed_ranges+30/c0>
   5:   31 ed                     xor    %ebp,%ebp
Code;  c010ca52 <set_fixed_ranges+32/c0>
   7:   57                        push   %edi
Code;  c010ca54 <set_fixed_ranges+34/c0>
   8:   56                        push   %esi
Code;  c010ca54 <set_fixed_ranges+34/c0>
   9:   53                        push   %ebx
Code;  c010ca56 <set_fixed_ranges+36/c0>
   a:   83 ec 04                  sub    $0x4,%esp
Code;  c010ca58 <set_fixed_ranges+38/c0>
   d:   8b 7c 24 18               mov    0x18(%esp),%edi
Code;  c010ca5c <set_fixed_ranges+3c/c0>
  11:   0f 32                     rdmsr  
Code;  c010ca5e <set_fixed_ranges+3e/c0>
  13:   89 04 24                  mov    %eax,(%esp)
Code;  c010ca62 <set_fixed_ranges+42/c0>
  16:   89 d6                     mov    %edx,%esi
Code;  c010ca64 <set_fixed_ranges+44/c0>
  18:   8b 07                     mov    (%edi),%eax
Code;  c010ca66 <set_fixed_ranges+46/c0>
  1a:   3b 04 24                  cmp    (%esp),%eax
Code;  c010ca68 <set_fixed_ranges+48/c0>
  1d:   0f 84 80 00 00 00         je     a3 <_EIP+0xa3>
Code;  c010ca6e <set_fixed_ranges+4e/c0>
  23:   8b 57 04                  mov    0x4(%edi),%edx
Code;  c010ca72 <set_fixed_ranges+52/c0>
  26:   b9 00 00 00 00            mov    $0x0,%ecx

 <0>Kernel panic - not syncing: Fatal exception in interrupt                                            

1 warning and 1 error issued.  Results may not be reliable.
--cut--



Sven


-- 
C is quirky, flawed, and an enormous success
(Dennis M. Ritchie)

/me is giggls@ircnet, http://sven.gegg.us/ on the Web

--PEIAKu/WMn1b1Hv9
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--PEIAKu/WMn1b1Hv9--
