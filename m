Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288842AbSANGoY>; Mon, 14 Jan 2002 01:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288850AbSANGoM>; Mon, 14 Jan 2002 01:44:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36105 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288842AbSANGn5>;
	Mon, 14 Jan 2002 01:43:57 -0500
Date: Mon, 14 Jan 2002 07:43:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5: I/O errors ignored in __scsi_end_request
Message-ID: <20020114074352.C13929@suse.de>
In-Reply-To: <m2pu4euogh.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2pu4euogh.fsf@ppro.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13 2002, Peter Osterlund wrote:
> I/O errors in scsi drivers are being silently ignored in the
> __scsi_end_request function in scsi_lib.c. This patch seems obvious
> enough to me. (And it does work, at least for the packet writing
> module.)
> 
> --- linux/drivers/scsi/scsi_lib.c.old	Sun Jan 13 18:40:44 2002
> +++ linux/drivers/scsi/scsi_lib.c	Sun Jan 13 13:45:03 2002
> @@ -365,7 +365,7 @@
>  	 * If there are blocks left over at the end, set up the command
>  	 * to queue the remainder of them.
>  	 */
> -	if (end_that_request_first(req, 1, sectors)) {
> +	if (end_that_request_first(req, uptodate, sectors)) {
>  		if (!requeue)
>  			return SCpnt;

Irk, what a silly. Thanks, patch is obviously correct.

-- 
Jens Axboe

