Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313182AbSERPBm>; Sat, 18 May 2002 11:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSERPBl>; Sat, 18 May 2002 11:01:41 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:34773 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S313182AbSERPBj>; Sat, 18 May 2002 11:01:39 -0400
Subject: Oops using 2.4.19-pre8-ac4 with ftl_cs from pcmcia-cs 3.1.33
From: Roel Teuwen <Roel.Teuwen@advalvas.be>
To: dahinds@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 May 2002 17:06:43 +0200
Message-Id: <1021734403.19686.14.camel@tux3>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using an flash card in linux 2.4.19-pre8-ac4 using the modules from
pcmcia-cs 3.1.33, I encountered the following (I think when doing
rmmod):

memory_cs: mem0: common 20 mb, attribute 2 kb
ftl_cs: ftl0: 20 mb
ftl_cs: OpenMemory: Bad offset
Unable to handle kernel NULL pointer dereference at virtual address
00000246
 printing eip:
c01aaea0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01aaea0>]    Not tainted
EFLAGS: 00010202
eax: 00000246   ebx: 00000246   ecx: 00000004   edx: c5c8e164
esi: 00000000   edi: 00000000   ebp: c67e9f4c   esp: c67e9ef8
ds: 0018   es: 0018   ss: 0018
Process ftl_check (pid: 1373, stackpage=c67e9000)
Stack: c01ae9c6 00000246 c75d213c c11e01a0 00000000 00000001 c88b56ea
00000004 
       00000246 c5c8e164 c0125189 c11e01a0 c5c8e0a0 00000000 c5886340
00000000 
       c013818c c5c8e154 00000000 c75d2000 c75d2000 c5886340 c0138d49
c5c8e0a0 
Call Trace: [<c01ae9c6>] [<c88b56ea>] [<c0125189>] [<c013818c>]
[<c0138d49>] 
   [<c0138da2>] [<c01340a4>] [<c0133145>] [<c0133193>] [<c0108563>] 

Code: 66 81 38 c9 e3 74 09 b8 21 00 00 00 c3 8d 76 00 31 c0 c3 90 
 <5>sram_mtd: ReleaseWindow: Bad handle
iflash2+_mtd: ReleaseWindow: Bad handle
iflash2+_mtd: ReleaseWindow: Bad handle
iflash2+_mtd: DeregisterClient: Resource in use
sram_mtd: DeregisterClient: Resource in use

Decoded this gives the following :

Unable to handle kernel NULL pointer dereference at virtual address
00000246
c01aaea0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01aaea0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000246   ebx: 00000246   ecx: 00000004   edx: c5c8e164
esi: 00000000   edi: 00000000   ebp: c67e9f4c   esp: c67e9ef8
ds: 0018   es: 0018   ss: 0018
Process ftl_check (pid: 1373, stackpage=c67e9000)
Stack: c01ae9c6 00000246 c75d213c c11e01a0 00000000 00000001 c88b56ea
00000004 
       00000246 c5c8e164 c0125189 c11e01a0 c5c8e0a0 00000000 c5886340
00000000 
       c013818c c5c8e154 00000000 c75d2000 c75d2000 c5886340 c0138d49
c5c8e0a0 
Call Trace: [<c01ae9c6>] [<c88b56ea>] [<c0125189>] [<c013818c>]
[<c0138d49>] 
   [<c0138da2>] [<c01340a4>] [<c0133145>] [<c0133193>] [<c0108563>] 
Code: 66 81 38 c9 e3 74 09 b8 21 00 00 00 c3 8d 76 00 31 c0 c3 90 


>>EIP; c01aaea0 <pcmcia_close_memory+8/1c>   <=====

>>edx; c5c8e164 <_end+59e38d0/85af76c>
>>ebp; c67e9f4c <_end+653f6b8/85af76c>
>>esp; c67e9ef8 <_end+653f664/85af76c>

Trace; c01ae9c6 <CardServices+5e/358>
Trace; c88b56ea <[ftl_cs]ftl_close+fe/1a4>
Trace; c0125189 <truncate_inode_pages+5d/68>
Trace; c013818c <kill_bdev+20/28>
Trace; c0138d49 <blkdev_put+6d/b4>
Trace; c0138da2 <blkdev_close+12/18>
Trace; c01340a4 <fput+4c/d0>
Trace; c0133145 <filp_close+55/60>
Trace; c0133193 <sys_close+43/54>
Trace; c0108563 <system_call+33/38>

Code;  c01aaea0 <pcmcia_close_memory+8/1c>
00000000 <_EIP>:
Code;  c01aaea0 <pcmcia_close_memory+8/1c>   <=====
   0:   66 81 38 c9 e3            cmpw   $0xe3c9,(%eax)   <=====
Code;  c01aaea5 <pcmcia_close_memory+d/1c>
   5:   74 09                     je     10 <_EIP+0x10> c01aaeb0
<pcmcia_close_memory+18/1c>
Code;  c01aaea7 <pcmcia_close_memory+f/1c>
   7:   b8 21 00 00 00            mov    $0x21,%eax
Code;  c01aaeac <pcmcia_close_memory+14/1c>
   c:   c3                        ret    
Code;  c01aaead <pcmcia_close_memory+15/1c>
   d:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c01aaeb0 <pcmcia_close_memory+18/1c>
  10:   31 c0                     xor    %eax,%eax
Code;  c01aaeb2 <pcmcia_close_memory+1a/1c>
  12:   c3                        ret    
Code;  c01aaeb3 <pcmcia_close_memory+1b/1c>
  13:   90                        nop


Hope this helps.

Best regards,

Roel

