Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317007AbSGVNRR>; Mon, 22 Jul 2002 09:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSGVNRR>; Mon, 22 Jul 2002 09:17:17 -0400
Received: from adsl-xs4all.ds9a.nl ([213.84.159.51]:48054 "HELO spaans.ds9a.nl")
	by vger.kernel.org with SMTP id <S317007AbSGVNRQ>;
	Mon, 22 Jul 2002 09:17:16 -0400
Date: Mon, 22 Jul 2002 15:20:16 +0200
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: linux-kernel@vger.kernel.org, linux-read@vger.kernel.org
Subject: [oops] 2.5.27 while booting during raid init with incomplete array
Message-ID: <20020722132016.GA2449@spaans.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4i
Keywords: Vickie Weaver militia Peking counter-intelligence munitions Roswell
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2002 C. Jasper Spaans - All Rights Reserved
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lists!

I just tried booting 2.5.27, and it oops-ed on me right after raid
initialisation. No serial console, so I took a picture[0] {and tried to ocr
it first, gave up} and retyped the oops and ran it through ksymoops, result:

ksymoops 2.4.5 on i686 2.4.19-rc3.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.5.27 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000001
c02755a2
*pde = 00000000
Oops: 0002
Cpu:    0
EIP:    0010:[<c02755a2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010212
eax: 00000000   ebx: dfd37400   ecx: 00000400   edx: 00000000
ds: 0018   es: 0018   ss: 0018
Stack: dfd577a0 dfd3740c dfd37400 dfd37400 c036c2c0 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 dfd2740c 00000001 c0275850 dfd37400
       dfd577a0 dfd3740c dfd3740c dfd37400 00000064 dfd37400 c02764f4 dfd37400
Call Trace: [<c0275850>] [<c02764d4>] [<c01111cc>] [<c01146e7>] [<c01145d1>]
   [<c02767cc>] [<c0276a3c>] [<c02792c3>] [<c010506e>] [<c010560c>]
Code: f3 ab 8b 44 24 34 c7 00 fc 4e 2b a9 8b 43 1c 8b 54 24 34 89


>>EIP; c02755a2 <sync_sbs+76/2c8>   <=====

>>ebx; dfd37400 <END_OF_CODE+1f8ebf88/????>

Trace; c0275850 <md_update_sb+5c/190>
Trace; c02764d4 <do_md_run+284/2d4>
Trace; c01111cc <__wake_up+20/40>
Trace; c01146e7 <release_console_sem+b7/c0>
Trace; c01145d1 <printk+129/154>
Trace; c02767cc <autorun_array+98/c0>
Trace; c0276a3c <autorun_devices+248/2b0>
Trace; c02792c3 <autostart_arrays+c7/ca>
Trace; c010506e <init+1e/170>
Trace; c010560c <kernel_thread+28/38>

Code;  c02755a2 <sync_sbs+76/2c8>
00000000 <_EIP>:
Code;  c02755a2 <sync_sbs+76/2c8>   <=====
   0:   f3 ab                     repz stos %eax,%es:(%edi)   <=====
Code;  c02755a4 <sync_sbs+78/2c8>
   2:   8b 44 24 34               mov    0x34(%esp,1),%eax
Code;  c02755a8 <sync_sbs+7c/2c8>
   6:   c7 00 fc 4e 2b a9         movl   $0xa92b4efc,(%eax)
Code;  c02755ae <sync_sbs+82/2c8>
   c:   8b 43 1c                  mov    0x1c(%ebx),%eax
Code;  c02755b1 <sync_sbs+85/2c8>
   f:   8b 54 24 34               mov    0x34(%esp,1),%edx
Code;  c02755b5 <sync_sbs+89/2c8>
  13:   89 00                     mov    %eax,(%eax)


There could be some errors in here, please let me know if you see anything
unusual, and I'll see if there's a difference between the oops I typed and
the one which was on my screen.

I'm not sure whether raid is still considered broken in 2.5.27, so I'm still
posting this. One important note though: this is an incomplete array - could
that be the cause of this oops? (see screenshot, the 'active with 1 out of 3
devices' seems to be wrong, however, the config printout below it is OK)

Regards,
-- 
Jasper Spaans
http://jsp.ds9a.nl/contact/
Tel/Fax: +31-84-8749842
``Got no clue? Too bad for you.''

[0] http://spaans.ds9a.nl/~spaans/imgp1312.jpg - only available from 0530-2100 UTC

