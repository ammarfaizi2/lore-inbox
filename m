Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031651AbWLAA1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031651AbWLAA1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 19:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031649AbWLAA1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 19:27:53 -0500
Received: from ns.suse.de ([195.135.220.2]:2521 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031648AbWLAA1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 19:27:52 -0500
Date: Fri, 1 Dec 2006 01:27:50 +0100
From: Nick Piggin <npiggin@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
Message-ID: <20061201002750.GA455@wotan.suse.de>
References: <20061130072058.GA18004@wotan.suse.de> <20061130072202.GB18004@wotan.suse.de> <20061130072247.GC18004@wotan.suse.de> <20061130113241.GC12579@wotan.suse.de> <87r6vkzinv.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r6vkzinv.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 07:14:28AM +0900, OGAWA Hirofumi wrote:
> 
> quick look. Doesn't this break reiserfs? IIRC, the reiserfs is using
> it for another reason. I was also working for this, but I lost the
> thread of this, sorry.

Yes I think it will break reiserfs, so I just have to have a look
at converting it. Shouldn't take too long.

> 
> I found some another users (affs, hfs, hfsplus). Those seem have same
> problem, but probably those also can use this...
> 
> What do you think?

Well I guess this is your code, so it is up to you ;)

I would be happy if you come up with a quick fix, I'm just trying to
stamp out a few big bugs in mm. However I did prefer my way of moving
all the exapand code into generic_cont_expand, out of prepare_write, and
avoiding holding the target page locked while we're doing all the expand
work (strictly, you might be able to get away with this, but it is
fragile and ugly).

AFAIKS, the only reason to use prepare_write is to avoid passing the
get_block into generic_cont_expand?


Thanks,
Nick

