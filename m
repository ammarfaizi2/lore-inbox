Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTJPKsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbTJPKsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:48:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39588 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262827AbTJPKsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:48:17 -0400
Date: Thu, 16 Oct 2003 12:48:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031016104814.GO1128@suse.de>
References: <20031013140858.GU1107@suse.de> <20031013223911.GB14152@merlin.emma.line.org> <3F8B4048.2010007@pobox.com> <20031016103653.GN1128@suse.de> <3F8E76F2.10908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8E76F2.10908@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16 2003, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Mon, Oct 13 2003, Jeff Garzik wrote:
> >
> >>Matthias Andree wrote:
> >>
> >>>On Mon, 13 Oct 2003, Jens Axboe wrote:
> >>>
> >>>
> >>>
> >>>>Forward ported and tested today (with the dummy ext3 patch included),
> >>>>works for me. Some todo's left, but I thought I'd send it out to gauge
> >>>>interest. TODO:
> >>>>
> >>>>- Detect write cache setting and only issue SYNC_CACHE if write cache is
> >>>>enabled (not a biggy, all drives ship with it enabled)
> >>>
> >>>
> >>>Yup, and I disable it on all drives at boot time at the latest.
> >>>
> >>>Is there a status document that lists
> >>>
> >>>- what SCSI drivers support write barriers
> >>>(I'm interested in sym53c8xx_2 if that matters)
> >>>
> >>>- what IDE drivers support write barriers
> >>>(VIA for AMD and Intel for PII/PIII/P4 chip sets here)
> >>
> >>The device is the entity that does, or does not, support flush-cache... 
> >>All IDE chipsets support flush-cache... it's just another IDE command.
> >
> >
> >Well drivers need to support it, too. IDE is supported, and that covers
> >all devices that support it. It's not implemented on SCSI at all right
> >now, that's coming up.
> 
> I do not see the need for write barrier support in 
> drivers/ide/pci/{via82cxxx,piix,}.c, which is the question the original 
> poster was asking.
> 
> Low-level chipset drivers should _not_ need to support it, the subsystem 
> can do that.

Right, nothing for IDE - as I wrote, IDE is supported and that covers
all devices. For SCSI, low level device drivers _do_ need to support it,
it's usually a two-liner to add support setting the ordered tag bit.

-- 
Jens Axboe

