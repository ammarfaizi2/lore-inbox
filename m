Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129797AbQL0GI5>; Wed, 27 Dec 2000 01:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbQL0GIr>; Wed, 27 Dec 2000 01:08:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64005 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129797AbQL0GIp>;
	Wed, 27 Dec 2000 01:08:45 -0500
Date: Wed, 27 Dec 2000 06:38:10 +0100
From: Jens Axboe <axboe@suse.de>
To: David Mansfield <lkml@dm.ultramaster.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cdrom changes in test13-pre2 slow down cdrom access by 70%
Message-ID: <20001227063810.E5981@suse.de>
In-Reply-To: <3A43D48D.B1825354@dm.ultramaster.com> <20001223133737.D300@suse.de> <3A4904CA.EA1062AF@dm.ultramaster.com> <3A4911ED.95A73903@dm.ultramaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A4911ED.95A73903@dm.ultramaster.com>; from lkml@dm.ultramaster.com on Tue, Dec 26, 2000 at 04:47:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 26 2000, David Mansfield wrote:
> > > > The cdrom changes that went into test13-pre2 really kill the performance
> > > > of my cdrom.  I'm using cdparanoia to read audio data, and it normally
> 
> ... cut ...
> 
> > Anyway, do you think a 'try to allocate 8, if that fails, try to
> > allocate 1' solution would be a simple compromise?  That should be easy
> > to do, based on the above code (if kmalloc returns NULL && frames > 1,
> > frames = 1, retry...).
> > 
> 
> Jens, 
> 
> Here's a version of the above idea, ontop of the patch you sent.  It's
> cut and pasted, but I don't think it's whitespace mangled...  I haven't
> actually run with this patch, but it does compile :-)

In principle it looks ok, but after some time we are bound to fail 8
frame allocations anyway and this patch won't help. For the modular
case, preallocation of a bigger chunk at init time is no good either.
Builtin would be fine of course. This almost screams sg to me :-)

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
