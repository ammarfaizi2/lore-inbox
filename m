Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291504AbSBADGH>; Thu, 31 Jan 2002 22:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291505AbSBADF6>; Thu, 31 Jan 2002 22:05:58 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:57037 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S291504AbSBADFz>; Thu, 31 Jan 2002 22:05:55 -0500
Date: Thu, 31 Jan 2002 22:09:51 -0500
To: Dave Jones <davej@suse.de>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: Oops immediately following dbench 192 on 2.5.3
Message-ID: <20020201030951.GA5946@earthlink.net>
In-Reply-To: <20020201024337.GA5932@earthlink.net> <Pine.LNX.4.33.0202010343320.14594-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202010343320.14594-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > System has reiserfs root filesystem and other filesystems, except
> > for the ext2 filesystem that was running dbench 192.  IDE.
> 
> Does the patch Oleg posted earlier for 2.5.2-dj7 fix this problem ?
> I was wondering why that bug was showing up in -dj but not mainline,
> so I'm expecting it to solve your problem.

Hmm, I don't see my similar report on 2.5.2-dj7 in the archive.
Basically the exact same behaviour I got with 2.5.3.
Between 2.5.2-dj7 and 2.5.3 runs; 2.4.17 and 2.4.18pre7aa1 ran
the same tests without a problem.

Here is the report on 2.5.2-dj7:

I got the following oops on 2.5.2-dj7 during the "runtests"
benchmark.  The logfiles suggest it was after dbench 192
completed on ext2, but before the next test (LTP) got
started.  I.E. in the "echo;sync;sleep" part of the
"runtests" wrapper.  Filesystems are reiserfs other than
the one that runs dbench.

It did not reboot.  It does appear livelocked though.
2.5.2-dj[1-6] completed the tests with no problem.

ksymoops:

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
CPU:    0
EIP:    0010:[<c015f4b9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000057   ebx: c01f69e0   ecx: 00000001   edx: d7962000
esi: d7ea2800   edi: 00000000   ebp: d735fe40   esp: d735fc44
ds: 0018   es: 0018   ss: 0018
Process runtests (pid: 68, stackpage=d735f000)
Stack: c01f555a c02612c0 c01f69e0 d735fc68 d735fca0 00000000 c016644b d7ea2800
       c01f69e0 d735fe80 c237f4e0 00000003 00000006 00000008 00001000 00000000
       00000001 d735fca4 00000f58 00000001 00000f58 d7ea2800 63eb3120 00000000
Call Trace: [<c016644b>] [<c0166a29>] [<c015884c>] [<c01595cc>] [<c012c484>]
   [<c012b66b>] [<c0136d03>] [<c01085c3>]
Code: 0f 0b 68 c0 12 26 c0 b8 60 55 1f c0 85 f6 74 06 8d 86 cc 00

>>EIP; c015f4b8 <reiserfs_panic+28/4c>   <=====
Trace; c016644a <reiserfs_cut_from_item+1b2/450>
Trace; c0166a28 <reiserfs_do_truncate+2f8/424>
Trace; c015884c <reiserfs_truncate_file+c4/154>
Trace; c01595cc <reiserfs_file_release+31c/340>
Trace; c012c484 <fput+4c/d0>
Trace; c012b66a <filp_close+5e/68>
Trace; c0136d02 <sys_dup2+8a/b0>
Trace; c01085c2 <system_call+32/40>
Code;  c015f4b8 <reiserfs_panic+28/4c>
00000000 <_EIP>:
Code;  c015f4b8 <reiserfs_panic+28/4c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015f4ba <reiserfs_panic+2a/4c>
   2:   68 c0 12 26 c0            push   $0xc02612c0
Code;  c015f4be <reiserfs_panic+2e/4c>
   7:   b8 60 55 1f c0            mov    $0xc01f5560,%eax
Code;  c015f4c4 <reiserfs_panic+34/4c>
   c:   85 f6                     test   %esi,%esi
Code;  c015f4c6 <reiserfs_panic+36/4c>
   e:   74 06                     je     16 <_EIP+0x16> c015f4ce <reiserfs_panic+3e/4c>
Code;  c015f4c8 <reiserfs_panic+38/4c>
  10:   8d 86 cc 00 00 00         lea    0xcc(%esi),%eax

-- 
Randy Hron

