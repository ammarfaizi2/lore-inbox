Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318635AbSHUSpL>; Wed, 21 Aug 2002 14:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318643AbSHUSpL>; Wed, 21 Aug 2002 14:45:11 -0400
Received: from tufnell.london1.poggs.net ([193.109.194.18]:4074 "EHLO
	tufnell.london1.poggs.net") by vger.kernel.org with ESMTP
	id <S318635AbSHUSpK>; Wed, 21 Aug 2002 14:45:10 -0400
Message-ID: <3D63E0E8.1080202@POGGS.CO.UK>
Date: Wed, 21 Aug 2002 19:50:16 +0100
From: Peter Hicks <Peter.Hicks@POGGS.CO.UK>
Organization: Poggs Computer Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-gb, en-us, en-au, en-ie, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel BUG in buffer.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone

I've come across a BUG() in buffer.c, line 2497. I'm running 2.4.19 on a 
Pentium III, with no other problems. I'd finished making a backup of an 
IRIX installation CD, was mounting the freshly burnt CD, and was greeted 
with a hung 'mount' and the following in dmesg:

EFS: 1.0a - http://aeschi.ch.eu.org/efs/
kernel BUG at buffer.c:2497!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0135e12>]    Not tainted
EFLAGS: 00010206
eax: 000007ff   ebx: 0000000b   ecx: 00000800   edx: d3cb58c0
esi: 00000000   edi: 00000b00   ebp: 00000000   esp: d7c9fe44
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 1244, stackpage=d7c9f000)
Stack: 00000b00 00000200 00000000 00000000 00004000 c01340a7 00000b00 
00000000
       00000200 c02349b4 c1bf2e00 c1bf2ecc c0134294 00000b00 00000000 
00000200
       00000000 e089b219 00000b00 00000000 00000200 c02349b4 c1bf2e00 
c15c71e0
Call Trace:    [<c01340a7>] [<c0134294>] [<e089b219>] [<c0136fe0>] 
[<e089c900>]
  [<e089c900>] [<c01457b6>] [<c013719b>] [<e089c900>] [<c0146699>] 
[<c0146962>]
  [<c01467b4>] [<c0146ce4>] [<c010856f>]

Code: 0f 0b c1 09 20 21 20 c0 8b 44 24 20 05 00 fe ff ff 3d 00 0e

Line 2497 of buffer.c is in grow_buffers, and the code is as follows:

   2495:       /* Size must be multiple of hard sectorsize */
   2496:        if (size & (get_hardsect_size(dev)-1))
   2497:                BUG();

This is the first time its happened. Can anybody confirm that this is, 
as I suspect, a problem with the CD-ROM and not with the kernel? Do I 
need to provide any more information to help somebody with troubleshooting?

Best wishes,


Peter (not currently subscribed to the list, please cc: in to replies!)

