Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbUAGSmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbUAGSmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:42:13 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8660 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265283AbUAGSmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:42:09 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] 2.6.1-rc2 ide barrier support
Date: Wed, 7 Jan 2004 19:45:04 +0100
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040107134323.GB16720@suse.de>
In-Reply-To: <20040107134323.GB16720@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401071945.04649.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 of January 2004 14:43, Jens Axboe wrote:
> Bart, would you care to review the ide bits for sanity?

Yep, here is just a first sight...

> +	struct request *flush_rq = &HWGROUP(drive)->wrq;

I want to remove drive->wrq in the future.

> +	memset(drive->special_buf, 0, sizeof(drive->special_buf));
> +
> +	ide_init_drive_cmd(flush_rq);
> +
> +	flush_rq->flags = REQ_DRIVE_TASK;
> +	flush_rq->buffer = drive->special_buf;
> +	flush_rq->special = rq;
> +	flush_rq->buffer[0] = WIN_FLUSH_CACHE;
> +	flush_rq->nr_sectors = rq->nr_sectors;

I think you should try use REQ_DRIVE_TASKFILE,
instead of adding drive->special_buf.

> +/*
> + * FIXME: probably move this somewhere else, name is bad too :)
> + */
> +static sector_t ide_get_error_location(ide_drive_t *drive, char *args)

This is probably useful in few other places.

--bart

