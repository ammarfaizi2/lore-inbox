Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSLPUbm>; Mon, 16 Dec 2002 15:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSLPUbm>; Mon, 16 Dec 2002 15:31:42 -0500
Received: from bitmover.com ([192.132.92.2]:27294 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261418AbSLPUbl>;
	Mon, 16 Dec 2002 15:31:41 -0500
Date: Mon, 16 Dec 2002 12:39:32 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben Collins <bcollins@debian.org>, Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.52
Message-ID: <20021216123932.B6887@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ben Collins <bcollins@debian.org>,
	Christoph Hellwig <hch@infradead.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021216151639.GQ504@hopper.phunnypharm.org> <Pine.LNX.4.44.0212160920380.2799-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0212160920380.2799-100000@home.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 16, 2002 at 09:26:58AM -0800
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alternatively, never EVER make a patch against the "current kernel
> version". Only make a patch against the _last_ kernel that you merged
> with, and if I cannot apply it I will tell you so. Making a patch just
> between your tree and mine will _always_ end up losing fixes.

I think this is a good approach.  If people sent Linus patches with some
indication of the baseline of the patch, such as BASELINE=v2.5.49 in the
header of the patch,  I'd be willing to go make bk import -temail do 
the right thing, which would probably be to try and patch it in in the
working tree, but if that didn't work, it would do

	bk clone -l -r$BASELINE tree tree.$BASELINE
	cd tree.$BASLINE
	bk import -temail ....
	cd ../tree
	bk pull ../tree.$BASELINE  && rm -rf ../tree.$BASELINE

and you'd get BK to merge most of the work.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
