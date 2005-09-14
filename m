Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbVINEql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbVINEql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 00:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbVINEql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 00:46:41 -0400
Received: from koto.vergenet.net ([210.128.90.7]:63655 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932682AbVINEql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 00:46:41 -0400
Date: Wed, 14 Sep 2005 11:51:52 +0900
From: Horms <horms@debian.org>
To: Marc Horowitz <marc@mit.edu>, 328135@bugs.debian.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: Bug#328135: kernel-image-2.6.11-1-686-smp: nfs reading process stuck in disk wait
Message-ID: <20050914025150.GR27828@verge.net.au>
References: <20050913194707.8C8C28E6F0@ayer.connecterra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913194707.8C8C28E6F0@ayer.connecterra.net>
X-Cluestick: seven
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

would is be possible to test linux-image-2.6.12-1-686-smp from 
unstable to see if this problem persists? I am CCing the NFS
maintainer and LKML as this looks reasonably nasty and they
may be interested in looking into it.

-- 
Horms

On Tue, Sep 13, 2005 at 03:47:07PM -0400, Marc Horowitz wrote:
> Package: kernel-image-2.6.11-1-686-smp
> Version: 2.6.11-7
> Severity: important
> 
> cvs           D 00000008     0  6344   3830  6345          6162 (NOTLB)
> db6bdd18 00000086 db6bdd08 00000008 00000002 e203cba4 c02edb60 00000001 
>        00000001 00000001 000001d2 c013fe43 c02f33a0 c02f2b80 c1805fa0 00000000 
>        00000000 b3f24580 000f9fc6 00000000 e3f4f540 e3f4f694 c02f33a0 00000002 
> Call Trace:
>  [<c013fe43>] __alloc_pages+0x2e3/0x420
>  [<c02ac668>] io_schedule+0x28/0x40
>  [<c013a6c5>] sync_page+0x45/0x60
>  [<c02ac9bf>] __wait_on_bit_lock+0x5f/0x70
>  [<c013a680>] sync_page+0x0/0x60
>  [<c0131f10>] wake_bit_function+0x0/0x60
>  [<c013af51>] __lock_page+0x91/0xa0
>  [<c0131f10>] wake_bit_function+0x0/0x60
>  [<c014286d>] page_cache_readahead+0x24d/0x2d0
>  [<c0131f10>] wake_bit_function+0x0/0x60
>  [<c013af9d>] find_get_page+0x3d/0x50
>  [<c013b897>] do_generic_mapping_read+0x517/0x630
>  [<c013bcb2>] __generic_file_aio_read+0x212/0x250
>  [<c013b9b0>] file_read_actor+0x0/0xf0
>  [<c013bd4b>] generic_file_aio_read+0x5b/0x80
>  [<f8cd1920>] nfs_file_read+0xa0/0xf0 [nfs]
>  [<c015ada7>] do_sync_read+0xb7/0xf0
>  [<c014d131>] vma_merge+0xd1/0x1d0
>  [<c014d7e1>] do_mmap_pgoff+0x461/0x790
>  [<c0131eb0>] autoremove_wake_function+0x0/0x60
>  [<c015aec5>] vfs_read+0xe5/0x160
>  [<c015b1e1>] sys_read+0x51/0x80
>  [<c0103123>] syscall_call+0x7/0xb
> 
> I was doing a "cvs add" on a working directory in NFS, and the process
> got stuck here.  I don't know how to tell what file it was accessing.
> 
> I have seen this happen twice with this kernel in the past month, but
> I don't know how to reliably reproduce it.
> 
> -- System Information:
> Debian Release: 3.1
>   APT prefers testing
>   APT policy: (990, 'testing'), (500, 'unstable')
> Architecture: i386 (i686)
> Kernel: Linux 2.6.11-1-686-smp
> Locale: LANG=en_US.ISO8859-1, LC_CTYPE=en_US.ISO8859-1 (charmap=ISO-8859-1)
> 
> Versions of packages kernel-image-2.6.11-1-686-smp depends on:
> ii  coreutils [fileutils]         5.2.1-2    The GNU core utilities
> ii  initrd-tools                  0.1.77     tools to create initrd image for p
> ii  module-init-tools             3.2-pre1-2 tools for managing Linux kernel mo
> 
> -- no debconf information
> 
> 
> -- 
> To UNSUBSCRIBE, email to debian-kernel-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
