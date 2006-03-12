Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWCLEF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWCLEF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 23:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWCLEF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 23:05:58 -0500
Received: from soundwarez.org ([217.160.171.123]:38314 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751354AbWCLEF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 23:05:57 -0500
Date: Sun, 12 Mar 2006 05:05:56 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, ambx1@neo.rr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060312040556.GA5176@vrfy.org>
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx> <20060301194532.GB25907@vrfy.org> <4406AF27.9040700@drzeus.cx> <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060311173847.23838981.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2006 at 05:38:47PM -0800, Andrew Morton wrote:
> Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> >
> >  Here is a patch for doing multi line modalias for PNP devices. This will
> >  break udev, so that needs to be updated first.
> > 
> >  I had a longer look at the card part and it seems that module aliases
> >  cannot be reliably used for it. Not without restructuring the system at
> >  least. The possible combinations explode when you notice that the driver
> >  ids needs to be just at subset of the card, without any ordering.
> > 
> >  If I got my calculations right, a PNP card would have to have roughly
> >  2^(2n) aliases, where n is the number of device ids. So right now, I
> >  lean towards only adding modalias support for the non-card part of the
> >  PNP layer.
> > 
> >  Andrew, do you want a fix for the patch in -mm or can you remove the
> >  part of it that modifies drivers/pnp/card.c by yourself?
> 
> I assume you mean that the drivers/pnp/card.c patch of
> pnp-modalias-sysfs-export.patch needs to be removed and this patch applies
> on top of the result.
> 
> But I don't want to break udev.

Right, we should not start multiline modalias sysfs files. Eighter we
get all aliases encoded in a single string, maybe like macio is doing it:
  http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;hb=HEAD;f=drivers/macintosh/macio_sysfs.c#l42
and we can pass that single string to modprobe, or we better stay with
the current one-line udev PNP rule which uses /bin/sh to do the job, which
works just fine.

Also MODALIAS in the event environment is required at the same time
the sysfs file is added. And that should also not be a multi-line
value.

Thanks,
Kay
