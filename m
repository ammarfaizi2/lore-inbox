Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVAYKMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVAYKMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 05:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVAYKMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 05:12:54 -0500
Received: from cantor.suse.de ([195.135.220.2]:4263 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261877AbVAYKMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 05:12:53 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Andi Kleen <ak@muc.de>, Nathan Scott <nathans@sgi.com>
Subject: Re: [patch 1/13] Qsort
Date: Tue, 25 Jan 2005 11:12:46 +0100
User-Agent: KMail/1.7.1
Cc: Mike Waychison <Michael.Waychison@sun.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>,
       Tim Hockin <thockin@hockin.org>
References: <20050122203326.402087000@blunzn.suse.de> <41F570F3.3020306@sun.com> <20050125065157.GA8297@muc.de>
In-Reply-To: <20050125065157.GA8297@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251112.46476.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 January 2005 07:51, Andi Kleen wrote:
> > FWIW, we already have a Shell sort for the ngroups stuff in
> > kernel/sys.c:groups_sort() that could be made generic.
>
> Sounds like a good plan. Any takers?

It would slow down the groups case (unless we leave the specialized version 
in). Gcc doesn't inline a cmp function pointer, and a C preprocessor 
templatized version would be really ugly. A variant with of this routine with 
qsort like interface should be good enough for nfsacl and xfs though.

Nevertheless, xfs and nfsacl have very similar requirements:

nfsacl: at most 1024 elements; 8-byte elements (16 on 64-bit archs)

xfs (from Nathan): at most 1024 elements (with 64K blocksize); 8-byte or 
larger elements

Cheers.
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
