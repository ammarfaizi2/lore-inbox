Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVB1QVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVB1QVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVB1QVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:21:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53637 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261673AbVB1QVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:21:33 -0500
Date: Mon, 28 Feb 2005 17:21:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Haverkamp <markh@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, dm-devel@redhat.com
Subject: Re: [PATCH] Fix panic in 2.6 with bounced bio and dm
Message-ID: <20050228162128.GK8868@suse.de>
References: <1109351021.5014.10.camel@markh1.pdx.osdl.net> <20050225161947.5fd6d343.akpm@osdl.org> <Pine.LNX.4.58.0502251640050.9237@ppc970.osdl.org> <20050226123934.GA1254@suse.de> <1109604737.30227.3.camel@markh1.pdx.osdl.net> <20050228155127.GI8868@suse.de> <1109607188.30227.16.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109607188.30227.16.camel@markh1.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28 2005, Mark Haverkamp wrote:
> On Mon, 2005-02-28 at 16:51 +0100, Jens Axboe wrote:
> > On Mon, Feb 28 2005, Mark Haverkamp wrote:
> > > On Sat, 2005-02-26 at 13:39 +0100, Jens Axboe wrote:
> > > > On Fri, Feb 25 2005, Linus Torvalds wrote:
> > > > > 
> > > > > 
> > > > > On Fri, 25 Feb 2005, Andrew Morton wrote:
> > > > > > 
> > > > > > It seems very weird for dm to be shoving NULL page*'s into the middle of a
> > > > > > bio's bvec array, so your fix might end up being a workaround pending a
> > > > > > closer look at what's going on in there.
> > > > > 
> > > > > Yes. I don't see how this patch can be anything but bandaid to hide the 
> > > > > real bug. Where do these "non-page" bvec's originate?
> > > > 
> > > > Yep that's the fishy part, there should not be NULL pages in the middle
> > > > (or empty bios, for that matter) submitted for io.
> > > > 
> > > > Mark, what was the bug that triggered you to write this patch?
> > > 
> > > It happened when some pages of IO from a dm device were bounced.  It
> > > looks to me when bio's are cloned in the dm code to split it for
> > > physical devices that only the pointers to pages that apply to that
> > > device are copied and th bi_idx is adjusted to point to the start,
> > > leaving some NULL pointers at the start of the bio_vec.
> > 
> > This should fix it.
> 
> Wouldn't this potentially create bounce pages that will never be used?

Well no, it just points them at the "top" pages from the original bio.

-- 
Jens Axboe

