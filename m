Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289826AbSAPCmC>; Tue, 15 Jan 2002 21:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289825AbSAPClx>; Tue, 15 Jan 2002 21:41:53 -0500
Received: from [202.7.93.26] ([202.7.93.26]:36738 "EHLO pegasus.vrlaw.com.au")
	by vger.kernel.org with ESMTP id <S289820AbSAPCln>;
	Tue, 15 Jan 2002 21:41:43 -0500
Message-ID: <3C44E946.E890DA7F@vrlaw.com.au>
Date: Wed, 16 Jan 2002 13:45:26 +1100
From: Patrick Burns <patrickb@vrlaw.com.au>
Organization: Vardanega Roberts
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Another 2.4.17 oops
Content-Type: multipart/mixed;
 boundary="------------DEB99126E74EAE4DC8798916"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DEB99126E74EAE4DC8798916
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi there again.

Kernel 2.4.17 keeps falling over *very* frequently. As per my previous
posting, I have had yet another Oops which makes that two crashes in
three days. I never had these problems with 2.2 kernels. What is wrong
with 2.4.17? Will it help if I upgrade to one of the 2.4.18-pre kernels?

I would tend to think that hardware is _not_ the problem here, as the
only thing I have changed is the kernel. This same server was rock solid
when running kernel 2.2 only last week. I have gone back to using
RedHat's prebuilt 2.4.7 for now. I'm sorry I can't test any further, but
the machine is a production server, and can't be shut down. What is
going on?

I have attatched the ksymoops output. The problem (again, as before) is
in prune_dcache.
Please cc: replies. Thanks for your help!

-Patrick.

--------------DEB99126E74EAE4DC8798916
Content-Type: text/plain; charset=us-ascii;
 name="trace4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trace4.txt"

Jan 16 12:23:43 pegasus kernel: Unable to handle kernel paging request at virtual address 00300014
Jan 16 12:23:43 pegasus kernel: c0147d2f
Jan 16 12:23:43 pegasus kernel: *pde = 00000000
Jan 16 12:23:43 pegasus kernel: Oops: 0000
Jan 16 12:23:43 pegasus kernel: CPU:    0
Jan 16 12:23:43 pegasus kernel: EIP:    0010:[<c0147d2f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 16 12:23:43 pegasus kernel: EFLAGS: 00010206
Jan 16 12:23:43 pegasus kernel: eax: 00300000   ebx: d82f0e78   ecx: d4c9a810   edx: d82f0e90
Jan 16 12:23:43 pegasus kernel: esi: d82f0e60   edi: d4c9a800   ebp: 000068bb   esp: c1955f30
Jan 16 12:23:43 pegasus kernel: ds: 0018   es: 0018   ss: 0018
Jan 16 12:23:43 pegasus kernel: Process kswapd (pid: 5, stackpage=c1955000)
Jan 16 12:23:43 pegasus kernel: Stack: c012f67c ca7a1340 c1954000 ffffffff 000001d0 c0297b28 c1954000 00000006 
Jan 16 12:23:43 pegasus kernel:        00000006 000001d0 00000006 00000006 c01480c0 0000839c c012f887 00000006 
Jan 16 12:23:43 pegasus kernel:        000001d0 c0297b28 00000006 000001d0 c0297b28 00000000 c012f8ec 00000020 
Jan 16 12:23:43 pegasus kernel: Call Trace: [<c012f67c>] [<c01480c0>] [<c012f887>] [<c012f8ec>] [<c012f991>] 
Jan 16 12:23:43 pegasus kernel:    [<c012fa06>] [<c012fb41>] [<c012faa0>] [<c0105000>] [<c0105836>] [<c012faa0>] 
Jan 16 12:23:43 pegasus kernel: Code: 8b 40 14 85 c0 74 0a 57 56 ff d0 5a 59 eb 1a 89 f6 57 e8 4a 

>>EIP; c0147d2f <prune_dcache+bf/160>   <=====
Trace; c012f67c <shrink_cache+30c/3b0>
Trace; c01480c0 <shrink_dcache_memory+20/30>
Trace; c012f887 <shrink_caches+67/90>
Trace; c012f8ec <try_to_free_pages+3c/60>
Trace; c012f991 <kswapd_balance_pgdat+51/a0>
Trace; c012fa06 <kswapd_balance+26/40>
Trace; c012fb41 <kswapd+a1/c0>
Trace; c012faa0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105836 <kernel_thread+26/30>
Trace; c012faa0 <kswapd+0/c0>
Code;  c0147d2f <prune_dcache+bf/160>
00000000 <_EIP>:
Code;  c0147d2f <prune_dcache+bf/160>   <=====
   0:   8b 40 14                  mov    0x14(%eax),%eax   <=====
Code;  c0147d32 <prune_dcache+c2/160>
   3:   85 c0                     test   %eax,%eax
Code;  c0147d34 <prune_dcache+c4/160>
   5:   74 0a                     je     11 <_EIP+0x11> c0147d40 <prune_dcache+d0/160>
Code;  c0147d36 <prune_dcache+c6/160>
   7:   57                        push   %edi
Code;  c0147d37 <prune_dcache+c7/160>
   8:   56                        push   %esi
Code;  c0147d38 <prune_dcache+c8/160>
   9:   ff d0                     call   *%eax
Code;  c0147d3a <prune_dcache+ca/160>
   b:   5a                        pop    %edx
Code;  c0147d3b <prune_dcache+cb/160>
   c:   59                        pop    %ecx
Code;  c0147d3c <prune_dcache+cc/160>
   d:   eb 1a                     jmp    29 <_EIP+0x29> c0147d58 <prune_dcache+e8/160>
Code;  c0147d3e <prune_dcache+ce/160>
   f:   89 f6                     mov    %esi,%esi
Code;  c0147d40 <prune_dcache+d0/160>
  11:   57                        push   %edi
Code;  c0147d41 <prune_dcache+d1/160>
  12:   e8 4a 00 00 00            call   61 <_EIP+0x61> c0147d90 <prune_dcache+120/160>


--------------DEB99126E74EAE4DC8798916--

