Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUBKMJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 07:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUBKMJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 07:09:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6068 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263963AbUBKMJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 07:09:43 -0500
Date: Wed, 11 Feb 2004 13:09:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Stuart Hayes <Stuart_Hayes@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH (for 2.6.3-rc1) for cdrom driver dvd_read_struct
Message-ID: <20040211120937.GA19047@suse.de>
References: <Pine.LNX.4.44.0402101035050.29125-100000@tux.linuxdev.us.dell.com> <20040210171215.GM4109@suse.de> <20040211115123.GB15127@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211115123.GB15127@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11 2004, Jamie Lokier wrote:
> Jens Axboe wrote:
> > On Tue, Feb 10 2004, Stuart Hayes wrote:
> > > The attached patch will make the "dvd_read_struct" function in cdrom.c 
> > > check that the DVD drive can currently do the DVD read structure command 
> > > before sending the command to the drive.  It does this by checking the 
> > > "dvd read" feature using the "get configuration" command.
> > > 
> > > Currently, cdrom.c only checks that the drive is a DVD drive before 
> > > allowing the dvd read structure command to go to the drive--it does not 
> > > make sure that the DVD drive has a DVD in it.  Without this patch, if CD 
> > > medium is in a DVD drive, and the DVD_READ_STRUCT ioctl is used, the drive
> > > will spew an ugly "illegal request" error (magicdev does this).
> > 
> > I'm rather anxious about applying anything like this, in my experience
> > it's much much safer to simply let the command fail. I don't see
> > anything technically wrong with your approach, I'd just like it tested
> > on 100 different dvd drives :)
> 
> Meaning that you don't trust the DVD media test to return true on all
> drives when and only when there's DVD media currently in there?
> 
> If that's your logic, it follows that userspace programs shouldn't
> trust the DVD media test either - they should always call
> DVD_READ_STRUCT if they would like to treat DVDs differently to CDs.
> 
> So, can you add a flag to the request meaning "if this
> DVD_READ_STRUCT request fails with illegal request, don't log it"?

There's the generic cgc->quiet bit for this very purpose. However,
thinking about this particular issue some more,  the feature check
really ought to work for all cases. So I think it's worth a shot
applying the patch as-is. I don't see any better solutions.

-- 
Jens Axboe

