Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUC1SgK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbUC1SgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:36:10 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16828 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262347AbUC1SgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:36:03 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 20:45:07 +0200
User-Agent: KMail/1.5.3
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de>
In-Reply-To: <20040328183010.GQ24370@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403282045.07246.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 of March 2004 20:30, Jens Axboe wrote:
> On Sun, Mar 28 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 28 of March 2004 20:12, William Lee Irwin III wrote:
> > > On Sun, Mar 28, 2004 at 07:54:36PM +0200, Jens Axboe wrote:
> > > > Sorry, but I cannot disagree more. You think an artificial limit at
> > > > the block layer is better than one imposed at the driver end, which
> > > > actually has a lot more of an understanding of what hardware it is
> > > > driving? This makes zero sense to me. Take floppy.c for instance, I
> > > > really don't want 1MB requests there, since that would take a minute
> > > > to complete. And I might not want 1MB requests on my Super-ZXY
> > > > storage, because that beast completes io easily at an iorate of
> > > > 200MB/sec.
> > > > So you want to put this _policy_ in the block layer, instead of in
> > > > the driver. That's an even worse decision if your reasoning is
> > > > policy. The only such limits I would want to put in, are those of the
> > > > bio where simply is best to keep that small and contained within a
> > > > single page to avoid higher order allocations to do io. Limits based
> > > > on general sound principles, not something that caters to some
> > > > particular piece of hardware. I absolutely refuse to put a global
> > > > block layer 'optimal io size' restriction in, since that is the
> > > > ugliest of policies and without having _any_ knowledge of what the
> > > > hardware can do.
> > >
> > > How about per-device policies and driver hints wrt. optimal io?
> >
> > Yep, user-tunable per-device policies with sane driver defaults.
>
> BTW, these are trivial to expose through sysfs as their as inside the
> queue already.

Yep, yep.

> Making something user tunable is usually not the best idea, if you can
> deduct these things automagically instead. So whether this is the best
> idea, depends on which way you want to go.

I think it's the best idea for now, long-term we are better with automagic.

Bartlomiej

