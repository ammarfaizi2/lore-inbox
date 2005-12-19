Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932726AbVLSLlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbVLSLlh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 06:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbVLSLlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 06:41:37 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:5540 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932726AbVLSLlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 06:41:36 -0500
Date: Mon, 19 Dec 2005 12:40:31 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Neil Brown <neilb@suse.de>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051219114031.GA20216@wohnheim.fh-wedel.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de> <20051215231538.GF3419@redhat.com> <20051216004740.GV23349@stusta.de> <20051216005056.GG3419@redhat.com> <17314.11514.650036.686071@cse.unsw.edu.au> <20051216121805.GX23349@stusta.de> <17318.676.931250.379882@cse.unsw.edu.au> <20051219013429.GS23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051219013429.GS23349@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 December 2005 02:34:29 +0100, Adrian Bunk wrote:
> On Mon, Dec 19, 2005 at 11:45:24AM +1100, Neil Brown wrote:
> > 
> > It's hard to *know* if it is a problem, but I am conscious that nfsd
> > adds measurably to stack depth for filesystem paths, and probably
> > isn't measured nearly as often.
> > It's true that 50 bytes out of 4K isn't a lot, but wastage that can be
> > avoided, should be avoided.
> 
> "make checkstack" tells that nfsd_vfs_write is below 100 bytes of stack 
> usage. So even calling 30 such functions would not get you above
> 3 kB stack usage.
> 
> It's also interesting that according to Jörn Engel's static analysis of 
> call paths in kernel 2.6.11 [1], the string "nfs" does occur in neither 
> any of the functions involved in call paths with > 2 kB stack usage, nor 
> in any recursive call paths.
> 
> It's OK to use some bytes from the stack, and you haven't yet convinced 
> me that the code you are responsible for is using too much stack.  ;-)

Well, my metrics show the worst non-recursive paths and recursions
only.  The case at hand is a relatively innocent path on its own, but
is stacked on top of one of the recursions.

Therefore, if my tool could make more sense of recursions and f.e. see
that raid over raid is unlikely, but nfsd over xfs over raid over
block is likely, nfsd would definitely show up.  Recursions are the
hard problem to worry about.

Don't blame Neil for my tool being stupid. :)

Jörn

-- 
Don't patch bad code, rewrite it.
-- Kernigham and Pike, according to Rusty
