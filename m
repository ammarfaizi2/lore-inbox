Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282492AbRK0SrB>; Tue, 27 Nov 2001 13:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282596AbRK0Sqk>; Tue, 27 Nov 2001 13:46:40 -0500
Received: from liszt-03.ednet.co.uk ([212.20.226.20]:53915 "HELO
	liszt-03.ednet.co.uk") by vger.kernel.org with SMTP
	id <S282492AbRK0Sqa>; Tue, 27 Nov 2001 13:46:30 -0500
Subject: BUG slab.c, buffer.c
From: Martin Donnelly <martin@ramix.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Nov 2001 18:46:28 +0000
Message-Id: <1006886788.27769.2.camel@inchgower>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed strange behaviour recently with a driver i'm developing and
tried to replicate it in a simple module to determine if it was my
driver or a kernel bug. Basically i allocate 120k with kmalloc then
initialising this memory i get the following oops. (I've tried this on
several machines with the same results)

Any ideas what is wrong?

Note: the tainted flag is set due to no license in the test module, code
is attached.

ksymoops 2.4.3 on i686 2.4.10-ac10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-ac10/ (default)
     -m /boot/System.map-2.4.10-ac10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal

kernel BUG at buffer.c:1655!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0132966>]    Tainted: P 
EFLAGS: 00010286
eax: 0000001d   ebx: 00000000   ecx: c02b85a0   edx: 00001708
esi: 00001000   edi: c7790f8c   ebp: 00001000   esp: c718be3c
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 187, stackpage=c718b000)
Stack: c025af3a 00000677 00000bcb c11d8914 c7790f8c c11d8914 00000010
c6f31000 
       c718be70 c707dbbc 00001000 0000005f 00000000 c7790f8c c127fc00
c0133102 
       c70cc3bc c11d8914 00000bcb 00000bda c014eb2c c11d8914 c70cc3bc
c014ef2c 
Call Trace: [<c0133102>] [<c014eb2c>] [<c014ef2c>] [<c014eb2c>]
[<c0124fea>] 
   [<c014d426>] [<c01305d6>] [<c014d404>] [<c01306e5>] [<c0106b2b>] 

Code: 0f 0b 83 c4 08 90 8d 74 26 00 8b 54 24 20 8d 2c 32 3b 6c 24 
 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000004 printing eip:
c015a675
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c015a675>]    Tainted: P 
EFLAGS: 00010292
eax: c127fa48   ebx: 00000000   ecx: 00000001   edx: 00000003
esi: c707de94   edi: c72f9944   ebp: c72fee9c   esp: c741fe50
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 75, stackpage=c741f000)
Stack: c707de94 c72fee9c c0157dc1 c707de94 c72fee9c c72fee9c c015833b
c72fee9c 
       c127fa00 c127fa00 c6f5e874 c127fa38 00000000 c6f5e29c c6f5e7ec
c0156863 
       c127fa00 c127fa50 c127fa00 c127fa00 00000000 c127fa94 c127fa50
00000000 
Call Trace: [<c0157dc1>] [<c015833b>] [<c0156863>] [<c01b43e7>]
[<c01b8699>] 
   [<c0113c16>] [<c0105750>] [<c01114ca>] [<c015902b>] [<c0158f10>]
[<c0105478>] 

Code: 83 7b 04 00 7d 35 68 fd 3c 26 c0 68 43 06 00 00 68 11 35 26 
 kernel BUG at slab.c:1247!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0127a59>]    Tainted: P 
EFLAGS: 00010082
eax: 0000001b   ebx: c12010a0   ecx: c02b85a0   edx: 00001ddf
esi: c7070ec0   edi: 00000000   ebp: 00000000   esp: c65a7e70
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 395, stackpage=c65a7000)
Stack: c025939f 000004df c65a6000 00000001 00000070 00000010 00000020
00000246 
       c015a3d7 00000010 00000070 00000000 c127f800 c74ce6f4 c65a6000
c0154a14 
       c0261b8c 00000010 00000070 00000001 c74ce6f4 00000000 c74ce6f4
c65a7f84 
Call Trace: [<c015a3d7>] [<c0154a14>] [<c015084e>] [<c0141512>]
[<c0142960>] 
   [<c0139615>] [<c0139c36>] [<c012fb17>] [<c012fe1c>] [<c0106b2b>] 

