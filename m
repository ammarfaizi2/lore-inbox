Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbSJDVxF>; Fri, 4 Oct 2002 17:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSJDVxF>; Fri, 4 Oct 2002 17:53:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60681 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262653AbSJDVxE>; Fri, 4 Oct 2002 17:53:04 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: oops in bk pull (oct 03)
Date: Fri, 4 Oct 2002 21:58:10 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <anl2ti$9lc$1@penguin.transmeta.com>
References: <3D9DF6A2.9030101@erkkila.org>
X-Trace: palladium.transmeta.com 1033768709 8665 127.0.0.1 (4 Oct 2002 21:58:29 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 4 Oct 2002 21:58:29 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3D9DF6A2.9030101@erkkila.org>,
Paul E. Erkkila <pee@erkkila.org> wrote:
>
>Oops in drivers/pci/probe.c
>
>Oops (copied), ksymoops, and lspci -vv attached
>
>No modules in ksyms, skipping objects
>Unable to handle kernel paging request at virtual address f8000008
>c01c9d10
>*pde = 00000000
>Oops: 0002
>CPU:    0
>EIP:    0060:[<c01c9d10>]    Not tainted
>Using defaults from ksymoops -t elf32-i386 -a i386
>EFLAGS: 00010202
>eax: f8000008   ebx: 00000010     ecx: 00000000       edx: f8000008
>esi: c1523c00   edi: c1523d38     ebp: 00000001       esp: dffcdb60
>ds: 0068    es: 0068    ss: 0068
>Stack:  c01c9e91 f8000008 fffffff0 00000010 dffcdb78 c1523ef8 f8000008 00000008
>        d0000008 c1523c00 c1523f48 00000000 00000000 c01ca2a6 c1523c00 00000006
>        00000030 dffcdbac 00000000 00000600 c1523c00 dffcdc20 c03a1351 c1523c00
> [<c01c9e91>] pci_read_bases+0x161/0x340
> [<c01ca2a6>] pci_setup_device+0x1b6/0x3d0
> [<c0105109>] init+0x79/0x200
> [<c0105090>] init+0x0/0x200
> [<c01073e5>] kernel_thread_helper+0x5/0x10
>Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 48 c3 8d b4

Something has corrupted your kernel image. Those 16 0x00 bytes are
definitely not the right code, looks like an errant memset() through a
wild pointer cleared it or something.

Is this repeatable? Does it happen with current BK?

		Linus
