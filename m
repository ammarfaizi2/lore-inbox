Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUIGKQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUIGKQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUIGKQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:16:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7563 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267808AbUIGKQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:16:43 -0400
Date: Tue, 7 Sep 2004 12:15:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: paulus@samba.org, juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remember to check return value from __copy_to_user() in cdrom_read_cdda_old()
Message-ID: <20040907101529.GO6323@suse.de>
References: <Pine.LNX.4.61.0409062335250.2705@dragon.hygekrogen.localhost> <20040907080223.GF6323@suse.de> <16701.32784.10441.884090@cargo.ozlabs.ibm.com> <20040907093437.GK6323@suse.de> <20040907025921.7f6a4139.akpm@osdl.org> <20040907100941.GN6323@suse.de> <20040907031258.15271794.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907031258.15271794.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > On Tue, Sep 07 2004, Andrew Morton wrote:
> > > Jens Axboe <axboe@suse.de> wrote:
> > > >
> > > > On Tue, Sep 07 2004, Paul Mackerras wrote:
> > > > > Jens Axboe writes:
> > > > > 
> > > > > > __copy_to_user is the unchecking version of copy_to_user.
> > > > > 
> > > > > It doesn't range-check the address, but it does return non-zero
> > > > > (number of bytes not copied) if it encounters a fault writing to the
> > > > > user buffer.
> > > > 
> > > > but it doesn't matter, if it returns non-zero then something happened
> > > > between the access_ok() and the actual copy because the user app did
> > > > something silly. so I don't care much really, I think the major point is
> > > > the kernel will cope.
> > > > 
> > > > you could remove the access_ok() and change it to a copy_to_user()
> > > > instead, I don't care either way. it's the old and slow interface which
> > > > really never is used unless things have gone wrong anyways.
> > > > 
> > > 
> > > Sure, but at present if an application tries to read cdrom data to address
> > > 0x00000000 (say), the kernel will return "success".  It should return an
> > > error code.  (Actually, it should return a short read if any data was
> > > transferred, but whatever).
> > 
> > Because access_ok() isn't reliable?
> 
> access_ok() simply checks that the address is in the 0x00000000 -
> 0xbfffffff range.  We can still get faults in that range.

Ok, it's pretty useless then.

-- 
Jens Axboe

