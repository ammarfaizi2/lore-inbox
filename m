Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUHBMZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUHBMZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUHBMZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:25:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31162 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262071AbUHBMZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:25:49 -0400
Date: Mon, 2 Aug 2004 14:25:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-cd problems
Message-ID: <20040802122530.GP10496@suse.de>
References: <20040801155753.GA13702@suse.de> <200408020320.i723KG9E007500@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408020320.i723KG9E007500@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01 2004, Horst von Brand wrote:
> Jens Axboe <axboe@suse.de> said:
> > On Sun, Aug 01 2004, Alexander E. Patrakov wrote:
> 
> [...]
> 
> > > Remember that it is still possible to write CDs through ide-cd in 2.4.x 
> > > using some pre-alpha code in cdrecord:
> > > 
> > > cdrecord dev=ATAPI:1,1,0 image.iso
> 
> [...]
> 
> > Don't ever use that interface, period.
> 
> Great! So I won't be able to use any of the CD burners I have now.

Use the SG_IO interface, it should be the default if you just specify
dev=/dev/hdc instead of faking some SCSI like device enumeration for
ATAPI.

> >                                        It's not just the cdrecord code
> > that may be alpha (I doubt it matters, it's easy to use), the interface
> > it uses is not worth the lines of code it occupies.
> 
> What do you suggest then? ide-scsi is gone, so AFAIK this is the only way
> to burn CDs right now on 2.6.x

If you read the above, it was about 2.4 and using ide-cd instead of
ide-scsi there. In 2.6 you have two options outside of ide-scsi: one is
the CDROM_SEND_PACKET (which is what the dev=ATAPI:1,1,0 above used)
which works in both 2.4 and 2.6, but is absolutely crap and not
recommended. The other is the SG_IO method, which is the recommended
approach.

-- 
Jens Axboe

