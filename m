Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289229AbSAIINq>; Wed, 9 Jan 2002 03:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289237AbSAIINg>; Wed, 9 Jan 2002 03:13:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47119 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289229AbSAIIN0>;
	Wed, 9 Jan 2002 03:13:26 -0500
Date: Wed, 9 Jan 2002 09:12:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Oops with eject and cdrom affects 2.4 & 2.5
Message-ID: <20020109091217.K19814@suse.de>
In-Reply-To: <Pine.LNX.4.33.0201090809080.30141-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201090809080.30141-100000@netfinity.realnet.co.sz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09 2002, Zwane Mwaikambo wrote:
> Hi Jens, Marcelo,
> 	Doing an "eject" with my somewhat damaged SuSE 5.3 CD gave me the
> appended reproducible oops. This bug is present in both 2.4 (visual
> inspection) and 2.5. Here is the code path before the oops
> 
> ide-cd.c
> static
> int cdrom_queue_packet_command(ide_drive_t *drive, struct packet_command
> *pc)
> {
> <snip>
> 		if (ide_do_drive_cmd (drive, &req, ide_wait)) { <== [1]
> 			printk("%s: do_drive_cmd returned
> stat=%02x,err=%02x\n",
> 				drive->name, req.buffer[0],
> req.buffer[1]);
> 			/* FIXME: we should probably abort/retry or
> something */
> <snip>
> 
> [1] ide_do_drive_cmd returns -EIO so we end up doing the printk. Tadow!
> NULL dereference because of (char *)req.buffer. Then again, this printk
> seems quite redundant IMO.

Yes, just kill the printk instead.

-- 
Jens Axboe

