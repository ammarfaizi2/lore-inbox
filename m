Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271295AbTGWU17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271298AbTGWU17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:27:59 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:48612
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271295AbTGWU16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:27:58 -0400
Date: Wed, 23 Jul 2003 16:43:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Javier Achirica <achirica@telefonica.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>
Subject: Re: [PATCH 2.5] fixes for airo.c
Message-ID: <20030723204304.GA1929@gtf.org>
References: <Pine.SOL.4.30.0307231219020.12179-100000@tudela.mad.ttd.net> <200307231956.58656.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307231956.58656.daniel.ritz@gmx.ch>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 07:56:58PM +0200, Daniel Ritz wrote:
> [shortening the cc: list a bit..]
> 
> On Wed July 23 2003 12:26, Javier Achirica wrote:
> > 
> > You cannot use down() in xmit, as it may be called in interrupt context. I
> > know it slows things down, but that's the only way I figured out of
> > handling a transmission while the card is processing a long command.
> 
> hu? no. you can do a down() as xmit is never called from interrupt context. and
> the dev->hard_start_xmit() calls are serialized with the dev->xmit_lock. the
> serialization is broken by the schedule_work() thing.

hard_start_xmit is called from BH-disabled context, so Javier is
basically correct.

	Jeff



