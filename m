Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbTEWHtU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 03:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTEWHtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 03:49:20 -0400
Received: from rth.ninka.net ([216.101.162.244]:30851 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263905AbTEWHtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 03:49:19 -0400
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
	2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: LW@KARO-electronics.de, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030522151156.C12171@flint.arm.linux.org.uk>
References: <16076.50160.67366.435042@ipc1.karo>
	 <20030522151156.C12171@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053676924.30675.2.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 May 2003 01:02:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 07:11, Russell King wrote:
> We seem to have flush_icache_page() in install_page() - I wonder whether
> we should also have flush_dcache_page() in there as well.
...
> Maybe someone more knowledgeable of the VM layer can comment.

I am not sure of the exact environment install_page() is meant
to run in, does it always know that no mapping exists at that
address?

If not, something (either there or higher up) needs to be doing
a flush_cache_page(...) at a minimum.

The things that some platforms use flush_icache_page() for are
handled by other platforms using other mechanisms in clever ways (for
example, at update_mmu_cache() or instruction TLB miss time, older
sparc64's use special D/I cache flush block stores to handle the I-cache
coherency problem there).

-- 
David S. Miller <davem@redhat.com>
