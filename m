Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbUC2NMA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUC2NLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:11:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63145 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262951AbUC2NI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:08:59 -0500
Date: Mon, 29 Mar 2004 15:08:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, Jeff Garzik <jgarzik@pobox.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040329130850.GD24370@suse.de>
References: <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de> <40671FAF.6080501@pobox.com> <20040329080943.GR24370@suse.de> <20040329124147.GC4984@mail.shareable.org> <20040329124421.GB24370@suse.de> <1080565536.3570.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080565536.3570.4.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29 2004, Arjan van de Ven wrote:
> On Mon, 2004-03-29 at 14:44, Jens Axboe wrote:
> > On Mon, Mar 29 2004, Jamie Lokier wrote:
> > > Jens Axboe wrote:
> > > > Could be used to limit tcq depth, not just request sizes solving two
> > > > problems at once. I already have a tiny bit of keeping this
> > > > accounting to do proper unplugs (right now it just looks at missing
> > > > requests from the pool, doesn't work on tcq).
> > > 
> > > Does it make sense to allow different numbers of outstanding TCQ-reads
> > > and TCQ-writes?
> > 
> > Might not be a silly thing to experiment with, definitely something that
> > should be tested (added to list...)
> 
> I wonder if the max read size could/should be correlated with the
> readahead size for such devices... it sounds like a related property at
> least.

Indeed, it would be best to keep the read-ahead window at least a
multiple of the max read size. So you don't get the nasty effects of
having a 128k read-ahead window, but device with 255 sector limit
resulting in 124KB + 4KB read.

-- 
Jens Axboe

