Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUHAOlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUHAOlO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 10:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUHAOlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 10:41:13 -0400
Received: from mail.dif.dk ([193.138.115.101]:2503 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265977AbUHAOlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 10:41:07 -0400
Date: Sun, 1 Aug 2004 16:45:38 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>, Oliver Neukum <oliver@neukum.name>,
       Ali Akcaagac <aliakc@web.de>, Jamie Lenehan <lenehan@twibble.org>
Subject: Re: [PATCH] fix gcc 3.4 inlining errors in drivers/scsi/dc395x.c
In-Reply-To: <20040801141541.GO2746@fs.tum.de>
Message-ID: <Pine.LNX.4.60.0408011642060.2535@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.60.0408011355080.2535@dragon.hygekrogen.localhost>
 <20040801141541.GO2746@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, Adrian Bunk wrote:

> On Sun, Aug 01, 2004 at 02:02:50PM +0200, Jesper Juhl wrote:
> > 
> > drivers/scsi/dc395x.c fails to build in 2.6.8-rc2-mm1 with gcc 3.4.0 with 
> > the following errors :
> > 
> > drivers/scsi/dc395x.c: In function `dc395x_handle_interrupt':
> > drivers/scsi/dc395x.c:388: sorry, unimplemented: inlining failed in call to 'enable_msgout_abort': function body not available
> > drivers/scsi/dc395x.c:1740: sorry, unimplemented: called from here
> > 
> > drivers/scsi/dc395x.c: In function `msgin_set_async':
> > drivers/scsi/dc395x.c:394: sorry, unimplemented: inlining failed in call to 'set_xfer_rate': function body not available
> > drivers/scsi/dc395x.c:2677: sorry, unimplemented: called from here
> > 
> > The patch below fixes the build by un-inlining the functions (an 
> > alternative would be to rework the file so the functions move before their 
> > first use). As for 'set_xfer_rate' the function itself was not declared 
> > inline, only the prototype.
> >...
> 
> Jamie Lenehan already ACK'ed a similar patch I sent two weeks ago which 
> moves enable_msgout_abort instead of un-inlining it.
> 
Ohh, OK, I did a search in my lkml mailbox before sending off the patch, 
guess I missed it.

Since you already did a bunch of these I'm trying to avoid sending patches 
for the ones you alrady did, but a few might slip. Just trying to fill in 
the remaining blanks :)


> Both approaches are feasible, it's up to the maintainers to decide which 
> one is better in this case.
> 
Agreed.


/Jesper

