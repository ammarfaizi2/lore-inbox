Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291171AbSBNJ5p>; Thu, 14 Feb 2002 04:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291246AbSBNJ5f>; Thu, 14 Feb 2002 04:57:35 -0500
Received: from Expansa.sns.it ([192.167.206.189]:28677 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S291171AbSBNJ5R>;
	Thu, 14 Feb 2002 04:57:17 -0500
Date: Thu, 14 Feb 2002 10:57:13 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Oleg Drokin <green@namesys.com>
cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs oops with 2.5.5-pre1 (was: [reiserfs-dev]
 2.5.4-pre1:)zero-filled files reiserfs
In-Reply-To: <20020214085059.B5605@namesys.com>
Message-ID: <Pine.LNX.4.44.0202141054350.27542-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, with 2.5.5-pre1 i get this oops:

PAP-14030: direct2indirect: pasted or inserted byte exists in the
treeinvalid operand: 0000

CPU:    0
EIP:    0010:[<c0168dd9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000049   ebx: c01f7a00   ecx: ffffffb7   edx: cfa01180
esi: c154a800   edi: ceeede80   ebp: ceeedda4   esp: ceeedd2c
ds: 0018   es: 0018   ss: 0018
Stack: c01f60da c02640c0 c01f7a00 ceeedd50 ceeedd8c cbe5c198 c0171df4 c154a800
       c01f7a00 ceeede3c 00000000 cbe76b00 c154a800 00000000 00001000 00000000
       cbe5c198 ceeedec0 00000713 00000714 00000001 fffffffe 0040ffff 00000cf4
Call Trace: [<c0171df4>] [<c016055f>] [<c016dba3>] [<c016e4bf>] [<c017283d>]
   [<c0135cb1>] [<c013638e>] [<c015fb00>] [<c01624e8>] [<c015fb00>] [<c012953d>]
   [<c013377b>] [<c010886f>]
Code: 0f 0b 68 c0 40 26 c0 b8 e0 60 1f c0 8d 96 cc 00 00 00 85 f6

>>EIP; c0168dd8 <reiserfs_panic+28/4c>   <=====
Trace; c0171df4 <direct2indirect+d4/2d8>
Trace; c016055e <reiserfs_get_block+a5e/df4>
Trace; c016dba2 <is_tree_node+36/4c>
Trace; c016e4be <search_by_key+906/df0>
Trace; c017283c <get_cnode+10/78>
Trace; c0135cb0 <__block_prepare_write+8c/1f8>
Trace; c013638e <block_prepare_write+22/3c>
Trace; c015fb00 <reiserfs_get_block+0/df4>
Trace; c01624e8 <reiserfs_prepare_write+5c/64>
Trace; c015fb00 <reiserfs_get_block+0/df4>
Trace; c012953c <generic_file_write+45c/660>
Trace; c013377a <sys_write+8e/c4>
Trace; c010886e <syscall_call+6/a>
Code;  c0168dd8 <reiserfs_panic+28/4c>
00000000 <_EIP>:
Code;  c0168dd8 <reiserfs_panic+28/4c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0168dda <reiserfs_panic+2a/4c>
   2:   68 c0 40 26 c0            push   $0xc02640c0
Code;  c0168dde <reiserfs_panic+2e/4c>
   7:   b8 e0 60 1f c0            mov    $0xc01f60e0,%eax
Code;  c0168de4 <reiserfs_panic+34/4c>
   c:   8d 96 cc 00 00 00         lea    0xcc(%esi),%edx
Code;  c0168dea <reiserfs_panic+3a/4c>
  12:   85 f6                     test   %esi,%esi




On Thu, 14 Feb 2002, Oleg Drokin wrote:

> Hello!
>
> On Wed, Feb 13, 2002 at 06:15:24PM +0100, Luigi Genoni wrote:
> > It happened when I did  reboot from 2.5.4-pre1 to 2.5.4, and my
> > /etc/rc.c/rc.local was full of 0s.
> > And when I did reboot from 2.5.3 to 2.5.3 on the other box and some c
> > source I was editing three ours before were full of 0s.
> There was a bug in kernels up to 2.5.4-pre1 (2.5.4-pre2 had a fix),
> which had similar symtoms.
>
> > > > I saw I am not the only one with this kind of corruption, I remember at
> > > > less one related mail.
> > > There was flaky hardware on the other report. And I think Alex Riesen
> > > cannot reproduce zero files anymore.
> > Those two boxes runned from more than 1 year and no HW problems before..
> Great.
> Thing is if you able to reproduce on 2.5.4-pre2+ without rebooting into earlier
> 2.5 kernels in-between tries, then it will mean something is not right even
> in latest kernels.
>
> Bye,
>     Oleg
>

