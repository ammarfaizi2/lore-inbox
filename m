Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265760AbUFDPX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265760AbUFDPX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUFDPX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:23:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44170 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265760AbUFDPXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:23:53 -0400
Date: Fri, 4 Jun 2004 17:23:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040604152347.GD1946@suse.de>
References: <1085689455.7831.8.camel@localhost> <200406041438.44706.bzolnier@elka.pw.edu.pl> <20040604124704.GA1946@suse.de> <200406041534.48688.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406041534.48688.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04 2004, Bartlomiej Zolnierkiewicz wrote:
> On Friday 04 of June 2004 14:47, Jens Axboe wrote:
> > On Fri, Jun 04 2004, Bartlomiej Zolnierkiewicz wrote:
> > > Well, thanks but I still think that your patch suits crappy code
> > > perfectly (you know all the complains).
> >
> > I'm not on a crusade to clean up drivers/ide, in fact I could not care
> > less it if rots away (thank fully it is doing just that, pata is going
> > away). Most of your complaints are not valid in my opinion (->wrq usage
> 
> You are missing two facts:
> - I'm on the _crusade_ to clean drivers/ide and merge them with libata later

I'm well aware of that.

> - pata is (slowly) going away but support for it is not going _anywhere_
>   (although some people are smoking 'libata pata' crack)


> > is fine. it's not pretty, but it's not broken as long as you serialize
> > access across the hwgroup of course). Like the rest, it's an artifact of
> > how messy the code paths are in there. That could be cleaned too
> > naturally, but that's someone elses job and I'm not about to increase my
> > work load in that area.
> 
> Yep, you prefer to increase my work load instead.

If you think that any change to the ide base is increasing your work
load, then yes. Otherwise no.

> > That you need to queue pre/post flushes to support barriers is a _driver
> > implementation detail_ in my opinion. You don't want to even advertise
> 
> It is implementation braindamage IMO (but I'll buy it if rest is OK).

Well feel free to pull a rabbit out of your hat and suggest something
else that works for barriers. It's mind boggling that nothing so far has
come out of t13 to address this, I guess data integrity isn't high on
their list.

So in short, either shut up or put up.

> > that to upper layers. I will move a little of that into the block layer,
> > if only because SATA will need it as well.
> >
> > As for REQ_DRIVE_TASK and ide_get_error_location(), well hell I do take
> > patches! If there's something you consider broken, damnit send a patch
> 
> It is _your_ job to do it properly.

I _am_ doing it properly. If you think otherwise, then I suggest you
show in code what you want changed. If you think it's my job to keep
changing the code based on unclear suggestions, then you are sadly
mistaken.

> There are no double standards, 'IDE crap embargo' holds for everyone.

Like it or not, but ide code needs changing to support barriers one way
or the other. If there's some part of the implementation you don't like,
then I suggest you show why. Since we appear to have reached a
discussion dead lock, I suggest you do so by showing a patch changing eg
the ide_get_error_location() stuff. Sadly you could have done this
roughly 10 times in the same time frame that you have written these
emails.

> > to correct it and I'll surely merge it into the base if I agree it makes
> > sense. That's the way to get changes done if you feel something should
> > be different, snide remarks with basically zero detail is not.
> 
> I think I provided enough details few times already.
> You can always ask in case of problems (keep linux-ide@ cc:-ed).
> 
> [ First thing to do is to use REQ_DRIVE_TASKFILE not REQ_DRIVE_TASK. ]

REQ_DRIVE_TASKFILE change I agree with, and yeah you have given enough
detail there. And I'll work iget_get_error_location() to fill the holes
in case of flush errors. I'll get that change done soonish and post
updates for -mm.

-- 
Jens Axboe