Code: 0f 0b 83 c4 08 89 f6 f6 43 1d 04 74 4e b8 a5 c2 0f 17 87 06kernel
BUG at buffer.c:1655!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0132966>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001d   ebx: 00000000   ecx: c02b85a0   edx: 00001708
esi: 00001000   edi: c7790f8c   ebp: 00001000   esp: c718be3c
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 187, stackpage=c718b000)
Stack: c025af3a 00000677 00000bcb c11d8914 c7790f8c c11d8914 00000010
c6f31000 
       c718be70 c707dbbc 00001000 0000005f 00000000 c7790f8c c127fc00
c0133102 
       c70cc3bc c11d8914 00000bcb 00000bda c014eb2c c11d8914 c70cc3bc
c014ef2c 
Call Trace: [<c0133102>] [<c014eb2c>] [<c014ef2c>] [<c014eb2c>]
[<c0124fea>] 
   [<c014d426>] [<c01305d6>] [<c014d404>] [<c01306e5>] [<c0106b2b>] 
Code: 0f 0b 83 c4 08 90 8d 74 26 00 8b 54 24 20 8d 2c 32 3b 6c 24 

>>EIP; c0132966 <__block_prepare_write+9e/2a0>   <=====
Trace; c0133102 <block_prepare_write+22/3c>
Trace; c014eb2c <ext3_get_block+0/70>
Trace; c014ef2c <ext3_prepare_write+6c/f4>
Trace; c014eb2c <ext3_get_block+0/70>
Trace; c0124fea <generic_file_write+3aa/5f8>
Trace; c014d426 <ext3_file_write+22/5c>
Trace; c01305d6 <do_readv_writev+1b6/230>
Trace; c014d404 <ext3_file_write+0/5c>
Trace; c01306e4 <sys_writev+40/54>
Trace; c0106b2a <system_call+32/38>
Code;  c0132966 <__block_prepare_write+9e/2a0>
00000000 <_EIP>:
Code;  c0132966 <__block_prepare_write+9e/2a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0132968 <__block_prepare_write+a0/2a0>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c013296a <__block_prepare_write+a2/2a0>
   5:   90                        nop    
Code;  c013296c <__block_prepare_write+a4/2a0>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c0132970 <__block_prepare_write+a8/2a0>
   a:   8b 54 24 20               mov    0x20(%esp,1),%edx
Code;  c0132974 <__block_prepare_write+ac/2a0>
   e:   8d 2c 32                  lea    (%edx,%esi,1),%ebp
Code;  c0132976 <__block_prepare_write+ae/2a0>
  11:   3b 6c 24 00               cmp    0x0(%esp,1),%ebp

 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000004c015a675
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c015a675>]    Tainted: P 
EFLAGS: 00010292
eax: c127fa48   ebx: 00000000   ecx: 00000001   edx: 00000003
esi: c707de94   edi: c72f9944   ebp: c72fee9c   esp: c741fe50
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 75, stackpage=c741f000)
Stack: c707de94 c72fee9c c0157dc1 c707de94 c72fee9c c72fee9c c015833b
c72fee9c 
       c127fa00 c127fa00 c6f5e874 c127fa38 00000000 c6f5e29c c6f5e7ec
c0156863 
       c127fa00 c127fa50 c127fa00 c127fa00 00000000 c127fa94 c127fa50
00000000 
Call Trace: [<c0157dc1>] [<c015833b>] [<c0156863>] [<c01b43e7>]
[<c01b8699>] 
   [<c0113c16>] [<c0105750>] [<c01114ca>] [<c015902b>] [<c0158f10>]
[<c0105478>] 
Code: 83 7b 04 00 7d 35 68 fd 3c 26 c0 68 43 06 00 00 68 11 35 26 

