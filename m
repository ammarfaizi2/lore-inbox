Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBEWTW>; Mon, 5 Feb 2001 17:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131966AbRBEWTL>; Mon, 5 Feb 2001 17:19:11 -0500
Received: from raven.toyota.com ([63.87.74.200]:22023 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S130600AbRBEWTE>;
	Mon, 5 Feb 2001 17:19:04 -0500
Date: Mon, 5 Feb 2001 14:19:02 -0800 (PST)
From: J J Sloan <jjs@toyota.com>
To: <linux-kernel@vger.kernel.org>
Subject: IBM Model 350 does not like 2.4
Message-ID: <Pine.LNX.4.30.0102051415300.1551-100000@uranium.tms.toyota.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have 10 systems running 2.4 that are rock solid, but I have
1 system that has problems with 2.4. The box had run perfectly
for 46 days with 2.2.19pre2, and today I installed 2.4.1-ac3
to see how it would go. It seemed to run fine for a few minutes,
then the old problem reasserted itself:

"df" gives a segmentation fault:

iron: /root
(tty/dev/pts/0): bash: 1040 > df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda1              1007960    457996    498760  48% /
/dev/hda3              1198496   1082264     55352  96% /usr
Segmentation fault

Initial look at the oops implicates the sunrpc code.

This is Red Hat 7.0 with all updates applied running on a
humble pentium 166 (IBM model 350). The identical oops
occurs whether the kernel is compiled with kgcc or gcc-2.96 .

Hope this helps,

jjs

decoded ksymoops follows:

ksymoops 2.3.4 on i586 2.4.1-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-ac3/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address feff3112
c482dab4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c482dab4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: feff310a   ebx: feff310a   ecx: 00000000   edx: c36c5b20
esi: c36ef610   edi: c36c5b20   ebp: 00000000   esp: c1d31d14
ds: 0018   es: 0018   ss: 0018
Process df (pid: 1305, stackpage=c1d31000)
Stack: 08040016 c08c7300 40000000 c01b291e 00000000 c36c5b20 c36c5b20 c482db9a
       c36c5b20 c1d31da0 c36c5b20 c1d31dd4 c1d31d98 c482dc9f c36c5b20 00000000
       c1d31da0 c1d31e80 c482951a c1d31da0 00000000 c1d31da0 c36efc10 c482940c
Call Trace: [<c01b291e>] [<c482db9a>] [<c482dc9f>] [<c482951a>] [<c482940c>] [<c482bfc0>] [<c485f4a8>]
       [<c01e177a>] [<c4858aef>] [<c012c0da>] [<c012c125>] [<c0108e0b>]
Code: 66 83 7b 08 00 75 15 a1 68 2a 29 c0 39 43 04 79 0b 8b 03 89

>>EIP; c482dab4 <[sunrpc]rpcauth_gc_credcache+2c/b0>   <=====
Trace; c01b291e <net_tx_action+96/a4>
Trace; c482db9a <[sunrpc]rpcauth_lookup_credcache+36/8c>
Trace; c482dc9f <[sunrpc]rpcauth_bindcred+3b/54>
Trace; c482951a <[sunrpc]rpc_call_setup+36/64>
Trace; c482940c <[sunrpc]rpc_call_sync+64/9c>
Trace; c482bfc0 <[sunrpc]rpc_run_timer+0/44>
Trace; c485f4a8 <[nfs]nfs_proc_statfs+58/7c>
Trace; c01e177a <vsprintf+306/334>
Trace; c4858aef <[nfs]nfs_statfs+33/180>
Trace; c012c0da <vfs_statfs+3a/40>
Trace; c012c125 <sys_statfs+45/f4>
Trace; c0108e0b <system_call+33/38>
Code;  c482dab4 <[sunrpc]rpcauth_gc_credcache+2c/b0>
00000000 <_EIP>:
Code;  c482dab4 <[sunrpc]rpcauth_gc_credcache+2c/b0>   <=====
   0:   66 83 7b 08 00            cmpw   $0x0,0x8(%ebx)   <=====
Code;  c482dab9 <[sunrpc]rpcauth_gc_credcache+31/b0>
   5:   75 15                     jne    1c <_EIP+0x1c> c482dad0 <[sunrpc]rpcauth_gc_credcache+48/b0>
Code;  c482dabb <[sunrpc]rpcauth_gc_credcache+33/b0>
   7:   a1 68 2a 29 c0            mov    0xc0292a68,%eax
Code;  c482dac0 <[sunrpc]rpcauth_gc_credcache+38/b0>
   c:   39 43 04                  cmp    %eax,0x4(%ebx)
Code;  c482dac3 <[sunrpc]rpcauth_gc_credcache+3b/b0>
   f:   79 0b                     jns    1c <_EIP+0x1c> c482dad0 <[sunrpc]rpcauth_gc_credcache+48/b0>
Code;  c482dac5 <[sunrpc]rpcauth_gc_credcache+3d/b0>
  11:   8b 03                     mov    (%ebx),%eax
Code;  c482dac7 <[sunrpc]rpcauth_gc_credcache+3f/b0>
  13:   89 00                     mov    %eax,(%eax)

Unable to handle kernel paging request at virtual address feff3112
c482dab4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c482dab4>]
EFLAGS: 00010286
eax: 00010a9d   ebx: feff310a   ecx: 00000000   edx: c36c5b20
esi: 00000000   edi: c36c5b20   ebp: 00000000   esp: c1d31d14
ds: 0018   es: 0018   ss: 0018
Process df (pid: 1308, stackpage=c1d31000)
Stack: 08048000 c08c7240 40000000 c1d31d4c 00000000 c36c5b20 c36c5b20 c482db9a
       c36c5b20 c1d31da0 c36c5b20 c1d31dd4 c1d31d98 c482dc9f c36c5b20 00000000
       c1d31da0 c1d31e80 c482951a c1d31da0 00000000 c1d31da0 c36efc10 c482940c
