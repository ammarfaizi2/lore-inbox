Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVE0Nw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVE0Nw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVE0NwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:52:11 -0400
Received: from brick.kernel.dk ([62.242.22.158]:11161 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261515AbVE0Nvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:51:55 -0400
Date: Fri, 27 May 2005 15:53:00 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: matthias.andree@gmx.de, jgarzik@pobox.com
Subject: Re: [PATCH] SATA NCQ support
Message-ID: <20050527135258.GW1435@suse.de>
References: <20050527070353.GL1435@suse.de> <20050527131842.GC19161@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527131842.GC19161@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please CC the folks in the thread!)

On Fri, May 27 2005, Matthias Andree wrote:
> On Fri, 27 May 2005, Jens Axboe wrote:
> 
> > Update the patch, it's against bleeding edge git (applies to 2.6.12-rc5
> > as well). Changes:
> > 
> > - (libata) Change to SCSI change_queue_depth API, kill current hack.
> > 
> > - (ahci) Move SActive bit set to ahci_qc_issue() where it belongs.
> 
> OK, so this is for AHCI. What are the options for people whose
> mainboards aren't blessed with AHCI, but use for instance VIA or older
> Promise chips? Buy new hardware? Or wait until someone comes up with an
> implementation?

NCQ requires hardware support from both the controller and hard drive,
you can view Jeff's libata status page for which controllers support
NCQ. via do not, some newer promise do iirc. Some siimage and qstor
support it as well.

Modifying a sata driver to support NCQ should be pretty trivial,
provided the hardware supports it (and docs are available, AHCI is
completely open).

> Can this queueing be emulated by software (libata or the libata chipset
> driver) or would such be mentioned in Jeff's list as "host-based
> queueing"?

Legacy queueing doesn't require support in the controller, however it's
not worth the effort to spend time on that. drivers/ide already had
support for that some time ago, it was ripped out again because it
sucked. IMHO, the only queueing worth supporting is NCQ. Queueing only
at the host level will not buy you anything.

-- 
Jens Axboe

