Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269726AbRIHOVX>; Sat, 8 Sep 2001 10:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269718AbRIHOVO>; Sat, 8 Sep 2001 10:21:14 -0400
Received: from dialup311.canberra.net.au ([203.33.188.183]:4 "EHLO
	didi.local.net") by vger.kernel.org with ESMTP id <S269673AbRIHOVA>;
	Sat, 8 Sep 2001 10:21:00 -0400
Message-ID: <000701c13856$14e01fe0$0200a8c0@W2K>
From: "Nick Piggin" <s3293115@student.anu.edu.au>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.10-pre5: Bug in alloc_pages
Date: Sat, 8 Sep 2001 21:04:43 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few Oopses which appeared in 2.4.10-pre5 (not in pre4). The first
2 appeared during the startup scripts and the next ones appeared over the
next 20 minutes or so. I'd be happy to try patches. Please CC me.

Nick

kernel BUG at page_alloc.c:204!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012c3b6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000020   ebx: c1008a80   ecx: 00000000   edx: c3f8b920
esi: c1000000   edi: 00001000   ebp: c0209080   esp: c130da34
ds: 0018   es: 0018   ss: 0018
Process squid (pid: 462, stackpage=c130d000)
Stack: c01e7d60 c01e7d53 000000cc 0000022a 00000282 00000000 c0209080
c18cd040
       00000001 c1008ac0 c01248e8 c1008ac0 c12cf840 c12cf7e0 c12cf780
c0209080
       c02092b8 00000000 c02092b0 c012c5aa 00000001 000001d2 c18cd0d8
00003644
Call Trace: [<c01248e8>] [<c012c5aa>] [<c01249a0>] [<c0125ab0>] [<c0122895>]
   [<c01229fe>] [<c014630b>] [<c0125122>] [<c0111a10>] [<c0111ce5>]
[<c0111a10>]
   [<c0106e0c>] [<c01db8b0>] [<c0111a10>] [<c0106e0c>] [<c0120018>]
[<c01db8b0>]
   [<c014745c>] [<c0148081>] [<c0188fdb>] [<c0112624>] [<c012c5aa>]
[<c0147b10>]
   [<c013ad3d>] [<c013afa9>] [<c013bf2b>] [<c0105907>] [<c0106d1b>]
Code: 0f 0b 83 c4 0c 89 d8 e9 a4 fe ff ff 8b 43 18 a9 80 00 00 00

>>EIP; c012c3b6 <rmqueue+196/280>   <=====
Trace; c01248e8 <add_to_page_cache_unique+a8/b0>
Trace; c012c5aa <__alloc_pages+4a/2b0>
Trace; c01249a0 <read_cluster_nonblocking+b0/100>
Trace; c0125ab0 <filemap_nopage+1d0/400>
Trace; c0122894 <do_no_page+44/e0>
Trace; c01229fe <handle_mm_fault+ce/e0>
Trace; c014630a <update_atime+4a/50>
Trace; c0125122 <do_generic_file_read+232/530>
Trace; c0111a10 <do_page_fault+0/4a0>
Trace; c0111ce4 <do_page_fault+2d4/4a0>
Trace; c0111a10 <do_page_fault+0/4a0>
Trace; c0106e0c <error_code+34/3c>
Trace; c01db8b0 <clear_user+30/40>
Trace; c0111a10 <do_page_fault+0/4a0>
Trace; c0106e0c <error_code+34/3c>
Trace; c0120018 <exec_usermodehelper+298/3c0>
Trace; c01db8b0 <clear_user+30/40>
Trace; c014745c <padzero+1c/20>
Trace; c0148080 <load_elf_binary+570/a50>
Trace; c0188fda <submit_bh+3a/80>
Trace; c0112624 <schedule+1f4/3f0>
Trace; c012c5aa <__alloc_pages+4a/2b0>
Trace; c0147b10 <load_elf_binary+0/a50>
Trace; c013ad3c <search_binary_handler+6c/190>
Trace; c013afa8 <do_execve+148/200>
Trace; c013bf2a <getname+6a/b0>
Trace; c0105906 <sys_execve+36/60>
Trace; c0106d1a <system_call+32/38>
Code;  c012c3b6 <rmqueue+196/280>
00000000 <_EIP>:
Code;  c012c3b6 <rmqueue+196/280>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c3b8 <rmqueue+198/280>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012c3ba <rmqueue+19a/280>
   5:   89 d8                     mov    %ebx,%eax
Code;  c012c3bc <rmqueue+19c/280>
   7:   e9 a4 fe ff ff            jmp    fffffeb0 <_EIP+0xfffffeb0> c012c266
<rmqueue+46/280>
Code;  c012c3c2 <rmqueue+1a2/280>
   c:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012c3c4 <rmqueue+1a4/280>
   f:   a9 80 00 00 00            test   $0x80,%eax

kernel BUG at page_alloc.c:204!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012c3b6>]
EFLAGS: 00010282
eax: 00000020   ebx: c1008ac0   ecx: 00000005   edx: c3f8b620
esi: c1000000   edi: 00001000   ebp: c0209080   esp: c2225df0
ds: 0018   es: 0018   ss: 0018
Process xfs-xtt (pid: 450, stackpage=c2225000)
Stack: c01e7d60 c01e7d53 000000cc 0000022b 00000286 00000000 c0209080
0044c35c
       c0279fa0 c3fbd300 c018bec0 c0279fa0 c3fbd300 0044c35c 00000028
