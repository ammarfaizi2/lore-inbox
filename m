Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265061AbSKESEo>; Tue, 5 Nov 2002 13:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265143AbSKESEo>; Tue, 5 Nov 2002 13:04:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54279 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265061AbSKESEn>; Tue, 5 Nov 2002 13:04:43 -0500
Date: Tue, 5 Nov 2002 10:10:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/4] timers: scsi, input, networking
In-Reply-To: <3DC75B04.FE54B2E1@digeo.com>
Message-ID: <Pine.LNX.4.44.0211051009290.2777-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. The subject says "scsi, input, networking", but there is only a scsi 
part to the patch. Messed up patch?

		Linus

On Mon, 4 Nov 2002, Andrew Morton wrote:
>
> The patches which I needed to avoid the warnings with my build. 
> 
> --- 25/drivers/scsi/scsi.c~scsi-timer-init	Mon Nov  4 18:47:02 2002
> +++ 25-akpm/drivers/scsi/scsi.c	Mon Nov  4 18:47:02 2002
> @@ -603,6 +603,7 @@ inline void __scsi_release_command(Scsi_
>  				 GFP_DMA : 0));
>  		if(newSCpnt) {
>  			memset(newSCpnt, 0, sizeof(Scsi_Cmnd));
> +			init_timer(&newSCpnt->eh_timeout);
>  			newSCpnt->host = SDpnt->host;
>  			newSCpnt->device = SDpnt;
>  			newSCpnt->target = SDpnt->id;
> @@ -1551,6 +1552,7 @@ void scsi_build_commandblocks(Scsi_Devic
>  	}
>  
>  	memset(SCpnt, 0, sizeof(Scsi_Cmnd));
> +	init_timer(&SCpnt->eh_timeout);
>  	SCpnt->host = SDpnt->host;
>  	SCpnt->device = SDpnt;
>  	SCpnt->target = SDpnt->id;
> 
> 
> 
> 

