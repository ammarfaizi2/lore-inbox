Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbSKXMak>; Sun, 24 Nov 2002 07:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbSKXMak>; Sun, 24 Nov 2002 07:30:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4513 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267212AbSKXMaj>;
	Sun, 24 Nov 2002 07:30:39 -0500
Date: Sun, 24 Nov 2002 13:37:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chou <acc@CS.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 5 additional buffer overruns in 2.5.48
Message-ID: <20021124123737.GY11884@suse.de>
References: <20021124063756.GA14294@Xenon.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021124063756.GA14294@Xenon.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23 2002, Andy Chou wrote:
> ---------------------------------------------------------
> [BUG] [GEM] base starts at offset 4 of buf
> /u1/acc/linux/2.5.48/drivers/cdrom/cdrom.c:1170:dvd_read_physical: 
> ERROR:BUFFER:1170:1170:Array bounds error: base[16] indexed with [16]
> 	layer->track_density = base[3] & 0xf;
> 	layer->linear_density = base[3] >> 4;
> 	layer->start_sector = base[5] << 16 | base[6] << 8 | base[7];
> 	layer->end_sector = base[9] << 16 | base[10] << 8 | base[11];
> 	layer->end_sector_l0 = base[13] << 16 | base[14] << 8 | base[15];
> 
> Error --->
> 	layer->bca = base[16] >> 7;
> 
> 	return 0;

Ah good catch. The buf[20] is simply too small, it must be 21 (or
probably just 22 to make it even, the size is 21 bytes for header and
data)

-- 
Jens Axboe

