Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVAYMpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVAYMpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVAYMpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:45:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35775 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261920AbVAYMpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:45:16 -0500
Date: Tue, 25 Jan 2005 13:45:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Elias da Silva <silva@aurigatec.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Message-ID: <20050125124512.GM2751@suse.de>
References: <200501220327.38236.silva@aurigatec.de> <200501242310.00184.silva@aurigatec.de> <1106611309.6148.116.camel@localhost.localdomain> <200501251029.22646.silva@aurigatec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501251029.22646.silva@aurigatec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25 2005, Elias da Silva wrote:
> : Someone did actually have a demo of a small fs that allowed you to
> : fiddle with the status but possibly the code could get smarter for
> : "exclusive user of media". I'm not sure if that is worth it.
> 
> Do you have the name of the fs and/or the name of author?

If I'm not mistaken, Peter Jones has posted a few iterations of such an
fs some months ago.

> Do we have a clear understanding that this fs would only
> be a benefit if *All* the different ways to access the device would
> use the same policy enforcement and consistently allow or
> disallow certain operations regardless of the access method?

The command restriction table _only_ works through the SG_IO path, which
does include CDROM_SEND_PACKET as well since it is layered on top of
SG_IO. It doesn't control various driver ioctl exported interfaces, they
would need to add a callback to verify_command() for permission checks.

-- 
Jens Axboe

