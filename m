Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276301AbRI1UmU>; Fri, 28 Sep 2001 16:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276300AbRI1UmK>; Fri, 28 Sep 2001 16:42:10 -0400
Received: from [194.213.32.137] ([194.213.32.137]:15108 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S276302AbRI1UmA>;
	Fri, 28 Sep 2001 16:42:00 -0400
Message-ID: <20010928224001.B1100@bug.ucw.cz>
Date: Fri, 28 Sep 2001 22:40:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: move resume before mounting root [diff against vanilla 2.4.9]
In-Reply-To: <20010927163421.C23647@atrey.karlin.mff.cuni.cz> <200109280356.f8S3u5g154813@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200109280356.f8S3u5g154813@saturn.cs.uml.edu>; from Albert D. Cahalan on Thu, Sep 27, 2001 at 11:56:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I can't do that: open deleted files.
> 
> Tough luck. Either use the same hack as NFS, or have such files
> return -EIO for all operations and give SIGBUS for mappings.
> Maybe just refuse to suspend when there are open deleted files.
> Oh, just create a name in the filesystem root and use that.
> Something like ".8fe4a979.swsusp" would be fine. Whatever!

...and break locking and similar stuff. NFS is not as good as local
filesystem.

> >> NFS faces. Between the suspend and resume, filesystems may be
> >> modified in arbitrary ways.
> >
> > No, you don't want to do that. This is swsusp package, meant to
> > replace suspend-to-disk on your notebook. If you choose random
> > notebook, it will allow you to suspend to disk, but not to suspend,
> > boot X, poweron, boot Y, reboot, boot X.
> >
> > If you do what you described, you'll corrupt your filesystem. It is
> > designed that way.
> 
> Not "If", but "When". Somebody has already posted a report of
> doing exactly that, by accident, with a 3-month-old suspension.
> The filesystems were destroyed.
> 
> Right now, swsusp is a serious hazard.

That's why its called experimental ;-).

Currently we have "SWSUSP" signature, SWAP-FILE gets replaced with
SWSUSP on suspend, and SWAP-FILE is written back on resume. That way,
you can not resume two times from one image.

Additional safety measure could be added: on every swapon, check if
"SWSUSP" is there, and replace it with "SWAP-FILE" if so. (Currently
it says -EINVAL). That should make it pretty safe.

Of course, you'll still be able to shoot yourself in the foot even
with added "security". Just don't do it, then.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
