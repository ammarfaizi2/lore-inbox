Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTHZLg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 07:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTHZLg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 07:36:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28126 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263666AbTHZLg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 07:36:56 -0400
Date: Tue, 26 Aug 2003 13:36:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Samphan Raruenrom <samphan@nectec.or.th>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Rdi1] Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
Message-ID: <20030826113633.GA22124@suse.de>
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org> <3F4B0343.7050605@nectec.or.th> <20030826083249.B20776@infradead.org> <3F4B23E2.8040401@nectec.or.th> <20030826105613.A23356@infradead.org> <20030826095830.GA20693@suse.de> <3F4B44C2.4030406@nectec.or.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4B44C2.4030406@nectec.or.th>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26 2003, Samphan Raruenrom wrote:
> >Exactly. You poll media events from the drive, and upon an eject request
> >you try and umount it. If it suceeds, you eject the tray. 
> 
> No, it seems impossible to sense the eject request (right?). This

No it isn't, in fact there are several ways to do it. Just by searching
this list you should be able to find them.

> is what I really did with the patched kernel and patched magicdev.

magicdev is a piece of crap.

> When, for example:-
> 
> - user insert CD
> - magicdev sense the CD, mount /dev/cdrom -> eject is ok
> - user play an mp3 file in the disc
> - magicdev found MOUNT_STATUS=BUSY, lock the drive -> eject disabled
> - user stop using any file on the disc
> - magicdev found MOUNT_STATUS=MOUNTED, unlock the drive -> eject is ok
> - user push the eject button, the disc pop out because it's not locked.
> - magicdev sense empty drive, umount /dev/cdrom

That's not the way to do it. For drives that support media status event
reporting you don't lock the drive, you just intercept the eject
request. And at that time you check if you can umount /cdrom (or
whatever) - if that suceeds, you send an eject request to the drive.
This will work with any drive made in the last few years. You can also
check out MS media status notification, I think you can even find that
document on microsoft.com.

I think you need to spend a little more time thinking/researching this
problem. At least it really looks like you are going about it all wrong.

-- 
Jens Axboe

