Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271051AbTG1VrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271064AbTG1VrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:47:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:52382 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271051AbTG1VrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:47:22 -0400
Date: Mon, 28 Jul 2003 14:35:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Johoho <johoho@hojo-net.de>
Cc: wodecki@gmx.de, Valdis.Kletnieks@vt.edu, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O10int for interactivity
Message-Id: <20030728143545.1d989946.akpm@osdl.org>
In-Reply-To: <20030728212939.GB6798@gmx.de>
References: <200307280112.16043.kernel@kolivas.org>
	<200307281808.h6SI8C5k004439@turing-police.cc.vt.edu>
	<20030728114041.2c8ce156.akpm@osdl.org>
	<20030728212939.GB6798@gmx.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor Wodecki <wodecki@gmx.de> wrote:
>
> On Mon, Jul 28, 2003 at 11:40:41AM -0700, Andrew Morton wrote:
> > Valdis.Kletnieks@vt.edu wrote:
> > >
> > > I am, however, able to get 'xmms' to skip.  The reason is that the CPU is being
> > >  scheduled quite adequately, but I/O is *NOT*.
> > > 
> > > ...
> > >  I'm guessing that the anticipatory scheduler is the culprit here.  Soon as I figure
> > >  out the incantations to use the deadline scheduler, I'll report back....
> > 
> > Try decreasing the expiry times in /sys/block/hda/queue/iosched:
> > 
> > read_batch_expire
> > read_expire
> > write_batch_expire
> > write_expire
> 
> I noticed that when bringing a huge application out of swap (mozilla,
> openoffice, also tested the gimp with 50 images open) that dividing
> everything by 2 in those 4 files I get a decent process fork. Without
> this tuning the fork (xterm) waits till the application is back up.

Interesting.  What we have there is pretty much a straight tradeoff between
latency and throughput.  It could be that the defaults are not centered in
the right spot.

It will need some careful characterisation.  Maybe we can persuade Nick to
generate the mystical Documentation/as-iosched.txt?

