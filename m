Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262946AbTC0OLx>; Thu, 27 Mar 2003 09:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262944AbTC0OKi>; Thu, 27 Mar 2003 09:10:38 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:12735 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262946AbTC0OKR>; Thu, 27 Mar 2003 09:10:17 -0500
Date: Thu, 27 Mar 2003 14:23:25 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
cc: "'kasper_k_jensen@sol.dk'" <kasper_k_jensen@sol.dk>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel BUG
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780B71722A@orsmsx116.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0303271409020.2247-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, Perez-Gonzalez, Inaky wrote:
> 
> Mar 26 13:38:15 localhost kernel: CPU:    0
> Mar 26 13:38:15 localhost kernel: ide-cd cdrom i810_audio ac97_codec
> soundcore a
> utofs 8139too mii iptable_filter
> Mar 26 13:38:15 localhost kernel: invalid operand: 0000
> Mar 26 13:38:15 localhost kernel: kernel BUG at page_alloc.c:145!
> Mar 26 13:38:15 localhost kernel: ------------[ cut here ]------------
> Mar 26 13:38:14 localhost kernel: swap_free: Bad swap file entry 0383304c
> Mar 26 13:38:14 localhost kernel: swap_free: Bad swap file entry 050db024
> 
> I'd say you also have problems with your swap device ... I'd first make
> sure your swap device is ok and then retry - 

No, those swap_free and swap_dup errors appear when a page table has been
corrupted, and we don't swap out page tables themselves, just the pages
they point to.  There's no reason to suspect the swap device at all.

> however, the BUG is still there, that is for sure ...
> 
> It'd also help to know your kernel version

The kernel version would help to identify the page_alloc.c:145 BUG.
But it's likely to correspond to freeing an impossible or already-freed
page, because of the corrupted page table (odd numbered corruption looks
like a valid page, even numbered corruption looks like a swap entry).

Sorry, I've no guess to make on what might be corrupting this memory.

Hugh

