Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267011AbSKVIvl>; Fri, 22 Nov 2002 03:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267014AbSKVIvl>; Fri, 22 Nov 2002 03:51:41 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:58257
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S267011AbSKVIvi>; Fri, 22 Nov 2002 03:51:38 -0500
Message-ID: <3DDDF1D2.3050406@tupshin.com>
Date: Fri, 22 Nov 2002 00:58:58 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: paging oops with 2.4.20-rc2
References: <3DDD8339.2040409@tupshin.com> <20021122095450.A8056@namesys.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>Hello!
>
>  
>
>Is the oops always the same and looks like the one you've posted here?
>Or is it different from time to time?
>If it always the same, can you please try to compile your kernel with
>CONFIG_REISERFS_CHECK (reiserfs debug) option enabled and see what happens?
>
>Thank you.
>
>  
>
Well after looking more at my logs, I realize that I'm hitting a kernel 
BUG in page_alloc.c more often than the previous oops that I posted, and 
always as a (not necessarily immediate) precursor. Here's the log:

 kernel BUG at page_alloc.c:100!
invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+54/656]    Not tainted
EFLAGS: 00010282
eax: c1404914   ebx: c141d15c   ecx: c141d178   edx: c140782c
esi: 00000000   edi: c864079c   ebp: 085e4000   esp: d7619e30
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 20387, stackpage=d7619000)
Stack: c141d15c 00003000 c864079c 085e4000 c0378900 00000000 c031bdf4 
c102c01c
       c031be0c 00000213 ffffffff 00016ef5 0000b77a c012b47b c012b873 
c141d15c
       c0120d90 c141d15c 0021c000 c01211b3 17ef0067 c85a96c0 c8aef2c0 
081e4000
Call Trace:    [__free_pages+27/32] [free_page_and_swap_cache+51/64] 
[__free_pte+64/80] [zap_page_range+403/576] [exit_mmap+181/288]
Code: 0f 0b 64 00 d3 d2 2b c0 83 7b 08 00 74 08 0f 0b 66 00 d3 d2
Using defaults from ksymoops -t elf32-i386 -a i386


 >>eax; c1404914 <_end+103b1d0/20b1491c>
 >>ebx; c141d15c <_end+1053a18/20b1491c>
 >>ecx; c141d178 <_end+1053a34/20b1491c>
 >>edx; c140782c <_end+103e0e8/20b1491c>
 >>edi; c864079c <_end+8277058/20b1491c>
 >>esp; d7619e30 <_end+172506ec/20b1491c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a  
Code;  00000002 Before first symbol
   2:   64                        fs
Code;  00000003 Before first symbol
   3:   00 d3                     add    %dl,%bl
Code;  00000005 Before first symbol
   5:   d2 2b                     shrb   %cl,(%ebx)
Code;  00000007 Before first symbol
   7:   c0 83 7b 08 00 74 08      rolb   $0x8,0x7400087b(%ebx)
Code;  0000000e Before first symbol
   e:   0f 0b                     ud2a  
Code;  00000010 Before first symbol
  10:   66                        data16
Code;  00000011 Before first symbol
  11:   00 d3                     add    %dl,%bl
Code;  00000013 Before first symbol
  13:   d2 00                     rolb   %cl,(%eax)

 kernel BUG at page_alloc.c:100!
invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+54/656]    Not tainted
EFLAGS: 00010282
eax: 0100000d   ebx: c141d15c   ecx: c141d15c   edx: 00000000
esi: 00000000   edi: 00000000   ebp: c0194a90   esp: c15b5f78
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 6, stackpage=c15b5000)
Stack: c141d15c d76db230 00000000 c0194a90 d76db230 00000000 c8aef080 
c15b5fc8
       00027557 c0194aad c141d15c df5de000 c141d15c c012b47b c0124071 
00000004
       d76db180 df5de060 df5de000 c0142c1c d76db230 c15b4000 c02bde17 
c15b424b
Call Trace:    [reiserfs_writepage+0/48] [reiserfs_writepage+29/48] 
[__free_pages+27/32] [filemap_fdatasync+129/144] 
[sync_unlocked_inodes+140/384]
Code: 0f 0b 64 00 d3 d2 2b c0 83 7b 08 00 74 08 0f 0b 66 00 d3 d2


 >>ebx; c141d15c <_end+1053a18/20b1491c>
 >>ecx; c141d15c <_end+1053a18/20b1491c>
 >>ebp; c0194a90 <reiserfs_writepage+0/30>
 >>esp; c15b5f78 <_end+11ec834/20b1491c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a  
Code;  00000002 Before first symbol
   2:   64                        fs
Code;  00000003 Before first symbol
   3:   00 d3                     add    %dl,%bl
Code;  00000005 Before first symbol
   5:   d2 2b                     shrb   %cl,(%ebx)
Code;  00000007 Before first symbol
   7:   c0 83 7b 08 00 74 08      rolb   $0x8,0x7400087b(%ebx)
Code;  0000000e Before first symbol
   e:   0f 0b                     ud2a  
Code;  00000010 Before first symbol
  10:   66                        data16
Code;  00000011 Before first symbol
  11:   00 d3                     add    %dl,%bl
Code;  00000013 Before first symbol
  13:   d2 00                     rolb   %cl,(%eax)

 kernel BUG at page_alloc.c:100!
invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+54/656]    Not tainted
EFLAGS: 00010282
eax: 01000008   ebx: c141d15c   ecx: c141d15c   edx: 00000000
esi: 00000000   edi: d76db230   ebp: 00000001   esp: d3bd3ef8
ds: 0018   es: 0018   ss: 0018
Process ld (pid: 21231, stackpage=d3bd3000)
Stack: c141d15c 00001000 d76db230 00000001 00000018 ffffffff c0124fda 
00000010
       00010216 c141d15c dfeb8778 d76db230 00000000 c012b47b c0124b53 
d3bd3f8c
       c141d15c 00000000 00001000 00000000 d9703640 00000000 40013000 
00001000
Call Trace:    [file_read_actor+90/144] [__free_pages+27/32] 
[do_generic_file_read+499/1024] [generic_file_read+127/272] 
[file_read_actor+0/144]
Code: 0f 0b 64 00 d3 d2 2b c0 83 7b 08 00 74 08 0f 0b 66 00 d3 d2


 >>ebx; c141d15c <_end+1053a18/20b1491c>
 >>ecx; c141d15c <_end+1053a18/20b1491c>
 >>edi; d76db230 <_end+17311aec/20b1491c>
 >>esp; d3bd3ef8 <_end+1380a7b4/20b1491c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a  
Code;  00000002 Before first symbol
   2:   64                        fs
Code;  00000003 Before first symbol
   3:   00 d3                     add    %dl,%bl
Code;  00000005 Before first symbol
   5:   d2 2b                     shrb   %cl,(%ebx)
Code;  00000007 Before first symbol
   7:   c0 83 7b 08 00 74 08      rolb   $0x8,0x7400087b(%ebx)
Code;  0000000e Before first symbol
   e:   0f 0b                     ud2a  
Code;  00000010 Before first symbol
  10:   66                        data16
Code;  00000011 Before first symbol
  11:   00 d3                     add    %dl,%bl
Code;  00000013 Before first symbol
  13:   d2 00                     rolb   %cl,(%eax)



