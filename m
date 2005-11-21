Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVKUWzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVKUWzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVKUWzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:55:38 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:12738 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1751198AbVKUWzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:55:37 -0500
Date: Mon, 21 Nov 2005 23:55:27 +0100
From: Luca <kronos@kronoz.cjb.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.14.2] Badness in as_insert_request at drivers/block/as-iosched.c:1519
Message-ID: <20051121225527.GA25823@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20051120203603.GA12216@dreamland.darkstar.lan> <20051120212711.GQ25454@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120212711.GQ25454@suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sun, Nov 20, 2005 at 10:27:12PM +0100, Jens Axboe ha scritto: 
> On Sun, Nov 20 2005, Luca wrote:
> > Hi,
> > while playing an audio CD with XMMS using digital audio extraction the
> > kernel started flooding my logs (syslog writes my kernel logs synchronously)
> > with the following message:
> > 
> >  cdrom: dropping to single frame dma
> >  arq->state: 4
> >  Badness in as_insert_request at drivers/block/as-iosched.c:1519
> >   [<c0104027>] dump_stack+0x17/0x20
> >   [<c0263b2c>] as_insert_request+0x5c/0x160
> >   [<c025aa0a>] __elv_add_request+0x8a/0xc0
> >   [<c025aa75>] elv_add_request+0x35/0x70
> >   [<c025dc4b>] blk_execute_rq_nowait+0x3b/0x50
> >   [<c025dcda>] blk_execute_rq+0x7a/0xb0
> >   [<c028daad>] cdrom_read_cdda_bpc+0x14d/0x1b0
> 
> This is actually the 'as' request state detection being a little to
> anxious, I think. The cdrom layer reuses the same request several times
> instead of allocating/freeing it inside the loop, and 'as' barfs if the
> request state isn't 'fresh' when it first sees the request after it has
> completed once.
> 
> This should work around the issue in the cdrom layer, even though it
> isn't actually buggy.
[...]
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 1539603..7540d27 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
[patch]

Thanks, with your patch the warning is gone.

Luca
-- 
Home: http://kronoz.cjb.net
Pare che gli uomini facciano l'amore di continuo e le donne solo
raramente. Ci dev'essere qualcuno che bara.
