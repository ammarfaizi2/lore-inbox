Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUGMKtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUGMKtj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 06:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264882AbUGMKtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 06:49:39 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:13852 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S264881AbUGMKt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 06:49:28 -0400
Message-ID: <a4951078040713034939bfcf53@mail.gmail.com>
Date: Tue, 13 Jul 2004 12:49:20 +0200
From: Trippie <trippie@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops in kernel 2.6.x?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel-developers

Three machines in my network reported an oops over a period of a few
weeks. One oops-logs is included in this email (processed by
ksymoops). These three machines are part of an environment of 13
machines running sendmail and mimedefang software. The average load of
the systems is 1.1 with peakloads up to 40. Each machine is identical,
see hardware overview below. The oopsses all occurred during periods
of relatively low usage.

Linux wng-01.evisp.enertel.nl 2.6.5 #1 SMP Tue Apr 6 10:35:37 CEST
2004 i686 i686 i386 GNU/Linux
Hardware: HP DL380 (3rd generation)
Processor: 2x Intel(R) Xeon(TM) CPU 2.80GHz
Memory: 1.5 Gb memory
OS: Fedora Core release 1 (Yarrow)

ksymoops 2.4.9 on i686 2.6.6-rc1.  Options used
    -V (default)
    -k /proc/ksyms (default)
    -l /proc/modules (default)
    -o /lib/modules/2.6.6-rc1/ (default)
    -m /home/spark/System.map-2.6.5-wng (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jul  8 00:15:16 wng-11 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Jul  8 00:15:16 wng-11 kernel: c012c044
Jul  8 00:15:16 wng-11 kernel: *pde = 404c3067
Jul  8 00:15:16 wng-11 kernel: Oops: 0000 [#1]
Jul  8 00:15:16 wng-11 kernel: CPU:    0
Jul  8 00:15:16 wng-11 kernel: EIP:    0060:[<c012c044>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul  8 00:15:16 wng-11 kernel: EFLAGS: 00010246   (2.6.5)
Jul  8 00:15:16 wng-11 kernel: eax: 00000000   ebx: 00000001   ecx:
00000000   edx: 00000000
Jul  8 00:15:16 wng-11 kernel: esi: 00000000   edi: 00000000   ebp:
d56e9ea4   esp: d56e9e98
Jul  8 00:15:16 wng-11 kernel: ds: 007b   es: 007b   ss: 0068
Jul  8 00:15:16 wng-11 kernel: Stack: d56e8000 00000001 f7ab7b14
d56e9ebc c012c216 d53dc480 00000000 000041ed
Jul  8 00:15:16 wng-11 kernel:        c2942001 d56e9f14 c015f2c9
00000000 fffed6c4 db08e000 daa24580 d56e9f04
Jul  8 00:15:16 wng-11 kernel:        c014281f daa24580 c73d7a80
000006c4 00000101 d56e9f68 db08e000 00000000
Jul  8 00:15:16 wng-11 kernel: Call Trace:
Jul  8 00:15:16 wng-11 kernel:  [<c012c216>] in_group_p+0x43/0x76
Jul  8 00:15:16 wng-11 kernel:  [<c015f2c9>] link_path_walk+0x9de/0xa5e
Jul  8 00:15:16 wng-11 kernel:  [<c014281f>] handle_mm_fault+0x100/0x1b9
Jul  8 00:15:16 wng-11 kernel:  [<c015fcbd>] open_namei+0x84/0x3f1
Jul  8 00:15:16 wng-11 kernel:  [<c014fb20>] filp_open+0x3c/0x5f
Jul  8 00:15:16 wng-11 kernel:  [<c014ffa1>] sys_open+0x55/0x85
Jul  8 00:15:16 wng-11 kernel:  [<c010715b>] syscall_call+0x7/0xb
Jul  8 00:15:16 wng-11 kernel: Code: 2b 3c 90 85 ff 7e 0e 8d 71 01 39
de 7c be 31 c0 5b 5e 5f 5d

>>EIP; c012c044 <groups_search+4e/70>   <=====

>>ebp; d56e9ea4 <pg0+1522fea4/3fb44000>
>>esp; d56e9e98 <pg0+1522fe98/3fb44000>

Trace; c012c216 <in_group_p+43/76>
Trace; c015f2c9 <link_path_walk+9de/a5e>
Trace; c014281f <handle_mm_fault+100/1b9>
Trace; c015fcbd <open_namei+84/3f1>
Trace; c014fb20 <filp_open+3c/5f>
Trace; c014ffa1 <sys_open+55/85>
Trace; c010715b <syscall_call+7/b>

Code;  c012c044 <groups_search+4e/70>
00000000 <_EIP>:
Code;  c012c044 <groups_search+4e/70>   <=====
  0:   2b 3c 90                  sub    (%eax,%edx,4),%edi   <=====
Code;  c012c047 <groups_search+51/70>
  3:   85 ff                     test   %edi,%edi
Code;  c012c049 <groups_search+53/70>
  5:   7e 0e                     jle    15 <_EIP+0x15>
Code;  c012c04b <groups_search+55/70>
  7:   8d 71 01                  lea    0x1(%ecx),%esi
Code;  c012c04e <groups_search+58/70>
  a:   39 de                     cmp    %ebx,%esi
Code;  c012c050 <groups_search+5a/70>
  c:   7c be                     jl     ffffffcc <_EIP+0xffffffcc>
Code;  c012c052 <groups_search+5c/70>
  e:   31 c0                     xor    %eax,%eax
Code;  c012c054 <groups_search+5e/70>
 10:   5b                        pop    %ebx
Code;  c012c055 <groups_search+5f/70>
 11:   5e                        pop    %esi
Code;  c012c056 <groups_search+60/70>
 12:   5f                        pop    %edi
Code;  c012c057 <groups_search+61/70>
 13:   5d                        pop    %ebp

1 error issued.  Results may not be reliable.

I'm not much of a kernel developer. In fact not a kernel developer at
all. So i hope some of you out there can help me figure this out. I
will provide whatever assistance i can, if anyone needs more info tell
me :).

I have the kernel config and the system.map file ready, but they are
probably to large to mail to the entire list. I will mail them if
someone needs it..

Thanks!

Regards

Hugo

-- 
Tsune ni ite, kyu ni awasu.

Trippie
trippie@gmail.com
