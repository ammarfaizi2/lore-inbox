Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTHVTFX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 15:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTHVTFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 15:05:23 -0400
Received: from gandalf.tausq.org ([64.81.244.94]:44984 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id S263195AbTHVTFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 15:05:18 -0400
Date: Fri, 22 Aug 2003 12:09:52 -0700
From: Randolph Chung <tausq@debian.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Hugh Dickins <hugh@veritas.com>, "David S. Miller" <davem@redhat.com>,
       willy@debian.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, drepper@redhat.com
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing tst-mmap-eofsync in glibc on parisc)
Message-ID: <20030822190952.GF21328@tausq.org>
Reply-To: Randolph Chung <tausq@debian.org>
References: <Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain> <1061577688.2090.285.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061577688.2090.285.camel@mulgrave>
X-PGP: for PGP key, see http://www.tausq.org/pgp.txt
X-GPG: for GPG key, see http://www.tausq.org/gpg.txt
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In reference to a message from James Bottomley, dated Aug 22:
> On Fri, 2003-08-22 at 13:34, Hugh Dickins wrote:
> > Might the problem be in parisc's __flush_dcache_page,
> > which only examines i_mmap_shared?
> 
> This is the issue: we do treat them differently.

as does some other archs, like ARM.

are we saying that MAP_SHARED != VM_SHARED? the mmap code allows
architectures to map pages differently if MAP_SHARED is specified, but
it puts it on i_mmap vs i_mmap_shared using VM_SHARED, and for read-only
files we silently drop VM_SHARED... so the page is mapped using
MAP_SHARED semantics but placed on i_mmap....

confused,
randolph
-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/
