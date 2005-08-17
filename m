Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVHQLpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVHQLpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 07:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVHQLpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 07:45:50 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:53455 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751100AbVHQLpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 07:45:49 -0400
Date: Wed, 17 Aug 2005 13:45:57 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Flash erase groups and filesystems
Message-ID: <20050817114557.GD675@wohnheim.fh-wedel.de>
References: <4300F963.5040905@drzeus.cx> <20050816162735.GB21462@wohnheim.fh-wedel.de> <43021DB8.70909@drzeus.cx> <20050816181336.GA2014@wohnheim.fh-wedel.de> <20050816185230.GA2931@wohnheim.fh-wedel.de> <430320EF.3070907@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <430320EF.3070907@drzeus.cx>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 August 2005 13:35:11 +0200, Pierre Ossman wrote:
> 
> Whilst we're on the subject, do the filesystems assume that the device
> can tell them exactly where the write failed? I.e. if the driver knows
> that 5 sectors were written correctly, but that it failed somewhere
> beyond that. It might have failed at sector 6, but it might also have
> failed at sector 10. The assumption that sectors contain either old or
> new data is still true, we're just unsure which. This can be the case
> when you feed a controller a lot of data and it can only report back
> success or failure.

Not really.  In the most common case, things have failed because the
system died unexpectedly, either through power loss or kernel bugs or
the like.  After such a clean unmount, a journal replay or fsck,
depending on the fs type, will fix things for you.  That works without
any knowledge, where the last write failed.

If the error is really an IO error, the behaviour is heavily dependent
on the fs you used.  Ext[23] will usually remount the fs read-only, so
you can hopefully retrieve all your data from the failing "hard
drive".  In that case, again, it doesn't matter much where things
broke.

> >So the only remaining option is to add a new interface that lets
> >filesystems decide to support pre-erase in some form.  And one such
> >interface would be the "forget" operation.  Nice attribute of forget
> >is the fact that it would also help some FTL layers in the kernel.
> >There is nothing MMC-specific about it.
> 
> A bit too much work for me right now. But I'll be there with my erase
> patch when someone implements it. :)

Good to know.

Jörn

-- 
There is no worse hell than that provided by the regrets
for wasted opportunities.
-- Andre-Louis Moreau in Scarabouche
