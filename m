Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265983AbUHAOQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUHAOQD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 10:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbUHAOQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 10:16:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4827 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265983AbUHAOPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 10:15:47 -0400
Date: Sun, 1 Aug 2004 16:15:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>, Oliver Neukum <oliver@neukum.name>,
       Ali Akcaagac <aliakc@web.de>, Jamie Lenehan <lenehan@twibble.org>
Subject: Re: [PATCH] fix gcc 3.4 inlining errors in drivers/scsi/dc395x.c
Message-ID: <20040801141541.GO2746@fs.tum.de>
References: <Pine.LNX.4.60.0408011355080.2535@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0408011355080.2535@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 02:02:50PM +0200, Jesper Juhl wrote:
> 
> drivers/scsi/dc395x.c fails to build in 2.6.8-rc2-mm1 with gcc 3.4.0 with 
> the following errors :
> 
> drivers/scsi/dc395x.c: In function `dc395x_handle_interrupt':
> drivers/scsi/dc395x.c:388: sorry, unimplemented: inlining failed in call to 'enable_msgout_abort': function body not available
> drivers/scsi/dc395x.c:1740: sorry, unimplemented: called from here
> 
> drivers/scsi/dc395x.c: In function `msgin_set_async':
> drivers/scsi/dc395x.c:394: sorry, unimplemented: inlining failed in call to 'set_xfer_rate': function body not available
> drivers/scsi/dc395x.c:2677: sorry, unimplemented: called from here
> 
> The patch below fixes the build by un-inlining the functions (an 
> alternative would be to rework the file so the functions move before their 
> first use). As for 'set_xfer_rate' the function itself was not declared 
> inline, only the prototype.
>...

Jamie Lenehan already ACK'ed a similar patch I sent two weeks ago which 
moves enable_msgout_abort instead of un-inlining it.

Both approaches are feasible, it's up to the maintainers to decide which 
one is better in this case.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