Call Trace: [<c482db9a>] [<c482dc9f>] [<c482951a>] [<c482940c>] [<c482bfc0>] [<c485f4a8>] [<c01e177a>]
       [<c4858aef>] [<c012c0da>] [<c012c125>] [<c0108e0b>]
Code: 66 83 7b 08 00 75 15 a1 68 2a 29 c0 39 43 04 79 0b 8b 03 89

>>EIP; c482dab4 <[sunrpc]rpcauth_gc_credcache+2c/b0>   <=====
Trace; c482db9a <[sunrpc]rpcauth_lookup_credcache+36/8c>
Trace; c482dc9f <[sunrpc]rpcauth_bindcred+3b/54>
Trace; c482951a <[sunrpc]rpc_call_setup+36/64>
Trace; c482940c <[sunrpc]rpc_call_sync+64/9c>
Trace; c482bfc0 <[sunrpc]rpc_run_timer+0/44>
Trace; c485f4a8 <[nfs]nfs_proc_statfs+58/7c>
Trace; c01e177a <vsprintf+306/334>
Trace; c4858aef <[nfs]nfs_statfs+33/180>
Trace; c012c0da <vfs_statfs+3a/40>
Trace; c012c125 <sys_statfs+45/f4>
Trace; c0108e0b <system_call+33/38>
Code;  c482dab4 <[sunrpc]rpcauth_gc_credcache+2c/b0>
00000000 <_EIP>:
Code;  c482dab4 <[sunrpc]rpcauth_gc_credcache+2c/b0>   <=====
   0:   66 83 7b 08 00            cmpw   $0x0,0x8(%ebx)   <=====
Code;  c482dab9 <[sunrpc]rpcauth_gc_credcache+31/b0>
   5:   75 15                     jne    1c <_EIP+0x1c> c482dad0 <[sunrpc]rpcauth_gc_credcache+48/b0>
Code;  c482dabb <[sunrpc]rpcauth_gc_credcache+33/b0>
   7:   a1 68 2a 29 c0            mov    0xc0292a68,%eax
Code;  c482dac0 <[sunrpc]rpcauth_gc_credcache+38/b0>
   c:   39 43 04                  cmp    %eax,0x4(%ebx)
