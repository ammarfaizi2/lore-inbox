Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319340AbSIMAJH>; Thu, 12 Sep 2002 20:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319365AbSIMAJH>; Thu, 12 Sep 2002 20:09:07 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:51862 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S319340AbSIMAJF>; Thu, 12 Sep 2002 20:09:05 -0400
Date: Thu, 12 Sep 2002 17:13:39 -0700 (PDT)
From: Syam Sundar V Appala <syam@cisco.com>
To: linux-mm@kvack.org, <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.19 init_buffer_head error
Message-ID: <Pine.GSO.4.44.0209121709190.1540-100000@msabu-view1.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am using kernel 2.4.19 and when I am trying to install few rpms, I got
an error. The details are given below. Can someone explain what is wrong
or can someone suggest me a fix?

Error (dmesg output):
--------------------
general protection fault: 0000
CPU:    0
EIP:    0010:[<c0141099>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: ffffffff   ecx: 00000018   edx: c0141080
esi: c12c3e30   edi: ffffffff   ebp: ffffffff   esp: cfc95db0
ds: 0018   es: 0018   ss: 0018
Process rpm (pid: 59, stackpage=cfc95000)
Stack: 00000000 c0feb020 c01284ca ffffffff c12c3e30 00000001 00000001
000000f0
       c0feb000 c139c1a0 00000080 00000000 00000008 c12c3e30 00000246
c12c3e38
       000000f0 c01285f9 c12c3e30 000000f0 c0178612 00000000 00000000
00000008
Call Trace:    [<c01284ca>] [<c01285f9>] [<c0178612>] [<c0131a84>]
[<c0131b46>]
  [<c0131d88>] [<c0132428>] [<c01231fd>] [<c0123298>] [<c0151aa0>]
[<c01238a5>]
  [<c0123c03>] [<c012403c>] [<c0123f40>] [<c012fd56>] [<c012fca9>]
[<c01087eb>]

Code: f3 ab c7 43 48 00 00 00 00 8d 53 48 8d 43 4c 89 42 04 89 42


ksymoops output:
---------------
bash-2.05a# ksymoops -v vmlinux -k /proc/ksyms -m System.map crash
ksymoops 2.4.5 on i686 2.4.19.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m System.map (specified)

sh: /usr/bin/nm: No such file or directory
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_vmlinux): no kernel symbols in vmlinux, is vmlinux a valid
vmlinux file?
No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
CPU:    0
EIP:    0010:[<c0141099>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: ffffffff   ecx: 00000018   edx: c0141080
esi: c12c3e30   edi: ffffffff   ebp: ffffffff   esp: cfc95db0
ds: 0018   es: 0018   ss: 0018
Process rpm (pid: 59, stackpage=cfc95000)
Stack: 00000000 c0feb020 c01284ca ffffffff c12c3e30 00000001 00000001
000000f0
       c0feb000 c139c1a0 00000080 00000000 00000008 c12c3e30 00000246
c12c3e38
       000000f0 c01285f9 c12c3e30 000000f0 c0178612 00000000 00000000
00000008
Call Trace:    [<c01284ca>] [<c01285f9>] [<c0178612>] [<c0131a84>]
[<c0131b46>]
  [<c0131d88>] [<c0132428>] [<c01231fd>] [<c0123298>] [<c0151aa0>]
[<c01238a5>]
  [<c0123c03>] [<c012403c>] [<c0123f40>] [<c012fd56>] [<c012fca9>]
[<c01087eb>]
Code: f3 ab c7 43 48 00 00 00 00 8d 53 48 8d 43 4c 89 42 04 89 42
sh: /usr/bin/objdump: No such file or directory
Error (pclose_local): Oops_decode pclose failed 0x7f00
Error (Oops_decode): no objdump lines read for /tmp/ksymoops.XaLnWD


>>EIP; c0141099 <init_buffer_head+19/40>   <=====

>>ebx; ffffffff <END_OF_CODE+3fd9f0e3/????>
>>edx; c0141080 <init_buffer_head+0/40>
>>esi; c12c3e30 <END_OF_CODE+1062f14/????>
>>edi; ffffffff <END_OF_CODE+3fd9f0e3/????>
>>ebp; ffffffff <END_OF_CODE+3fd9f0e3/????>
>>esp; cfc95db0 <END_OF_CODE+fa34e94/????>

Trace; c01284ca <kmem_cache_grow+19a/220>
Trace; c01285f9 <kmem_cache_alloc+a9/c0>
Trace; c0178612 <__make_request+4c2/5c0>
Trace; c0131a84 <get_unused_buffer_head+34/80>
Trace; c0131b46 <create_buffers+26/f0>
Trace; c0131d88 <create_empty_buffers+18/60>
Trace; c0132428 <block_read_full_page+58/220>
Trace; c01231fd <add_to_page_cache_unique+6d/80>
Trace; c0123298 <page_cache_read+88/c0>
Trace; c0151aa0 <ext2_get_block+0/320>
Trace; c01238a5 <generic_file_readahead+f5/130>
Trace; c0123c03 <do_generic_file_read+2e3/430>
Trace; c012403c <generic_file_read+7c/130>
Trace; c0123f40 <file_read_actor+0/80>
Trace; c012fd56 <sys_read+96/f0>
Trace; c012fca9 <sys_llseek+c9/e0>
Trace; c01087eb <system_call+33/38>


2 warnings and 3 errors issued.  Results may not be reliable.


Thanks in advance,
Syam


