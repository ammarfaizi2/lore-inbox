Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVLSApl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVLSApl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 19:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVLSApl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 19:45:41 -0500
Received: from cantor2.suse.de ([195.135.220.15]:51387 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030198AbVLSApk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 19:45:40 -0500
From: Neil Brown <neilb@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Date: Mon, 19 Dec 2005 11:45:24 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17318.676.931250.379882@cse.unsw.edu.au>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-Reply-To: message from Adrian Bunk on Friday December 16
References: <20051215212447.GR23349@stusta.de>
	<20051215140013.7d4ffd5b.akpm@osdl.org>
	<20051215223000.GU23349@stusta.de>
	<20051215231538.GF3419@redhat.com>
	<20051216004740.GV23349@stusta.de>
	<20051216005056.GG3419@redhat.com>
	<17314.11514.650036.686071@cse.unsw.edu.au>
	<20051216121805.GX23349@stusta.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday December 16, bunk@stusta.de wrote:
> 
> The nfsd code uses inline in too many places.

Does it?
Most of the uses are either
 - truly tiny bits of code
 - code that is used only once which, as you as, will not currently 
   be auto-inlined on i386, so we do it by hand.

An exception is some of the xdr code.
If I 
  #define inline
in nfs3xdr.c, the nfsd.o changes from 
   text    data     bss     dec     hex filename
  76132    3464    2408   82004   14054 ../mm-i386/fs/nfsd/nfsd.o
to
   text    data     bss     dec     hex filename
  72452    3464    2408   78324   131f4 ../mm-i386/fs/nfsd/nfsd.o
which is probably a win.

Is that what you were referring to?

> 
> If this struct is really a problem (which I doubt considering it's 
> size), I'd prefer it being kmalloc'ed.

It's hard to *know* if it is a problem, but I am conscious that nfsd
adds measurably to stack depth for filesystem paths, and probably
isn't measured nearly as often.
It's true that 50 bytes out of 4K isn't a lot, but wastage that can be
avoided, should be avoided.

NeilBrown
