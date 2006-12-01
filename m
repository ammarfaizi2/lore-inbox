Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754665AbWLACD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbWLACD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 21:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756025AbWLACD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 21:03:57 -0500
Received: from ns2.suse.de ([195.135.220.15]:7605 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753660AbWLACD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 21:03:56 -0500
Date: Fri, 1 Dec 2006 03:03:55 +0100
From: Nick Piggin <npiggin@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
Message-ID: <20061201020355.GB455@wotan.suse.de>
References: <20061130072058.GA18004@wotan.suse.de> <20061130072202.GB18004@wotan.suse.de> <20061130072247.GC18004@wotan.suse.de> <20061130113241.GC12579@wotan.suse.de> <87r6vkzinv.fsf@duaron.myhome.or.jp> <20061201002750.GA455@wotan.suse.de> <873b80v2rx.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873b80v2rx.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 10:11:14AM +0900, OGAWA Hirofumi wrote:
> Nick Piggin <npiggin@suse.de> writes:
> 
> > I would be happy if you come up with a quick fix, I'm just trying to
> > stamp out a few big bugs in mm. However I did prefer my way of moving
> > all the exapand code into generic_cont_expand, out of prepare_write, and
> > avoiding holding the target page locked while we're doing all the expand
> > work (strictly, you might be able to get away with this, but it is
> > fragile and ugly).
> >
> > AFAIKS, the only reason to use prepare_write is to avoid passing the
> > get_block into generic_cont_expand?
> 
> IIRC, because generic_cont_expand is designed as really generic. It
> can also use for non moronic filesystem.
> 
> In the case of reiserfs, it ->prepare_write might be necessary.

Yes I see :(

Well, maybe we should use your alternate patch, then.
I have a few questions on it.
