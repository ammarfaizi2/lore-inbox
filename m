Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946032AbWGOMe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946032AbWGOMe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 08:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946034AbWGOMe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 08:34:28 -0400
Received: from [212.76.92.164] ([212.76.92.164]:51719 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1946032AbWGOMe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 08:34:28 -0400
From: Al Boldi <a1426z@gawab.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCHSET] 0/15 IO scheduler improvements
Date: Sat, 15 Jul 2006 15:35:03 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607132350.47388.a1426z@gawab.com> <200607142253.26372.a1426z@gawab.com> <20060715110638.GC22724@suse.de>
In-Reply-To: <20060715110638.GC22724@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607151535.04042.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jul 14 2006, Al Boldi wrote:
> > Jens Axboe wrote:
> > > On Thu, Jul 13 2006, Al Boldi wrote:
> > > > Jens Axboe wrote:
> > > > > This is a continuation of the patches posted yesterday, I
> > > > > continued to build on them. The patch series does:
> > > > >
> > > > > - Move the hash backmerging into the elevator core.
> > > > > - Move the rbtree handling into the elevator core.
> > > > > - Abstract the FIFO handling into the elevator core.
> > > > > - Kill the io scheduler private requests, that require
> > > > > allocation/free for each request passed through the system.
> > > > >
> > > > > The result is a faster elevator core (and faster IO schedulers),
> > > > > with a nice net reduction of kernel text and code as well.
> > > >
> > > > Thanks!
> > > >
> > > > Your efforts are much appreciated, as the current situation is a bit
> > > > awkward.
> > >
> > > It's a good step forward, at least.
> > >
> > > > > If you have time, please give this patch series a test spin just
> > > > > to verify that everything still works for you. Thanks!
> > > >
> > > > Do you have a combo-patch against 2.6.17?
> > >
> > > Not really, but git let me generate one pretty easily. It has a few
> > > select changes outside of the patchset as well, but should be ok. It's
> > > not tested though, should work but the rbtree changes needed to be
> > > done additionally. If it boots, it should work :-)
> >
> > patch applies ok
> > compiles ok
> > panics on boot at elv_rb_del
> > patch -R succeeds with lot's of hunks
>
> So I most likely botched the rbtree conversion, sorry about that. Oh, I
> think it's a silly reverted condition, can you try this one?

Thanks!

patch applies ok
compiles ok
boots ok
patch -R succeeds with lot's of hunks

Tried it anyway, and found an improvement only in cfq, where :
echo 512 > /sys/block/hda/queue/max_sectors_kb
gives full speed for 5-10 sec then drops to half speed
other scheds lock into half speed
echo 192 > /sys/block/hda/queue/max_sectors_kb
gives full speed for all scheds

Thanks!

--
Al

