Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265839AbRGXAb0>; Mon, 23 Jul 2001 20:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbRGXAbQ>; Mon, 23 Jul 2001 20:31:16 -0400
Received: from pop3.telenet-ops.be ([195.130.132.40]:43245 "EHLO
	pop3.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S265839AbRGXAbB>; Mon, 23 Jul 2001 20:31:01 -0400
Subject: Oops in kernel 2.4.6-ac2 using ftl device
From: Roel Teuwen <Roel.Teuwen@advalvas.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.11 (Beta Release)
Date: 24 Jul 2001 02:29:03 +0200
Message-Id: <995934543.7981.13.camel@omniroel>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

When mounting a pcmcia flash card I encountered the following (decoded)
oops :

ksymoops 2.3.4 on i586 2.4.6-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6-ac2/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address
00000006
c018ccd8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c018ccd8>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000006   ebx: 00000006   ecx: 00000004   edx: c28a8c20
esi: c28a8c20   edi: 00000000   ebp: c2939eb4   esp: c2939e7c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 724, stackpage=c2939000)
Stack: c0190c06 00000006 00000000 c28a8c20 0000fe00 c360f93c c483163b
00000004
       00000006 c28a8c20 c11af260 0000fe00 c360f800 c360f800 fffffff4
c0134aa7
       c28a8c20 00000000 00000000 0000fe00 ffffffea c11af260 c01329bf
c11af260
Call Trace: [<c0190c06>] [<c0134aa7>] [<c01329bf>] [<c0133211>]
[<c010f4c0>]
   [<c0106dd8>] [<c01334c6>] [<c013337b>] [<c013355c>] [<c0106cb3>]
Code: 66 81 38 c9 e3 74 06 b8 21 00 00 00 c3 31 c0 c3 90 8d b4 26

>>EIP; c018ccd8 <pcmcia_get_first_region+78/b0>   <=====
Trace; c0190c06 <pcmcia_suspend_card+66/70>
Trace; c0134aa7 <blkdev_put+77/b0>
Trace; c01329bf <get_sb_bdev+17f/1b0>
Trace; c0133211 <do_add_mount+101/220>
Trace; c010f4c0 <do_page_fault+0/4b0>
Trace; c0106dd8 <error_code+38/40>
Trace; c01334c6 <do_mount+f6/110>
Trace; c013337b <copy_mount_options+4b/a0>
Trace; c013355c <sys_mount+7c/c0>
Trace; c0106cb3 <system_call+33/40>
Code;  c018ccd8 <pcmcia_get_first_region+78/b0>
00000000 <_EIP>:
Code;  c018ccd8 <pcmcia_get_first_region+78/b0>   <=====
   0:   66 81 38 c9 e3            cmpw   $0xe3c9,(%eax)   <=====
Code;  c018ccdd <pcmcia_get_first_region+7d/b0>
   5:   74 06                     je     d <_EIP+0xd> c018cce5
<pcmcia_get_first_region+85/b0>
Code;  c018ccdf <pcmcia_get_first_region+7f/b0>
   7:   b8 21 00 00 00            mov    $0x21,%eax
Code;  c018cce4 <pcmcia_get_first_region+84/b0>
   c:   c3                        ret    
Code;  c018cce5 <pcmcia_get_first_region+85/b0>
   d:   31 c0                     xor    %eax,%eax
Code;  c018cce7 <pcmcia_get_first_region+87/b0>
   f:   c3                        ret    
Code;  c018cce8 <pcmcia_get_first_region+88/b0>
  10:   90                        nop    
Code;  c018cce9 <pcmcia_get_first_region+89/b0>
  11:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi

I haven't had any time yet to try newer kernels.

Kind regards,

Roel Teuwen

