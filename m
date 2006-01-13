Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422719AbWAMPpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWAMPpY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWAMPpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:45:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15554 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422676AbWAMPpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:45:23 -0500
Date: Fri, 13 Jan 2006 07:45:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Evgeniy <dushistov@mail.ru>
Subject: Re: Oops in ufs_fill_super at mount time
In-Reply-To: <20060113102136.GA7868@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.64.0601130739540.3535@g5.osdl.org>
References: <20060113005450.GA7971@mipter.zuzino.mipt.ru>
 <Pine.LNX.4.64.0601121700041.3535@g5.osdl.org> <20060113102136.GA7868@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Jan 2006, Alexey Dobriyan wrote:

> On Thu, Jan 12, 2006 at 05:14:25PM -0800, Linus Torvalds wrote:
> >
> > This is a free'd page fault, so it's due to DEBUG_PAGEALLOC rather than a
> > wild pointer.
> 
> That's true. Turning it off makes mounting reliable again.
> 
> > Is that something new for you? Maybe the bug is older, but you've enabled
> > PAGEALLOC only recently?
> 
> Yup. In response to hangs re disk activity.

Ok, That explains why it started happening for you only _now_, but not why 
it happens in the first place.

Can you test if the patch that Evgeniy sent out fixes it for you even with 
PAGEALLOC debugging enabled?

Evgeniy - That is one ugly macro, can you (or Alexey, for that matter: 
somebody who can test it) turn it into an inline function or something to 
make it half-way readable? I realize that means changing the arguments too 
(right now that horrid macro accesses "uspi" directly - uggghhh).

If somebody maintains - or is interested in doing so - UFS, please speak 
up, we don't have anybody listed in the MAINTAINERS file, and when I look 
through the history, all I see is updates due to secondary issues (ie 
somebody did generic cleanups and just happened to touch UFS as part of 
that, rather than working _directly_ on UFS issues).

		Linus
