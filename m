Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272619AbRIMAGg>; Wed, 12 Sep 2001 20:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272620AbRIMAG1>; Wed, 12 Sep 2001 20:06:27 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:50193 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S272619AbRIMAGV>;
	Wed, 12 Sep 2001 20:06:21 -0400
Date: Wed, 12 Sep 2001 21:07:17 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: Duron kernel crash (i686 works)
In-Reply-To: <17484170901.20010912100011@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.GSO.4.21.0109122059330.10567-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2001, VDA wrote:

> RJD> I then get 'Athlon bug!' Still oopses.
> 
> Waah! That means movntq's moved data to some other place in memory!
> memcmp detected that and memcpy fixed, but that 'other place' was
> corrupted and that's the cause of oops.
> You may change printk to see when this happens:
>     printk(KERN_ERR "Athlon bug! from=%08X to=%08X\n", from, to);
> If you do, please post from/to pairs printed to lkml.

Actually, since it usually just oopses once, here is what I get (relevant
part of the kernel log, I understand it should be ksymoopsed, but the
idea is to show the order of things):

input2: USB HID v1.00 Mouse [QTRONIX USB Keyboard and Mouse] on usb1:4.1
Unable to handle kernel paging request at virtual address 03f5e02d
 printing eip:
c011d9e8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011d9e8>]
EFLAGS: 00010202
eax: c3fdea54   ebx: c115e564   ecx: 00000027   edx: 03f5e025
esi: c3f88e00   edi: 00000027   ebp: 00000000   esp: c3d4de88
ds: 0018   es: 0018   ss: 0018
Process hostname (pid: 12, stackpage=c3d4d000)
Stack: c01b5a30 c011e7db c115e564 00000027 c3fdea54 c01b5a30 c3f88e00
c3f8a380
       00000000 0000012d c3fdea54 c115e564 c115e4c0 c3f98d40 c011b832
c3f88e00
       4004c000 00000000 4004ca64 c3f8a380 ffffffff 00000000 c011b91b
c3f8a380
Call Trace: [<c011e7db>] [<c011b832>] [<c011b91b>] [<c010d770>]
[<c010d8d3>]
   [<c010d770>] [<c011c592>] [<c011c942>] [<c011c985>] [<c0106d28>]

Code: 39 5a 08 75 f4 39 4a 0c 75 ef b8 02 00 00 00 0f ab 42 18 85

Athlon bug! from=C3CE9000 to=C3D5C000
Oops: 0000
CPU:    0
EIP:    0010:[<c0129386>]
EFLAGS: 00010202
eax: c3fa3000   ebx: 00000002   ecx: 00000000   edx: 00000002
esi: 00000001   edi: c118c580   ebp: 00000001   esp: c3cd5f7c
ds: 0018   es: 0018   ss: 0018
Process rc.sysinit (pid: 21, stackpage=c3cd5000)
Stack: 0010003f 00000001 c0112b08 00000002 c118c580 c3f8a380 c3cd4000
00000000
       bfffeeac c118c6a0 c01130d6 c118c580 c3cd4000 40183398 00000000
c011324e
       00000000 c0106c37 00000000 40182280 40184814 40183398 00000000
bfffeeac
Call Trace: [<c0112b08>] [<c01130d6>] [<c011324e>] [<c0106c37>]

Code: 8b 43 14 85 c0 75 13 68 a2 61 19 c0 e8 d9 74 fe ff 31 c0 83

and then no more activity. But it's not deterministic. If I pass /bin/sh
to init I can play a little and get other errors, and not every one of
them print the Athlon bug error (actually, almost none). Altough I believe
the error is only there
(fast_copy_page), because changing the movntqs solves all problems, I
guess sometimes memcpy really does return 0.

Thanks for the help you guys are giving us,

[]s

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

