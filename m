Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbQLSNAT>; Tue, 19 Dec 2000 08:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbQLSNAK>; Tue, 19 Dec 2000 08:00:10 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:57511 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S129652AbQLSM7w>; Tue, 19 Dec 2000 07:59:52 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Oops with 2.4.0-test13pre3 - swapoff
Message-ID: <3A3F548A.6E6F2B1B@fi.muni.cz>
Date: Tue, 19 Dec 2000 12:28:58 GMT
X-Nntp-Posting-Host: decibel.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17pre9-AGP-IDE i586)
Organization: unknown
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This is oops I've got when rebooting after some heavy disk activity on
my SMP system:

Written by hand:

kernel BUG swap_state.c:78!
-- invalid operand: 0000
EIP: 0010:[<c01e20fd>]
Using defaults from ksymoops -t elf32-i386 -a i386
Stack: c0206c16 c0206e2f 0000004e
Call Trace: [<c0206c16>] [<c0206e2f>] [<c012e1a5>] [<c012e1ce>]
[<c0130d0d>] 
[<c0130ddc>] [<c012eb5d>] [<c012ed24>] [<c01328d4>] [<c0108ef3>]
Code: 0f 0b 83 c4 0c 8b 43 18 f6 c4 02 74 07 8b 43 18 a8 01 75 16

>>EIP; c01e20fd <unix_stream_sendmsg+225/308>   <=====
Trace; c0206c16 <tvecs+2f1e/c8bc>
Trace; c0206e2f <tvecs+3137/c8bc>
Trace; c012e1a5 <delete_from_swap_cache_nolock+5d/74>
Trace; c012e1ce <delete_from_swap_cache+12/5c>
Trace; c0130d0d <shmem_unuse_inode+89/120>
Trace; c0130ddc <shmem_unuse+38/4c>
Trace; c012eb5d <try_to_unuse+f5/170>
Trace; c012ed24 <sys_swapoff+14c/2b0>
Trace; c01328d4 <sys_read+bc/c4>
Trace; c0108ef3 <system_call+33/38>
Code;  c01e20fd <unix_stream_sendmsg+225/308>

00000000 <_EIP>:
Code;  c01e20fd <unix_stream_sendmsg+225/308>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01e20ff <unix_stream_sendmsg+227/308>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c01e2102 <unix_stream_sendmsg+22a/308>
   5:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c01e2105 <unix_stream_sendmsg+22d/308>
   8:   f6 c4 02                  test   $0x2,%ah
Code;  c01e2108 <unix_stream_sendmsg+230/308>
   b:   74 07                     je     14 <_EIP+0x14> c01e2111
<unix_stream_sendmsg+239/308>
Code;  c01e210a <unix_stream_sendmsg+232/308>
   d:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c01e210d <unix_stream_sendmsg+235/308>
  10:   a8 01                     test   $0x1,%al
Code;  c01e210f <unix_stream_sendmsg+237/308>
  12:   75 16                     jne    2a <_EIP+0x2a> c01e2127
<unix_stream_sendmsg+24f/308>


             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
