Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTAODqb>; Tue, 14 Jan 2003 22:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbTAODqb>; Tue, 14 Jan 2003 22:46:31 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:6830
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S261205AbTAODq3>; Tue, 14 Jan 2003 22:46:29 -0500
Message-ID: <3E24DBAA.4060701@tupshin.com>
Date: Tue, 14 Jan 2003 19:55:22 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel NULL pointer kernel 2.4.21-pre3-ac4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting bits:
KT400
LVM2(hence the ac tree)
reiserfs
happened during a lengthy mysql operation.

Jan 14 19:39:17 fussbudget kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Jan 14 19:39:17 fussbudget kernel: c0133c58
Jan 14 19:39:17 fussbudget kernel: *pde = 00000000
Jan 14 19:39:17 fussbudget kernel: Oops: 0002
Jan 14 19:39:17 fussbudget kernel: CPU:    0
Jan 14 19:39:17 fussbudget kernel: EIP: 
0010:[__free_pages_ok+600/640]    Tainted: PF
Jan 14 19:39:17 fussbudget kernel: EFLAGS: 00210246
Jan 14 19:39:17 fussbudget kernel: eax: 00000000   ebx: c10cfc00   ecx: 
c5662000   edx: c566205c
Jan 14 19:39:17 fussbudget kernel: esi: 00000000   edi: 00003b37   ebp: 
c0378350   esp: c5663e58
Jan 14 19:39:17 fussbudget kernel: ds: 0018   es: 0018   ss: 0018
Jan 14 19:39:17 fussbudget kernel: Process mysqld (pid: 2415, 
stackpage=c5663000)
Jan 14 19:39:17 fussbudget kernel: Stack: 00000001 00200282 caa14d40 
caa14d40 caa14d40 c10cfc00 c013f135 caa14d40
Jan 14 19:39:17 fussbudget kernel:        dd53a428 c10cfc00 00003b37 
c0378350 c0132e1f c10cfc00 000001d2 c5662000
Jan 14 19:39:17 fussbudget kernel:        00000200 000001d2 00000020 
00000020 000001d2 00000020 00000006 c0133061
Jan 14 19:39:17 fussbudget kernel: Call Trace: 
[try_to_free_buffers+133/240] [shrink_cache+527/768] 
[shrink_caches+97/176] [try_to_free_pages_zone+54/96] 
[balance_classzone+85/480]
Jan 14 19:39:17 fussbudget kernel: Code: 89 58 04 89 03 89 53 04 89 59 
5c 89 73 0c ff 41 68 eb c1 0f
Using defaults from ksymoops -t elf32-i386 -a i386


 >>ebx; c10cfc00 <_end+c944bc/205ca93c>
 >>ecx; c5662000 <_end+52268bc/205ca93c>
 >>edx; c566205c <_end+5226918/205ca93c>
 >>ebp; c0378350 <contig_page_data+b0/340>
 >>esp; c5663e58 <_end+5228714/205ca93c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  00000003 Before first symbol
    3:   89 03                     mov    %eax,(%ebx)
Code;  00000005 Before first symbol
    5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  00000008 Before first symbol
    8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  0000000b Before first symbol
    b:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  0000000e Before first symbol
    e:   ff 41 68                  incl   0x68(%ecx)
Code;  00000011 Before first symbol
   11:   eb c1                     jmp    ffffffd4 <_EIP+0xffffffd4>
Code;  00000013 Before first symbol
   13:   0f 00 00                  sldtl  (%eax)

