Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWB1PUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWB1PUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 10:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWB1PUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 10:20:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10861 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751065AbWB1PUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 10:20:06 -0500
Date: Tue, 28 Feb 2006 16:19:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hannes Reinecke <hare@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] Fixup ahci suspend / resume
Message-ID: <20060228151928.GC24981@suse.de>
References: <44045FB1.5040408@suse.de> <440468DB.5060605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440468DB.5060605@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28 2006, Jeff Garzik wrote:
> Hannes Reinecke wrote:
> >From: Hannes Reinecke <hare@suse.de>
> >Subject: AHCI suspend / resume fixes.
> >
> >The current ahci driver has the problem that it doesn't resume properly.
> >Or rather, that resuming is unstable.
> >Reason being is that AHCI has 4 registers containing the DMA address it
> >should write things to. Of course there is no guarantee that Linux has
> >assigned the same address to the DMA area across reboots.
> >So we should better re-initialize those registers after resume.
> >
> >The patch also improves the port_start / port_stop routines to be more
> >closely modelled after the spec. This also avoids a nasty msleep(500)
> >during initialisation.
> >
> >Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> 
> Seems sane at first glance, but can you please regenerate this against 
> libata-dev.git#upstream ?
> 
> Upstream 2.6.x doesn't care at all about suspend/resume, and AHCI has 
> seen several modifications in #upstream that are waiting for 2.6.17.

Upstream 2.6.x certainly _does_ care about suspend/resume! To me, this
patch seems simple enough to be included. It's little more than
splitting the register init out form the port_stop/start functions and
calling them on resume/suspend appropriately.

-- 
Jens Axboe