Code;  c482dac3 <[sunrpc]rpcauth_gc_credcache+3b/b0>
   f:   79 0b                     jns    1c <_EIP+0x1c> c482dad0 <[sunrpc]rpcauth_gc_credcache+48/b0>
Code;  c482dac5 <[sunrpc]rpcauth_gc_credcache+3d/b0>
  11:   8b 03                     mov    (%ebx),%eax
Code;  c482dac7 <[sunrpc]rpcauth_gc_credcache+3f/b0>
  13:   89 00                     mov    %eax,(%eax)

Unable to handle kernel paging request at virtual address feff3112
c482dab4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c482dab4>]
EFLAGS: 00010286
eax: 00010f52   ebx: feff310a   ecx: 00000000   edx: c36c5b20
esi: 00000000   edi: c36c5b20   ebp: 00000000   esp: c2cd5d14
ds: 0018   es: 0018   ss: 0018
Process df (pid: 1315, stackpage=c2cd5000)
Stack: 08048000 c0d6e1b0 40000000 00000014 00000000 c36c5b20 c36c5b20 c482db9a
       c36c5b20 c2cd5da0 c36c5b20 c2cd5dd4 c2cd5d98 c482dc9f c36c5b20 00000000
       c2cd5da0 c2cd5e80 c482951a c2cd5da0 00000000 c2cd5da0 c36efc10 c482940c
Call Trace: [<c482db9a>] [<c482dc9f>] [<c482951a>] [<c482940c>] [<c482bfc0>] [<c485f4a8>] [<c01e177a>]
       [<c4858aef>] [<c012c0da>] [<c012c125>] [<c0108e0b>]
Code: 66 83 7b 08 00 75 15 a1 68 2a 29 c0 39 43 04 79 0b 8b 03 89

>>EIP; c482dab4 <[sunrpc]rpcauth_gc_credcache+2c/b0>   <=====
Trace; c482db9a <[sunrpc]rpcauth_lookup_credcache+36/8c>
Trace; c482dc9f <[sunrpc]rpcauth_bindcred+3b/54>
Trace; c482951a <[sunrpc]rpc_call_setup+36/64>
Trace; c482940c <[sunrpc]rpc_call_sync+64/9c>
Trace; c482bfc0 <[sunrpc]rpc_run_timer+0/44>
Trace; c485f4a8 <[nfs]nfs_proc_statfs+58/7c>
Trace; c01e177a <vsprintf+306/334>
Trace; c4858aef <[nfs]nfs_statfs+33/180>
Trace; c012c0da <vfs_statfs+3a/40>
Trace; c012c125 <sys_statfs+45/f4>
Trace; c0108e0b <system_call+33/38>
Code;  c482dab4 <[sunrpc]rpcauth_gc_credcache+2c/b0>
00000000 <_EIP>:
Code;  c482dab4 <[sunrpc]rpcauth_gc_credcache+2c/b0>   <=====
   0:   66 83 7b 08 00            cmpw   $0x0,0x8(%ebx)   <=====
Code;  c482dab9 <[sunrpc]rpcauth_gc_credcache+31/b0>
   5:   75 15                     jne    1c <_EIP+0x1c> c482dad0 <[sunrpc]rpcauth_gc_credcache+48/b0>
Code;  c482dabb <[sunrpc]rpcauth_gc_credcache+33/b0>
   7:   a1 68 2a 29 c0            mov    0xc0292a68,%eax
Code;  c482dac0 <[sunrpc]rpcauth_gc_credcache+38/b0>
   c:   39 43 04                  cmp    %eax,0x4(%ebx)
Code;  c482dac3 <[sunrpc]rpcauth_gc_credcache+3b/b0>
   f:   79 0b                     jns    1c <_EIP+0x1c> c482dad0 <[sunrpc]rpcauth_gc_credcache+48/b0>
Code;  c482dac5 <[sunrpc]rpcauth_gc_credcache+3d/b0>
  11:   8b 03                     mov    (%ebx),%eax
Code;  c482dac7 <[sunrpc]rpcauth_gc_credcache+3f/b0>
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
