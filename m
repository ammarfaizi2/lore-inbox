Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVALWzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVALWzk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVALWyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:54:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:64235 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261537AbVALWwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:52:46 -0500
Date: Wed, 12 Jan 2005 14:52:30 -0800
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, mingo@elte.hu, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com, alsa-devel@lists.sourceforge.net,
       VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] fix: macros to detect existance of unlocked_ioctl and compat_ioctl
Message-ID: <20050112225230.GA14590@kroah.com>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com> <20050112214326.GB14703@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112214326.GB14703@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 10:43:26PM +0100, Andi Kleen wrote:
> > No, we do not do that in the kernel today, and I'm pretty sure we don't
> 
> Actually we do. e.g. take a look at skbuff.h HAVE_*
> There are other examples too.
> 
> > want to start doing it (it would get _huge_ very quickly...)
> 
> I disagree since the alternative is so ugly.

But the main problem with this is, when do we start deleting the HAVE_
symbols?  After a relativly short period of time, they become useless,
as all kernels of the past year or two have that feature, and why even
test for it?

I agree, that for short term, vendor-patched kernels, it's nice to have
something like that to try to build your out-of-the-tree module.  But
move to get that module into the tree, or provide your favorite vendor
with the properly patched driver (hey, I can dream...)

And is the alternative (using autoconf to build tiny modules testing for
different features) that ugly?  Yeah, I hate autoconf too, but I thought
that work (kernel feature testing in autoconf) has already been done,
right?

> > Please don't apply this.  Remember, out-of-the-tree modules are on their
> > own.
> 
> I don't know who made this "policy", but actively sabotating or denying 
> useful facilities to free out of tree modules doesn't seem to be a 
> very wise policy to me.

I'm not trying to sabotage anything, I just don't want the maintaince of
a zillion HAVE_ macros to slowly overrun us until we drown under the
weight.  All to support some looney, ill-informed vendor that can never
get around to submitting their driver to mainline.

And as for that "policy", it's been stated in public by Andrew and
Linus and me (if I count for anything, doubtful...) a number of
documented times.

thanks,

greg k-h
