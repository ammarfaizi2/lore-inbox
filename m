Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318127AbSGMIy5>; Sat, 13 Jul 2002 04:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318128AbSGMIy4>; Sat, 13 Jul 2002 04:54:56 -0400
Received: from cpe.atm2-0-1071115.0x50c4d862.boanxx10.customer.tele.dk ([80.196.216.98]:5504
	"EHLO fugmann.dhs.org") by vger.kernel.org with ESMTP
	id <S318127AbSGMIyy>; Sat, 13 Jul 2002 04:54:54 -0400
Message-ID: <3D2FEB87.7050705@fugmann.dhs.org>
Date: Sat, 13 Jul 2002 10:57:43 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops with kernel 2.4.19-pre10
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After runninbg pre10 since it came out, I got an oops. I have not tried rc1 yet.

Below is the output from ksymoops:

Jul 13 07:56:01 gw kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000007
Jul 13 07:56:01 gw kernel: c0126840
Jul 13 07:56:01 gw kernel: *pde = 00000000
Jul 13 07:56:01 gw kernel: Oops: 0000
Jul 13 07:56:01 gw kernel: CPU:    0
Jul 13 07:56:01 gw kernel: EIP:    0010:[<c0126840>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 13 07:56:01 gw kernel: EFLAGS: 00010286
Jul 13 07:56:01 gw kernel: eax: c6831d24   ebx: ffffffff   ecx: c11baa0c   edx: 0000125c
Jul 13 07:56:01 gw kernel: esi: 0000125c   edi: c6831d24   ebp: c11baa0c   esp: cfae5df8
Jul 13 07:56:01 gw kernel: ds: 0018   es: 0018   ss: 0018
Jul 13 07:56:01 gw kernel: Process apache-ssl (pid: 2177, stackpage=cfae5000)
Jul 13 07:56:01 gw kernel: Stack: 00000000 c6831d90 c6831c80 cfae5e80 c01308ea c6831d24 0000125c c138
8174
Jul 13 07:56:01 gw kernel:        c6831d24 d31d9d40 00000002 cfae5e44 00000086 00000086 00000003 c651
c1e8
Jul 13 07:56:01 gw kernel:        00000086 00000086 00000000 c6831d90 c6831c80 cfae5e80 c0130c13 c683
1d90
Jul 13 07:56:01 gw kernel: Call Trace: [<c01308ea>] [<c0130c13>] [<c0130c85>] [<c0124033>] [<c012426a
Jul 13 07:56:01 gw kernel:    [<c01e90d3>] [<c01dda55>] [<c01129aa>] [<c011d42b>] [<c011d697>] [<c010
d2b0>]
Jul 13 07:56:01 gw kernel:    [<c011a3b5>] [<c011a2b4>] [<c011a093>] [<c01126c0>] [<c0108c24>]
Jul 13 07:56:01 gw kernel: Code: 39 7b 08 74 05 8b 5b 10 eb f2 39 73 0c 75 f6 85 db 74 38 ff


 >>EIP; c0126840 <__find_lock_page_helper+10/70>   <=====

 >>eax; c6831d24 <_end+64f30c8/144d33a4>
 >>ebx; ffffffff <END_OF_CODE+2b60e9e0/????>
 >>ecx; c11baa0c <_end+e7bdb0/144d33a4>
 >>edx; 0000125c Before first symbol
 >>esi; 0000125c Before first symbol
 >>edi; c6831d24 <_end+64f30c8/144d33a4>
 >>ebp; c11baa0c <_end+e7bdb0/144d33a4>
 >>esp; cfae5df8 <_end+f7a719c/144d33a4>

Trace; c01308ea <shmem_getpage_locked+4a/320>
Trace; c0130c13 <shmem_getpage+53/a0>
Trace; c0130c85 <shmem_nopage+25/30>
Trace; c0124033 <do_no_page+33/1a0>
Trace; c01e90d3 <ide_intr+e3/120>
Trace; c01dda55 <account_io_end+25/40>
Trace; c01129aa <do_page_fault+2ea/507>
Trace; c011d42b <update_wall_time+b/50>
Trace; c011d697 <timer_bh+27/3c0>

Code;  c0126840 <__find_lock_page_helper+10/70>
00000000 <_EIP>:
Code;  c0126840 <__find_lock_page_helper+10/70>   <=====
    0:   39 7b 08                  cmp    %edi,0x8(%ebx)   <=====
Code;  c0126843 <__find_lock_page_helper+13/70>
    3:   74 05                     je     a <_EIP+0xa> c012684a <__find_lock_page_helper+1a/70>
Code;  c0126845 <__find_lock_page_helper+15/70>
    5:   8b 5b 10                  mov    0x10(%ebx),%ebx
Code;  c0126848 <__find_lock_page_helper+18/70>
    8:   eb f2                     jmp    fffffffc <_EIP+0xfffffffc> c012683c <__find_lock_page_helper+c/70>
Code;  c012684a <__find_lock_page_helper+1a/70>
    a:   39 73 0c                  cmp    %esi,0xc(%ebx)
Code;  c012684d <__find_lock_page_helper+1d/70>
    d:   75 f6                     jne    5 <_EIP+0x5> c0126845 <__find_lock_page_helper+15/70>
Code;  c012684f <__find_lock_page_helper+1f/70>
    f:   85 db                     test   %ebx,%ebx
Code;  c0126851 <__find_lock_page_helper+21/70>
   11:   74 38                     je     4b <_EIP+0x4b> c012688b <__find_lock_page_helper+5b/70>
Code;  c0126853 <__find_lock_page_helper+23/70>
   13:   ff 00                     incl   (%eax)

If you need more information, please let me know.

Regards
Anders Fugmann

