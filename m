Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSGLFrz>; Fri, 12 Jul 2002 01:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSGLFry>; Fri, 12 Jul 2002 01:47:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8142 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314381AbSGLFry>;
	Fri, 12 Jul 2002 01:47:54 -0400
Date: Fri, 12 Jul 2002 07:46:32 +0200
From: Jens Axboe <axboe@kernel.org>
To: Jochen Suckfuell <jo-lkml@suckfuell.net>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Bill Davidsen <davidsen@tmr.com>, Andries Brouwer <aebr@win.tue.nl>,
       Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Disk IO statistics still buggy
Message-ID: <20020712054632.GN855@suse.de>
References: <20020706074824.GA24771@win.tue.nl> <Pine.LNX.4.44.0207060740020.10105-100000@hawkeye.luckynet.adm> <20020709190019.A19394@ds217-115-141-141.dedicated.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020709190019.A19394@ds217-115-141-141.dedicated.hosteurope.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09 2002, Jochen Suckfuell wrote:
> --- linux/drivers/scsi/scsi_lib.c Mon Jul  8 16:15:27 2002
> +++ linux_work/drivers/scsi/scsi_lib.c Tue Jul  9 17:56:39 2002
> @@ -426,7 +426,9 @@
>    if (req->waiting != NULL) {
>     complete(req->waiting);
>    }
> +  spin_lock_irq(&io_request_lock);
>    req_finished_io(req);
> +  spin_unlock_irq(&io_request_lock);
>    add_blkdev_randomness(MAJOR(req->rq_dev));
>  
>          SDpnt = SCpnt->device;

good spotting, that's definitely a bug

-- 
Jens Axboe

