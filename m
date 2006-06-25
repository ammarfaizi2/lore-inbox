Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWFYRoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWFYRoj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 13:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWFYRoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 13:44:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27971 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964786AbWFYRoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 13:44:37 -0400
Date: Sun, 25 Jun 2006 19:43:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: Re: 2.6.17-ck1: fcache problem...
Message-ID: <20060625174358.GA21513@suse.de>
References: <20060625093534.1700e8b6@localhost> <20060625102837.GC20702@suse.de> <20060625152325.605faf1f@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625152325.605faf1f@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25 2006, Paolo Ornati wrote:
> On Sun, 25 Jun 2006 12:28:39 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > > [   26.673525] fcache: found serial 33, expected 34.
> > > [   26.673529] fcache: reprime the cache!
> > > [   26.673535] ext3: failed to open fcache (err=-22)
> > 
> > Hmm, and you are sure that the fs is properly umounted on reboot? Or is
> > it just remounted ro? It looks like fcache_close_dev() isn't being
> > called, so the cache serial doesn't match what we expect from the fs,
> > hence fcache bails out since it could indicate that the fs has been
> > changed without fcache being attached.
> 
> Ahh... it is the root fs and it's just remounted read-only by the
> standard Gentoo scripts ;)
> 
> I don't think that unmounting it is trivial (you need to chroot to a
> virtual FS or something...). Does any distro do it?

ro should be enough, something odd must be going on. I'll add it to the
list of things to test tomorrow.

> > What kind of speedup did you see?
> 
> with cold caches...
> 
> NORMAL
> from Grub to KDM login		42"5	(~6" to reach init)
> KDE 3.5.3 startup		10"
> Firefox				7"
> 
> FCACHE
> from Grub to KDM login		31"4	(~6" to reach init)
> KDE 3.5.3 startup		4"
> Firefox				2"4

Very nice!

-- 
Jens Axboe

