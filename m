Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbUAaVtP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 16:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUAaVtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 16:49:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64897 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265113AbUAaVtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 16:49:10 -0500
Date: Sat, 31 Jan 2004 22:49:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Willem Riede <wrlk@riede.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The survival of ide-scsi in 2.6.x [PATCH 2/3]
Message-ID: <20040131214903.GE11683@suse.de>
References: <1072809890.2839.24.camel@mulgrave> <20040103190857.GY5523@suse.de> <20040128132400.GA23308@serve.riede.org> <200401302356.59401.bzolnier@elka.pw.edu.pl> <20040131214513.GY23308@serve.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131214513.GY23308@serve.riede.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31 2004, Willem Riede wrote:
> On 2004.01.30 17:56, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Can you split your patch and drop cosmetic changes?
> 
> Changes in this second patch:
> - some whitespace changes to improve readability
> - use consistent printk priorities
> 
> Regards, Willem Riede.
> 
> --- p1/drivers/scsi/ide-scsi.c	2004-01-31 15:37:31.000000000 -0500
> +++ p2/drivers/scsi/ide-scsi.c	2004-01-31 15:57:08.000000000 -0500
> @@ -54,7 +54,9 @@
>  #include "hosts.h"
>  #include <scsi/sg.h>
>  
> -#define IDESCSI_DEBUG_LOG		0
> +#define IDESCSI_DEBUG_LOG	0
> +#define IDESCSI_DEBUG		KERN_NOTICE
> +#define IDESCSI_LOG		KERN_INFO

Hmm

> @@ -309,23 +311,25 @@
>  
>  static int idescsi_end_request (ide_drive_t *drive, int uptodate, int nrsecs)
>  {
> -	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
> -	struct request *rq = HWGROUP(drive)->rq;
> -	idescsi_pc_t *pc = (idescsi_pc_t *) rq->special;
> -	int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
> +	idescsi_scsi_t   *scsi = drive_to_idescsi(drive);
> +	struct request   *rq  = HWGROUP(drive)->rq;
> +	idescsi_pc_t     *pc  = (idescsi_pc_t *) rq->special;
> +	int               log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
>  	struct Scsi_Host *host;
> -	u8 *scsi_buf;
> -	unsigned long flags;
> +	u8               *scsi_buf;
> +	unsigned long     flags;

What is the point of this? Forget any (bogus) white space and style
"cleanups", it's totally irrelevant. Produce the patches fixing some
issues, cleanups are really not appropriate.

I hope your 3rd patch will be just that. Make sure it patch against
vanilla tree, not the two just sent.

-- 
Jens Axboe

