Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263377AbTHVSdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263443AbTHVSdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:33:05 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13404 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263377AbTHVSdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:33:01 -0400
Date: Fri, 22 Aug 2003 19:34:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "David S. Miller" <davem@redhat.com>
cc: willy@debian.org, <James.Bottomley@SteelEye.com>,
       <linux-kernel@vger.kernel.org>, <parisc-linux@lists.parisc-linux.org>,
       <drepper@redhat.com>
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing tst-mmap-eofsync
 in glibc on parisc)
In-Reply-To: <20030822110144.5f7b83c5.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003, David S. Miller wrote:
> 
> So the proposed patch looks bogus to me.

And to me.  If VM_SHARED is set, then __vma_link_file puts the vma on
on i_mmap_shared.  If VM_SHARED is not set, it puts the vma on i_mmap.
flush_dcache_page treats i_mmap_shared and i_mmap lists equally.

Might the problem be in parisc's __flush_dcache_page,
which only examines i_mmap_shared?

Though it's odd, I'm not keen on changing do_mmap_pgoff's usage of
VM_SHARED in a hurry: it's worked like that for years, and other
things (I forget) depend on it.

Hugh

