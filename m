Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933463AbWKNRzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933463AbWKNRzf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933462AbWKNRzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:55:35 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:30482 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S933466AbWKNRze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:55:34 -0500
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 (+ide-cd patches) regression: unable to rip cd
References: <20061110161355.GB15031@kernel.dk>
	<87u01717qw.fsf@sycorax.lbl.gov> <20061113200256.GC15031@kernel.dk>
	<87lkmfcdci.fsf@sycorax.lbl.gov> <20061113203523.GE15031@kernel.dk>
Date: Tue, 14 Nov 2006 09:55:30 -0800
In-Reply-To: <20061113203523.GE15031@kernel.dk> (message from Jens Axboe on
	Mon, 13 Nov 2006 21:35:23 +0100)
Message-ID: <87ejs5dib1.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> writes:

> There is a second error handling patch merged with the first patch as
> well, perhaps it'll help you out. Attached here as well.
>
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index bddfebd..8821494 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -724,7 +724,7 @@ static int cdrom_decode_status(ide_drive
>  		 * if we have an error, pass back CHECK_CONDITION as the
>  		 * scsi status byte
>  		 */
> -		if (!rq->errors)
> +		if (blk_pc_request(rq) && !rq->errors)
>  			rq->errors = SAM_STAT_CHECK_CONDITION;
>  
>  		/* Check for tray open. */
>

tried it again with this patch (on top of all the other patches).
overall things are much better than they've been in a long time
(thanks!), but... when cdparanoia gets stuck, if i abort the process
and restart it the ripping proceeds very slowly (~5x before, ~1.5x
after). if i eject/insert the cd and then restart cdparanoia the speed
is as before (~5x). something doesn't get reset until the cd is
ejected, don't know if it's the kernel's fault though. same thing
happens if i get an error reading a sector but then cdparanoia manages
to recover. from that point on the speed is very slow (again until i
eject/insert the cd; a new instance of cdparanoia is just as slow).

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
