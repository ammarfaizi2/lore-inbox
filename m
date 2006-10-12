Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422713AbWJLQEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbWJLQEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbWJLQEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:04:44 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:36872 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1422713AbWJLQEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:04:43 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       olaf@aepfle.de
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk>
	<1160648885.5897.6.camel@Homer.simpson.net>
	<1160662435.6177.3.camel@Homer.simpson.net>
	<20061012120927.GQ6515@kernel.dk> <20061012122146.GS6515@kernel.dk>
	<87odshr289.fsf@sycorax.lbl.gov> <20061012152356.GE6515@kernel.dk>
Date: Thu, 12 Oct 2006 09:04:16 -0700
In-Reply-To: <20061012152356.GE6515@kernel.dk> (message from Jens Axboe on
	Thu, 12 Oct 2006 17:23:57 +0200)
Message-ID: <87slhtfrlr.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> writes:

> Argh damn, it needs this on top of it as well. Your second problem
> likely stems from that missing bit, please retest with this one applied
> as well.
>
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index e7513e5..bddfebd 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -716,7 +716,7 @@ static int cdrom_decode_status(ide_drive
>  		ide_error(drive, "request sense failure", stat);
>  		return 1;
>  
> -	} else if (blk_pc_request(rq)) {
> +	} else if (blk_pc_request(rq) || rq->cmd_type == REQ_TYPE_ATA_PC) {
>  		/* All other functions, except for READ. */
>  		unsigned long flags;
>  

please ignore my previous message, i am an idiot. if i actually put a
dvd in the drive then this patch works as expected. sorry for the
noise.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