>>EIP; c015a674 <__journal_remove_journal_head+8/110>   <=====
Trace; c0157dc0 <__try_to_free_cp_buf+20/3c>
Trace; c015833a <__journal_clean_checkpoint_list+4a/68>
Trace; c0156862 <journal_commit_transaction+1ee/f3c>
Trace; c01b43e6 <serial_in+36/3c>
Trace; c01b8698 <serial_console_write+178/184>
Trace; c0113c16 <__call_console_drivers+3a/4c>
Trace; c0105750 <__switch_to+2c/b8>
Trace; c01114ca <schedule+25e/394>
Trace; c015902a <kjournald+10a/1b0>
Trace; c0158f10 <commit_timeout+0/c>
Trace; c0105478 <kernel_thread+28/38>
Code;  c015a674 <__journal_remove_journal_head+8/110>
00000000 <_EIP>:
Code;  c015a674 <__journal_remove_journal_head+8/110>   <=====
   0:   83 7b 04 00               cmpl   $0x0,0x4(%ebx)   <=====
Code;  c015a678 <__journal_remove_journal_head+c/110>
   4:   7d 35                     jge    3b <_EIP+0x3b> c015a6ae
<__journal_remove_journal_head+42/110>
Code;  c015a67a <__journal_remove_journal_head+e/110>
   6:   68 fd 3c 26 c0            push   $0xc0263cfd
Code;  c015a67e <__journal_remove_journal_head+12/110>
   b:   68 43 06 00 00            push   $0x643
Code;  c015a684 <__journal_remove_journal_head+18/110>
  10:   68 11 35 26 00            push   $0x263511

 kernel BUG at slab.c:1247!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0127a59>]    Tainted: P 
EFLAGS: 00010082
eax: 0000001b   ebx: c12010a0   ecx: c02b85a0   edx: 00001ddf
esi: c7070ec0   edi: 00000000   ebp: 00000000   esp: c65a7e70
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 395, stackpage=c65a7000)
Stack: c025939f 000004df c65a6000 00000001 00000070 00000010 00000020
00000246 
       c015a3d7 00000010 00000070 00000000 c127f800 c74ce6f4 c65a6000
c0154a14 
       c0261b8c 00000010 00000070 00000001 c74ce6f4 00000000 c74ce6f4
c65a7f84 
Call Trace: [<c015a3d7>] [<c0154a14>] [<c015084e>] [<c0141512>]
[<c0142960>] 
   [<c0139615>] [<c0139c36>] [<c012fb17>] [<c012fe1c>] [<c0106b2b>] 

Code: 0f 0b 83 c4 08 89 f6 f6 43 1d 04 74 4e b8 a5 c2 0f 17 87 06

>>EIP; c0127a58 <kmalloc+188/228>   <=====
Trace; c015a3d6 <__jbd_kmalloc+22/78>
Trace; c0154a14 <journal_start+80/e0>
Trace; c015084e <ext3_dirty_inode+3a/84>
Trace; c0141512 <__mark_inode_dirty+2a/80>
Trace; c0142960 <update_atime+44/54>
Trace; c0139614 <path_walk+62c/748>
Trace; c0139c36 <open_namei+82/514>
Trace; c012fb16 <filp_open+3a/5c>
Trace; c012fe1c <sys_open+38/b4>
Trace; c0106b2a <system_call+32/38>
Code;  c0127a58 <kmalloc+188/228>
00000000 <_EIP>:
Code;  c0127a58 <kmalloc+188/228>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0127a5a <kmalloc+18a/228>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0127a5c <kmalloc+18c/228>
   5:   89 f6                     mov    %esi,%esi
Code;  c0127a5e <kmalloc+18e/228>
   7:   f6 43 1d 04               testb  $0x4,0x1d(%ebx)
Code;  c0127a62 <kmalloc+192/228>
   b:   74 4e                     je     5b <_EIP+0x5b> c0127ab2
<kmalloc+1e2/228>
Code;  c0127a64 <kmalloc+194/228>
   d:   b8 a5 c2 0f 17            mov    $0x170fc2a5,%eax
Code;  c0127a6a <kmalloc+19a/228>
  12:   87 06                     xchg   %eax,(%esi)



The code being use to generate this is:

int init_module(void)
{
    addr = kmalloc(GFP_KERNEL, mem_size);
    if(addr != NULL)
    {
        u8      *byte;
        u32     ix;

        byte = addr;
        for(ix = 0; ix < mempage_size; ix++)
        {
            *byte = 0;
            byte++;
        }
    }
    return 0;
}




-- 
Martin Donnelly                                Senior Software Engineer
                                               RAMiX Europe Ltd
99 little bugs in the code, 99 bugs in the code,
fix one bug, compile it again...
101 little bugs in the code....

