Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTHVSij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTHVSij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:38:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37810 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263676AbTHVSih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:38:37 -0400
Date: Fri, 22 Aug 2003 11:31:06 -0700
From: "David S. Miller" <davem@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: willy@debian.org, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       drepper@redhat.com
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
 tst-mmap-eofsync in glibc on parisc)
Message-Id: <20030822113106.0503a665.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
References: <20030822110144.5f7b83c5.davem@redhat.com>
	<Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003 19:34:41 +0100 (BST)
Hugh Dickins <hugh@veritas.com> wrote:

> And to me.  If VM_SHARED is set, then __vma_link_file puts the vma on
> on i_mmap_shared.  If VM_SHARED is not set, it puts the vma on i_mmap.
> flush_dcache_page treats i_mmap_shared and i_mmap lists equally.

But file system page cache writes only call flush_dache_page()
if the page has a non-empty i_mmap_shared list.

> Might the problem be in parisc's __flush_dcache_page,
> which only examines i_mmap_shared?

No, it examines both lists, the problem is not there.

The issue seems to be some confusion about whether the
test program in question is actually mmap()'ing the area
with PROT_WRITE set, and if so why the test case isn't
passing because in such a case the page will have a non-empty
i_mmap_shared list.
