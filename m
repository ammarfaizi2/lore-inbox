Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266645AbUAWSj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266646AbUAWSj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:39:56 -0500
Received: from intra.cyclades.com ([64.186.161.6]:44751 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266645AbUAWSjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:39:47 -0500
Date: Fri, 23 Jan 2004 16:15:12 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Alan Turner <alan@suburbia.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 oops in d_lookup
In-Reply-To: <200401220819.i0M8J3jK017873@freddy.localdomain>
Message-ID: <Pine.LNX.4.58L.0401231614160.19820@logos.cnet>
References: <200401220819.i0M8J3jK017873@freddy.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jan 2004, Alan Turner wrote:

> Hi folks,
>
> I'm in the process of moving a 200 MHz pentium-MMX from NetBSD to linux.
> It has run NetBSD without trouble for a few months now (including
> rebuilding the whole NetBSD system).
>
> I partially untarred a backup of the old filesystem (about 7 gig), but
> tar reported errors which seemed to be due to tar not being able to run
> mknod(2). Fair enough.
>
> I began an rm process deleting the mostly-restored copy, and put it into
> the background. Before the rm operation completed, I started another tar
> process (one which avoided unpacking the dev files).
>
> After a while the kernel oopsed, and the second tar process segfaulted.
> The decoded oops and dmesg are appended below.
>
> The filesystem in use is ext3. I fscked it after a reboot, and all
> seemed well.
>
> This is a debian 3.0 system.
>
> Thanks very much for looking into this - if any more info is required, I
> will provide it.

Hi Alan,

This could be bad memory/hardware.

Have you checked you memory with memtest86?

> CPU:    0
> EIP:    0010:[<c013e610>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010206
> eax: c10924d8   ebx: ffffffef   ecx: 0000000d   edx: 692377d4
> esi: c12cc520   edi: c0ec91a0   ebp: ffffffff   esp: c2295f38
> ds: 0018   es: 0018   ss: 0018
> Process rm (pid: 460, stackpage=c2295000)
> Stack: 00000000 c12cc520 c0ec91a0 c2295fac c10924d8 c19e4000 692377d4 0000000c
>        c0135f14 c12cc520 c2295fac 00000000 c0136c48 c12cc520 c2295fac 00000000
>        ffffffeb c2295fa4 c19e4000 c2295fa4 c0137d92 c2295fac c12cc520 c2294000
> Call Trace:    [<c0135f14>] [<c0136c48>] [<c0137d92>] [<c0106c33>]
> Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 24 24 39 43 0c 75
>
>
> >>EIP; c013e610 <d_lookup+60/100>   <=====
>
> >>eax; c10924d8 <_end+e20ac4/358e5ec>
> >>ebx; ffffffef <END_OF_CODE+3c79ea70/????>
> >>edx; 692377d4 Before first symbol
> >>esi; c12cc520 <_end+105ab0c/358e5ec>
> >>edi; c0ec91a0 <_end+c5778c/358e5ec>
> >>ebp; ffffffff <END_OF_CODE+3c79ea80/????>
> >>esp; c2295f38 <_end+2024524/358e5ec>
>
> Trace; c0135f14 <cached_lookup+10/54>
> Trace; c0136c48 <lookup_hash+44/8c>
> Trace; c0137d92 <sys_unlink+6e/114>
> Trace; c0106c33 <system_call+33/40>
>
> Code;  c013e610 <d_lookup+60/100>
> 00000000 <_EIP>:
> Code;  c013e610 <d_lookup+60/100>   <=====
>    0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
> Code;  c013e613 <d_lookup+63/100>
>    3:   8b 54 24 18               mov    0x18(%esp,1),%edx
> Code;  c013e617 <d_lookup+67/100>
>    7:   39 53 44                  cmp    %edx,0x44(%ebx)
> Code;  c013e61a <d_lookup+6a/100>
>    a:   75 7c                     jne    88 <_EIP+0x88> c013e698 <d_lookup+e8/100>
> Code;  c013e61c <d_lookup+6c/100>
>    c:   8b 44 24 24               mov    0x24(%esp,1),%eax
> Code;  c013e620 <d_lookup+70/100>
>   10:   39 43 0c                  cmp    %eax,0xc(%ebx)
> Code;  c013e623 <d_lookup+73/100>
>   13:   75 00                     jne    15 <_EIP+0x15> c013e625 <d_lookup+75/100>
>
>
> 1 warning issued.  Results may not be reliable.
>
