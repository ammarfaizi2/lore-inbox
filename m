Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWEaGpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWEaGpf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWEaGpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:45:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13076 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964838AbWEaGpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:45:34 -0400
Date: Wed, 31 May 2006 08:47:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patch] libata resume fix
Message-ID: <20060531064730.GG29535@suse.de>
References: <20060528203419.GA15087@havoc.gtf.org> <1148938482.5959.27.camel@localhost.localdomain> <447C4718.6090802@rtr.ca> <Pine.LNX.4.64.0605301122340.5623@g5.osdl.org> <1149028674.9986.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149028674.9986.71.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31 2006, Benjamin Herrenschmidt wrote:
> > At least at one point, in order to get a M$ hw qualification (whatever 
> > it's called - but every single hw manufacturer wants it, because some 
> > vendors won't use your hardware if you don't have it), a laptop needed to 
> > boot up in less than 30 seconds or something.
> > 
> > And that wasn't the disk spin-up time. That was the time until the Windows 
> > desktop was visible.
> 
> Doesn't window spin drives asynchronously ? The main problem I've seen
> in practice (appart from the above maxtor drives) are ATAPI CD/DVD
> drives. There are whole generations of those that will happily drive
> your bus to some crazy state (even when only slave and not selected) for
> a long time while they spin up and try to identify the disk in them on a
> hard reset (and if they have trouble identifying the disk, like a
> scratched disk, that can take a loooong time).

FWIW, I've seen the very same thing. Resume/power-up with a cd/dvd that
has a media loaded can take _ages_ to get ready.

> > Desktops could do a bit longer, and I think servers didn't have any time 
> > limits, but the point is that selling a disk that takes a long time to 
> > start working is actually not that easy. 
> > 
> > The market that has accepted slow bootup times is historically the server 
> > market (don't ask me why - you'd think that with five-nines uptime 
> > guarantees you'd want fast bootup), and so you'll find large SCSI disks in 
> > particular with long spin-up times. In the laptop and desktop space I'd be 
> > very surprised to see anythign longer than a few seconds.
> 
> It's only a timeout. If you drives are fast, it will come up fast... if
> you drives are slow, it will come up slow, and if your drives are
> broken, you'll wait at most 31 seconds. Seems ok to me... It would be
> nicer in the long run if libata could resume asynchronously (by keeping
> the request queue blocked until full resume and polling the BUSY from a
> thread or a timer), but I don't think we should lower the timeout.

In reality it probably doesn't matter much, since everything will be
stalled until the queue is unfrozen anyways. Unless of course you have
several slow-to-resume devices so you would at least get some overlap.
But it would be nicer from a design view point.

-- 
Jens Axboe

