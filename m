Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUHEMo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUHEMo2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUHEMlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:41:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4813 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267276AbUHEMjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:39:17 -0400
Date: Thu, 5 Aug 2004 14:38:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040805123859.GL11159@suse.de>
References: <200408051230.i75CU4RC004440@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051230.i75CU4RC004440@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, Joerg Schilling wrote:
> 
> >From: Jens Axboe <axboe@suse.de>
> 
> >> this is the reason why the patch forces the ata (atapi?) driver. no
> >> SCSI driver or configuring of ide-scsi required.
> 
> >Maybe newer version broke then. Until very recently, cdrecord worked
> >just fine as-is and used SG_IO access method when you used open by
> >device name. Which was just the way we wanted it.
> 
> >If that doesn't work now, I suggest you take it up with Joerg. It's a
> >problem with his program.
> 
> It's a problem caused by the design in the Linux kernel and not a problem of
> libscg or cdrecord. 
> 
> The point is that Linux constantly invents new ugly and unneeded things and
> after I found a workaround, people try to prevent the workaround from
> being usable. 

It's been bad in the past, I agree. But the advertised way to work with
this hasn't changed in the past few years, and was and is still sg v3.
So you should support that through read(2)/write(2) to /dev/sg*, or
through SG_IO ioctl to the device. The latter is recommended since
currently works for all devices, plus it's the simpler (and good enough)
interface to use for cdrecord since it doesn't require queuing.

> In 1998, I did send a patch against the sg.c driver that introduced
> everything that is needed for Generic SCSI transport. I am still
> waiting for even the needed features to appear........

If you have issues with SG_IO, please feel free to address them. If they
are valid, I'd love to help you get it fixed.

-- 
Jens Axboe