c0209080
       c02092b8 00000000 c02092b0 c012c5aa 00000001 000001d2 00000000
c3f8b620
Call Trace: [<c018bec0>] [<c012c5aa>] [<c01227cf>] [<c012292a>] [<c01229fe>]
   [<c014630b>] [<c0125122>] [<c0111a10>] [<c0111ce5>] [<c01254eb>]
[<c0125420>]
   [<c0131ed3>] [<c0118a4b>] [<c0111a10>] [<c0106e0c>]
Code: 0f 0b 83 c4 0c 89 d8 e9 a4 fe ff ff 8b 43 18 a9 80 00 00 00

>>EIP; c012c3b6 <rmqueue+196/280>   <=====
Trace; c018bec0 <start_request+170/220>
Trace; c012c5aa <__alloc_pages+4a/2b0>
Trace; c01227ce <do_anonymous_page+3e/c0>
Trace; c012292a <do_no_page+da/e0>
Trace; c01229fe <handle_mm_fault+ce/e0>
Trace; c014630a <update_atime+4a/50>
Trace; c0125122 <do_generic_file_read+232/530>
Trace; c0111a10 <do_page_fault+0/4a0>
Trace; c0111ce4 <do_page_fault+2d4/4a0>
Trace; c01254ea <generic_file_read+6a/80>
Trace; c0125420 <file_read_actor+0/60>
Trace; c0131ed2 <sys_read+82/d0>
Trace; c0118a4a <do_softirq+5a/a0>
Trace; c0111a10 <do_page_fault+0/4a0>
Trace; c0106e0c <error_code+34/3c>
Code;  c012c3b6 <rmqueue+196/280>
00000000 <_EIP>:
Code;  c012c3b6 <rmqueue+196/280>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c3b8 <rmqueue+198/280>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012c3ba <rmqueue+19a/280>
   5:   89 d8                     mov    %ebx,%eax
Code;  c012c3bc <rmqueue+19c/280>
   7:   e9 a4 fe ff ff            jmp    fffffeb0 <_EIP+0xfffffeb0> c012c266
<rmqueue+46/280>
Code;  c012c3c2 <rmqueue+1a2/280>
   c:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012c3c4 <rmqueue+1a4/280>
   f:   a9 80 00 00 00            test   $0x80,%eax

