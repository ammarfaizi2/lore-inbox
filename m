Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130620AbQKCQ4A>; Fri, 3 Nov 2000 11:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130844AbQKCQzu>; Fri, 3 Nov 2000 11:55:50 -0500
Received: from [62.172.234.2] ([62.172.234.2]:62923 "EHLO
	rdgxch01.nsmg.veritas.com") by vger.kernel.org with ESMTP
	id <S130764AbQKCQzP>; Fri, 3 Nov 2000 11:55:15 -0500
Message-ID: <3A02EE84.CA981E3@veritas.com>
Date: Fri, 03 Nov 2000 16:57:40 +0000
From: Andy Robinson <andyr@veritas.com>
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <hans@reiser.to>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: panic in reiserfs on test-2.4.0-test9/10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried the linux-2.4.0-test9-resiserfs-3.6.18-patch on both 2.4.0-test9
and test2.4.0-test10
and got the following PANIC I originally saw this PANIC when doing a 'cp
-a / /reiserfs'.
I narrowed it done to a simple symlink ....

Andy


[root@client19 /reiserfs]# ln -s foo.tar foo
Unable to handle kernel NULL pointer dereference at virtual address
00000010
 printing eip:
c0185953
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0185953>]
EFLAGS: 00010296
eax: c12a017c   ebx: c12a0060   ecx: 0000000f   edx: 00000000
esi: c12a0090   edi: c12a0000   ebp: 00000005   esp: c0c01b60
ds: 0018   es: 0018   ss: 0018
Process ln (pid: 928, stackpage=c0c01000)
Stack: c12a0078 c12a017c c0c01bf8 00000001 00000000 c0c01be0 c0178dc4
c058dc00
       c0c01ba4 c0c01b8c 00000000 c0182728 c0182736 00000001 00000130
00000000
       00000000 c0c01c40 00000001 00000000 c0c01c28 c0c01bfc 00000000
00000000
Call Trace: [<c0178dc4>] [<c0182728>] [<c0182736>] [<c018ede7>]
[<c017d3a3>] [<c017d842>] [<c017a5f2>]
       [<c0230f99>] [<c0239e3a>] [<c0139892>] [<c0139951>] [<c010a717>]
Code: 8b 52 10 ff d2 5b 5f 8b 54 24 14 8b 42 34 89 c7 0f b7 47 02
Segmentation fault

ksymoops 2.3.4 on i686 2.4.0-test9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test9/ (default)
     -m /boot/System.map-test9 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid
lsmod file?
Unable to handle kernel NULL pointer dereference at virtual address
00000010
c0185953
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0185953>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: c12a017c   ebx: c12a0060   ecx: 0000000f   edx: 00000000
esi: c12a0090   edi: c12a0000   ebp: 00000005   esp: c0c01b60
ds: 0018   es: 0018   ss: 0018
Process ln (pid: 928, stackpage=c0c01000)
Stack: c12a0078 c12a017c c0c01bf8 00000001 00000000 c0c01be0 c0178dc4
c058dc00
       c0c01ba4 c0c01b8c 00000000 c0182728 c0182736 00000001 00000130
00000000
       00000000 c0c01c40 00000001 00000000 c0c01c28 c0c01bfc 00000000
00000000
Call Trace: [<c0178dc4>] [<c0182728>] [<c0182736>] [<c018ede7>]
[<c017d3a3>] [<c017d842>] [<c017a5f2>]
       [<c0230f99>] [<c0239e3a>] [<c0139892>] [<c0139951>] [<c010a717>]
Code: 8b 52 10 ff d2 5b 5f 8b 54 24 14 8b 42 34 89 c7 0f b7 47 02

>>EIP; c0185953 <check_leaf+a3/c0>   <=====
Trace; c0178dc4 <do_balance+114/140>
Trace; c0182728 <fix_nodes+348/540>
Trace; c0182736 <fix_nodes+356/540>
Trace; c018ede7 <reiserfs_insert_item+a7/110>
Trace; c017d3a3 <reiserfs_new_symlink+e3/f0>
Trace; c017d842 <reiserfs_new_inode+492/500>
Trace; c017a5f2 <reiserfs_symlink+122/220>
Trace; c0230f99 <tvecs+193c9/27ed0>
Trace; c0239e3a <tvecs+2226a/27ed0>
Trace; c0139892 <vfs_symlink+62/a0>
Trace; c0139951 <sys_symlink+81/d0>
Trace; c010a717 <system_call+33/38>
Code;  c0185953 <check_leaf+a3/c0>
00000000 <_EIP>:
Code;  c0185953 <check_leaf+a3/c0>   <=====
   0:   8b 52 10                  mov    0x10(%edx),%edx   <=====
Code;  c0185956 <check_leaf+a6/c0>
   3:   ff d2                     call   *%edx
Code;  c0185958 <check_leaf+a8/c0>
   5:   5b                        pop    %ebx
Code;  c0185959 <check_leaf+a9/c0>
   6:   5f                        pop    %edi
Code;  c018595a <check_leaf+aa/c0>
   7:   8b 54 24 14               mov    0x14(%esp,1),%edx
Code;  c018595e <check_leaf+ae/c0>
   b:   8b 42 34                  mov    0x34(%edx),%eax
Code;  c0185961 <check_leaf+b1/c0>
   e:   89 c7                     mov    %eax,%edi
Code;  c0185963 <check_leaf+b3/c0>
  10:   0f b7 47 02               movzwl 0x2(%edi),%eax


1 warning issued.  Results may not be reliable.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
