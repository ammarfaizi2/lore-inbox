Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUBFHVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 02:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266854AbUBFHVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 02:21:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:53783 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266824AbUBFHVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 02:21:48 -0500
Date: Fri, 6 Feb 2004 07:21:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: =?koi8-r?Q?=22?=Good Oleg=?koi8-r?Q?=22=20?= 
	<olecom.gnu-linux@mail.ru>
cc: Andrew Morton <akpm@osdl.org>, marcel cotta <marcel@kriminell.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: kernel BUG at mm/swapfile.c:806! (2.6)
In-Reply-To: <E1AouoU-000Fke-00.olecom-gnu-linux-mail-ru@f6.mail.ru>
Message-ID: <Pine.LNX.4.44.0402060701290.2888-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, [koi8-r] "Good Oleg[koi8-r] "  wrote:

> PC(see below) 256Mib of RAM, linux-2.6.2, 300Mib swap file (swapon /mnt/swap/swap)
> When programs cause big memory usage i have this
> (since my 2.4.22 to 2.6.0-test11 migration):
> 
> Feb  6 02:26:27 gluon kernel: ------------[ cut here ]------------
> Feb  6 02:26:27 gluon kernel: kernel BUG at mm/swapfile.c:806!
> Feb  6 02:26:27 gluon kernel: invalid operand: 0000 [#1]
> Feb  6 02:26:27 gluon kernel: CPU:    0
> Feb  6 02:26:27 gluon kernel: EIP:    0060:[<c015c7c4>]    Tainted: PFS
> Feb  6 02:26:27 gluon kernel: EFLAGS: 00010246
> Feb  6 02:26:27 gluon kernel: EIP is at map_swap_page+0x34/0x60

[ helpful info snipped ]

Interesting, thank you.  That's the second report (first on 16 Jan,
and in that case Not Tainted).  I looked around and found some bugs in
the swapfile page accounting (if swapfile filesystem blocksize < 4k:
is yours?  never heard back from Marcel on that) - still intermittently
working on and testing the fixes there - but in the end nothing which
would actually cause this BUG.  Was rather thinking it came from slab
corruption, but a second report makes that (a little) less likely.
I'll look again later on, but other eyes may find it sooner.

Hugh