kernel BUG at page_alloc.c:204!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012c3b6>]
EFLAGS: 00010286
eax: 00000020   ebx: c1008a80   ecx: 00000005   edx: c1f221c0
esi: c1000000   edi: 00001000   ebp: c0209080   esp: c141ddb4
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 608, stackpage=c141d000)
Stack: c01e7d60 c01e7d53 000000cc 0000022a 00000286 00000000 c0209080
c1d6f740
       c141c000 c1009100 c01248e8 c1009100 c023e840 c023e7e0 c023e780
c0209080
       c02092b8 00000000 c02092b0 c012c5aa 00000001 000001d2 c1d6f7d8
0000001f
Call Trace: [<c01248e8>] [<c012c5aa>] [<c01249a0>] [<c0125ab0>] [<c01227cf>]
   [<c0122895>] [<c01229fe>] [<c01215ad>] [<c0111a10>] [<c0111ce5>]
[<c0123893>]
   [<c01317d1>] [<c01316d2>] [<c013bf2b>] [<c0131a04>] [<c0111a10>]
[<c0106e0c>]
Code: 0f 0b 83 c4 0c 89 d8 e9 a4 fe ff ff 8b 43 18 a9 80 00 00 00

>>EIP; c012c3b6 <rmqueue+196/280>   <=====
Trace; c01248e8 <add_to_page_cache_unique+a8/b0>
Trace; c012c5aa <__alloc_pages+4a/2b0>
Trace; c01249a0 <read_cluster_nonblocking+b0/100>
Trace; c0125ab0 <filemap_nopage+1d0/400>
Trace; c01227ce <do_anonymous_page+3e/c0>
Trace; c0122894 <do_no_page+44/e0>
Trace; c01229fe <handle_mm_fault+ce/e0>
Trace; c01215ac <zap_page_range+22c/260>
Trace; c0111a10 <do_page_fault+0/4a0>
Trace; c0111ce4 <do_page_fault+2d4/4a0>
Trace; c0123892 <do_munmap+62/2a0>
Trace; c01317d0 <dentry_open+f0/160>
Trace; c01316d2 <filp_open+52/60>
Trace; c013bf2a <getname+6a/b0>
Trace; c0131a04 <sys_open+74/b0>
Trace; c0111a10 <do_page_fault+0/4a0>
Trace; c0106e0c <error_code+34/3c>
Code;  c012c3b6 <rmqueue+196/280>
00000000 <_EIP>:
Code;  c012c3b6 <rmqueue+196/280>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c3b8 <rmqueue+198/280>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012c3ba <rmqueue+19a/280>
   5:   89 d8                     mov    %ebx,%eax
Code;  c012c3bc <rmqueue+19c/280>
   7:   e9 a4 fe ff ff            jmp    fffffeb0 <_EIP+0xfffffeb0> c012c266
<rmqueue+46/280>
Code;  c012c3c2 <rmqueue+1a2/280>
   c:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012c3c4 <rmqueue+1a4/280>
   f:   a9 80 00 00 00            test   $0x80,%eax

kernel BUG at page_alloc.c:75!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012bf72>]
EFLAGS: 00010282
eax: 0000001f   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c1008a80   edi: 00000007   ebp: 00000001   esp: c3fc1f60
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c3fc1000)
Stack: c01e7d60 c01e7d53 0000004b c0145b22 c3fc1f7c 00000001 00000000
c1008a9c
       00000000 00000000 c1008a80 00000007 00000001 c012b368 00000002
00000006
       000001c0 00000019 00000001 c012b969 000001c0 00000001 000001c0
00000001
Call Trace: [<c0145b22>] [<c012b368>] [<c012b969>] [<c012ba3e>] [<c0105000>]
   [<c0105000>] [<c01054d6>] [<c012b9e0>]
Code: 0f 0b 83 c4 0c 8b 1d 6c 0c 26 c0 89 f2 29 da c1 fa 06 3b 15

