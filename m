Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316072AbSETOzz>; Mon, 20 May 2002 10:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316075AbSETOzy>; Mon, 20 May 2002 10:55:54 -0400
Received: from 217-79-104-247.adsl.griffin.net.uk ([217.79.104.247]:22823 "EHLO
	lemur.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S316067AbSETOzx>; Mon, 20 May 2002 10:55:53 -0400
Subject: Re: OOPS: ext3/sparc badness
From: Beezly <beezly@beezly.org.uk>
To: Beezly <beezly@beezly.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1021897921.8474.8.camel@montgomery>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 20 May 2002 15:55:52 +0100
Message-Id: <1021906553.20913.17.camel@montgomery>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Talking to myself :), but...

On Mon, 2002-05-20 at 13:32, Beezly wrote:
> o0: fffff80001564000 o1: 0000000000000000 o2: 0000000000ff0000 o3: 000000000000ff00

> Code;  004a2b30 <ext3_lookup+30/c0>
> 00000000 <_PC>:
> Code;  004a2b30 <ext3_lookup+30/c0>
>    0:   94 10 20 00       clr  %o2
> Code;  004a2b34 <ext3_lookup+34/c0>
>    4:   15 00 3f c0       sethi  %hi(0xff0000), %o2
> Code;  004a2b38 <ext3_lookup+38/c0>
>    8:   d2 5f a7 e7       unknown

This is:

	ldx [%fp+0x7e7],%o1

> Code;  004a2b3c <ext3_lookup+3c/c0>   <=====
>    c:   d6 02 40 00       ld  [ %o1 ], %o3   <=====

gdb says;

Dump of assembler code for function ext3_lookup:
0x4a2b00 <ext3_lookup>:	save  %sp, -208, %sp
0x4a2b04 <ext3_lookup+4>:	mov  %i0, %l1
0x4a2b08 <ext3_lookup+8>:	add  %fp, 0x7e7, %o1
0x4a2b0c <ext3_lookup+12>:	ld  [ %i1 + 0x78 ], %o2
0x4a2b10 <ext3_lookup+16>:	mov  %i1, %o0
0x4a2b14 <ext3_lookup+20>:	cmp  %o2, 0xff
0x4a2b18 <ext3_lookup+24>:	bgu  %icc, 0x4a2bac <ext3_lookup+172>
0x4a2b1c <ext3_lookup+28>:	mov  -63, %i0
0x4a2b20 <ext3_lookup+32>:	call  0x4a27c0 <ext3_find_entry>
0x4a2b24 <ext3_lookup+36>:	mov  -13, %i0
0x4a2b28 <ext3_lookup+40>:	mov  %o0, %o1
0x4a2b2c <ext3_lookup+44>:	brz,pn   %o1, 0x4a2b94 <ext3_lookup+148>
0x4a2b30 <ext3_lookup+48>:	clr  %o2
0x4a2b34 <ext3_lookup+52>:	sethi  %hi(0xff0000), %o2
0x4a2b38 <ext3_lookup+56>:	ldx  [ %fp + 0x7e7 ], %o1
0x4a2b3c <ext3_lookup+60>:	ld  [ %o1 ], %o3
0x4a2b40 <ext3_lookup+64>:	sethi  %hi(0xfc00), %o1
0x4a2b44 <ext3_lookup+68>:	sll  %o3, 0x18, %l0

we are trying to load **res_dir for ext3_find_entry. Unfortunately, it appears that either *res_dir, or **res_dir is 0 (as %o1 ends up being 0's):( 

Beezly

