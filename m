Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318900AbSIJAzY>; Mon, 9 Sep 2002 20:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318976AbSIJAzX>; Mon, 9 Sep 2002 20:55:23 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:29111 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318900AbSIJAzX>; Mon, 9 Sep 2002 20:55:23 -0400
Date: Mon, 9 Sep 2002 17:02:36 -0400
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: ltp directio test causes oops on 2.4.20pre5aa2
Message-ID: <20020909210236.GA3023@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linux test project diotest1 running on reiserfs gave oops:

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel NULL pointer dereference at virtual address 00000012
8015d6d3
*pde = 00000000
Oops: 0000 2.4.20-pre5aa2 #1 Mon Sep 9 17:31:33 EDT 2002
CPU:    0
EIP:    0010:[<8015d6d3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010256
eax: 00000002   ebx: 8d019e50   ecx: 00000000   edx: 851c8840
esi: 00000000   edi: 00000000   ebp: 8d019e08   esp: 8d019d00
ds: 0018   es: 0018   ss: 0018
Process diotest1 (pid: 2965, stackpage=8d019000)
Stack: 8d019e50 00000000 00000000 8358a240 001c8454 8016bc2c 00000000 001c8454
       b3740740 8015ea94 8d019d68 8d019f04 bff9d800 b3740740 8d019d68 8358a240
       8358a240 00000000 00000000 8d019d6c 0000003f 0000b474 00000000 00000000
Call Trace:    [<8016bc2c>] [<8015ea94>] [<8015b513>] [<8015d55a>] [<801388f9>]
  [<80121000>] [<8012463d>] [<80124796>] [<801604a5>] [<8015d540>] [<80128965>]
  [<8012a7b0>] [<80126022>] [<8012a8b1>] [<80135796>] [<8010880b>]
Code: 8a 48 10 0f a5 f7 d3 e6 f6 c1 20 74 04 89 f7 31 f6 83 c6 01


>>EIP; 8015d6d3 <reiserfs_get_block+43/e50>   <=====

Trace; 8016bc2c <pathrelse+1c/30>
Trace; 8015ea94 <reiserfs_update_sd+164/180>
Trace; 8015b513 <reiserfs_add_entry+403/430>
Trace; 8015d55a <reiserfs_get_block_direct_io+1a/40>
Trace; 801388f9 <generic_direct_IO+c9/140>
Trace; 80121000 <sys_setreuid+1a0/1b0>
Trace; 8012463d <get_user_pages+fd/190>
Trace; 80124796 <map_user_kiobuf+c6/110>
Trace; 801604a5 <reiserfs_direct_io+25/30>
Trace; 8015d540 <reiserfs_get_block_direct_io+0/40>
Trace; 80128965 <generic_file_direct_IO+1a5/220>
Trace; 8012a7b0 <do_generic_file_write+630/6c0>
Trace; 80126022 <__vma_link+62/b0>
Trace; 8012a8b1 <generic_file_write+71/b0>
Trace; 80135796 <sys_write+96/f0>
Trace; 8010880b <system_call+33/38>

The subsequent diotest[2-6] also printed oops.

diotest1 is unkillable:
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root      2977  0.0  0.0  1336  408 tty1     D    16:39   0:00 diotest1 -b 65536

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

