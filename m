Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265661AbUGDMlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUGDMlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbUGDMlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:41:44 -0400
Received: from av5-1-sn3.vrr.skanova.net ([81.228.9.113]:50858 "EHLO
	av5-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S265661AbUGDMlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:41:22 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
References: <m2lli36ec9.fsf@telia.com> <m2u0wqqdpl.fsf@telia.com>
	<20040702150819.646b6103.akpm@osdl.org>
	<20040702224720.GA7969@kroah.com>
	<20040702155945.5c375bd2.akpm@osdl.org> <m27jtm0z7q.fsf@telia.com>
	<20040702165132.575cba5b.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 04 Jul 2004 13:57:07 +0200
In-Reply-To: <20040702165132.575cba5b.akpm@osdl.org>
Message-ID: <m2fz88ugrw.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Peter Osterlund <petero2@telia.com> wrote:
> >
> > > Oop, sorry, yes.  Peter, are you sure this is where the leak is coming from?
> > 
> > I'm sure that the module reference count as reported by lsmod
> > increases each time I access /proc/driver/pktcdvd/pktcdvd0. I can make
> > this problem go away either by patching __bdevname() or by deleting
> > the call to __bdevname() in pktcdvd.c.
> 
> Can't you use bdevname(pd->bdev) in there?

Not without more changes, because pd->bdev is only non-NULL when the
device is actually opened by someone. When the device is setup (ie
mapped to a real device) but not opened, pd->bdev (a struct
block_device *) is NULL and pd->dev (a dev_t) is the only thing that
keeps track of the mapping between the packet device and the real
device.

Maybe that's a bad design though. Perhaps pd->dev can be eliminated
altogether.

But anyway, if __bdevname() leaks a module reference it should get
fixed, right?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