>>EIP; c012bf72 <__free_pages_ok+42/2f0>   <=====
Trace; c0145b22 <prune_icache+92/140>
Trace; c012b368 <page_launder+548/8e0>
Trace; c012b968 <do_try_to_free_pages+48/c0>
Trace; c012ba3e <kswapd+5e/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c01054d6 <kernel_thread+26/30>
Trace; c012b9e0 <kswapd+0/c0>
Code;  c012bf72 <__free_pages_ok+42/2f0>
00000000 <_EIP>:
Code;  c012bf72 <__free_pages_ok+42/2f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012bf74 <__free_pages_ok+44/2f0>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012bf76 <__free_pages_ok+46/2f0>
   5:   8b 1d 6c 0c 26 c0         mov    0xc0260c6c,%ebx
Code;  c012bf7c <__free_pages_ok+4c/2f0>
   b:   89 f2                     mov    %esi,%edx
Code;  c012bf7e <__free_pages_ok+4e/2f0>
   d:   29 da                     sub    %ebx,%edx
Code;  c012bf80 <__free_pages_ok+50/2f0>
   f:   c1 fa 06                  sar    $0x6,%edx
Code;  c012bf84 <__free_pages_ok+54/2f0>
  12:   3b 15 00 00 00 00         cmp    0x0,%edx

kernel BUG at vmscan.c:451!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012ad54>]
EFLAGS: 00010286
eax: 0000001c   ebx: c1008a9c   ecx: 00000004   edx: c1f223c0
esi: c18cd7d8   edi: c1008a80   ebp: c0209098   esp: c3453df8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 905, stackpage=c3453000)
Stack: c01e7b29 c01e7b20 000001c3 c0209080 c02092b8 00000001 00000001
c012c4e5
       c0209080 00000000 c02092bc 00000000 c02092b0 c012c5e0 c02092b0
00000000
       00000001 00000001 00000001 000001d2 00000000 c1f223c0 00000001
c27adae0
Call Trace: [<c012c4e5>] [<c012c5e0>] [<c01227cf>] [<c012292a>] [<c01229fe>]
   [<c014630b>] [<c0125122>] [<c0111a10>] [<c0111ce5>] [<c01254eb>]
[<c0125420>]
   [<c0131ed3>] [<c0150800>] [<c0111a10>] [<c0106e0c>]
Code: 0f 0b 83 c4 0c e9 7c ff ff ff 89 f6 8b 47 18 a9 80 00 00 00

>>EIP; c012ad54 <reclaim_page+3a4/470>   <=====
Trace; c012c4e4 <__alloc_pages_limit+44/a0>
Trace; c012c5e0 <__alloc_pages+80/2b0>
Trace; c01227ce <do_anonymous_page+3e/c0>
Trace; c012292a <do_no_page+da/e0>
Trace; c01229fe <handle_mm_fault+ce/e0>
Trace; c014630a <update_atime+4a/50>
Trace; c0125122 <do_generic_file_read+232/530>
Trace; c0111a10 <do_page_fault+0/4a0>
Trace; c0111ce4 <do_page_fault+2d4/4a0>
Trace; c01254ea <generic_file_read+6a/80>
Trace; c0125420 <file_read_actor+0/60>
Trace; c0131ed2 <sys_read+82/d0>
Trace; c0150800 <ext2_file_lseek+0/b0>
Trace; c0111a10 <do_page_fault+0/4a0>
Trace; c0106e0c <error_code+34/3c>
Code;  c012ad54 <reclaim_page+3a4/470>
00000000 <_EIP>:
Code;  c012ad54 <reclaim_page+3a4/470>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012ad56 <reclaim_page+3a6/470>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012ad58 <reclaim_page+3a8/470>
   5:   e9 7c ff ff ff            jmp    ffffff86 <_EIP+0xffffff86> c012acda
<reclaim_page+32a/470>
Code;  c012ad5e <reclaim_page+3ae/470>
   a:   89 f6                     mov    %esi,%esi
Code;  c012ad60 <reclaim_page+3b0/470>
   c:   8b 47 18                  mov    0x18(%edi),%eax
Code;  c012ad62 <reclaim_page+3b2/470>
   f:   a9 80 00 00 00            test   $0x80,%eax

