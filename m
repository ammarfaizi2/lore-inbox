Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbUKSCUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbUKSCUH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 21:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUKSCR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 21:17:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63684 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262869AbUKRSju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:39:50 -0500
Date: Thu, 18 Nov 2004 19:39:21 +0100
From: Jens Axboe <axboe@suse.de>
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc2 OOPS on boot with 3ware + reiserfs
Message-ID: <20041118183920.GL26240@suse.de>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041117165851.GA18044@tentacle.sectorb.msk.ru> <Pine.LNX.4.58.0411170935040.2222@ppc970.osdl.org> <20041118103526.GC26240@suse.de> <20041118160248.GA5922@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118160248.GA5922@tentacle.sectorb.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18 2004, Vladimir B. Savkin wrote:
> On Thu, Nov 18, 2004 at 11:35:26AM +0100, Jens Axboe wrote:
> > On Wed, Nov 17 2004, Linus Torvalds wrote:
> > > 
> > > Jens, did you see this one?
> > 
> > Vladimir, is this completely reproducable? Does -rc1 work correctly (or
> > which was the last version you tested)? I haven't been able to spot any
> > errors in this path so far.
> 
> It happens 100% when smartd tries to fetch SMART info from
> disks connected to 3ware controller.
> Seems like using obsolete 3ware API has something to do with this.
> It does happen with -rc1 too.
> Here is a complete dmesg output:

Really looks like a double requeue, bet it happens because we end up
requeing both from the failed queuecommand return and from scsi_done().
I'll take a look.

-- 
Jens Axboe

