Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUIOUez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUIOUez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUIOUdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:33:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36290 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267362AbUIOUci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:32:38 -0400
Subject: Re: [PATCH] allow root to modify raw scsi command permissions list
From: Peter Jones <pjones@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20040915195024.GA3899@suse.de>
References: <1095173470.5728.3.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409152151190.1972@kai.makisara.local>
	 <20040915195024.GA3899@suse.de>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 16:32:24 -0400
Message-Id: <1095280344.20046.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 21:50 +0200, Jens Axboe wrote:
> > This could also be done in your approach. One possibility would be to 
> > start with empty filter and call from CD/DVD registering a function that 
> > sets the filter you currently have as default. This would be both flexible 
> > and safe.
> 
> I think that's a really nice idea. I've said right from the beginning
> that the command tables cannot even be per-device type, at least with
> CDROMs we have examples of commands with different meanings. But at
> least with a device-type default list we're a little closer.

It'd be pretty easy to add device-type defaults to my patch, and make
them registered by the individual drivers.

I'm just not sure I see the point in doing it.  Without them, you get a
_somewhat_ reasonable set of defaults if you don't want to mess with it,
and distros can easily set their own per-device tables for each device
type, vendor specific commands, etc.  It's even pretty simple to just
deny everything, if that's what distro maintainers or sysadmins want to
do.

Not doing it also means that the device driver code itself needs less
maintenance, and won't need to be updated every time some vendor comes
up with a new READ command.  That makes it easier if for example distros
decide to push new command tables as updates, I think.

> A good reminder of why the whole thing is a mess :-)

It sure is.
-- 
        Peter

