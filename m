Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVDXCp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVDXCp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 22:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVDXCp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 22:45:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:3465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262235AbVDXCpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 22:45:17 -0400
Date: Sat, 23 Apr 2005 19:44:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: hch@infradead.org, roland@topspin.com, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050423194421.4f0d6612.akpm@osdl.org>
In-Reply-To: <4263E445.8000605@ammasso.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
	<52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org>
	<5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org>
	<52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org>
	<4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org>
	<4263E445.8000605@ammasso.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> wrote:
>
> Christoph Hellwig wrote:
> > On Mon, Apr 18, 2005 at 11:22:29AM -0500, Timur Tabi wrote:
> > 
> >>That's not what we're seeing.  We have hardware that does DMA over the 
> >>network (much like the Infiniband stuff), and we have a testcase that fails 
> >>if get_user_pages() is used, but not if mlock() is used.
> > 
> > 
> > If you don't share your testcase it's unlikely to be fixed.
> 
> As I said, the testcase only works with our hardware, and it's also very large.  It's one 
> small test that's part of a huge test suite.  It takes a couple hours just to install the 
> damn thing.
> 
> We want to produce a simpler test case that demonstrates the problem in an 
> easy-to-understand manner, but we don't have time to do that now.

If your theory is correct then it should be able to demonstrate this
problem without any special hardware at all: pin some user memory, then
generate memory pressure then check the contents of those pinned pages.

But if, for the DMA transfer, you're using the array of page*'s which were
originally obtained from get_user_pages() then it's rather hard to see how
the kernel could alter the page's contents.

Then again, if mlock() fixes it then something's up.  Very odd.
