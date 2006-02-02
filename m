Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWBBL7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWBBL7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWBBL7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:59:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53677 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750926AbWBBL7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:59:19 -0500
Date: Thu, 2 Feb 2006 12:59:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060202115907.GH1884@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022038.16262.nigel@suspend2.net> <20060202104750.GC1884@elf.ucw.cz> <200602022131.59928.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602022131.59928.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 02-02-06 21:31:55, Nigel Cunningham wrote:
> Hi.
> 
> On Thursday 02 February 2006 20:47, Pavel Machek wrote:
> > Hi!
> >
> > > > swsusp already has a very strong API to separate image writing from
> > > > image creation (in -mm patch, anyway). It is also very nice, just
> > > > read() from /dev/snapshot. Please use it.
> > >
> > > You know that's not an option.
> >
> > No, I don't... please explain. Switching to this interface is going to
> > be easier than pushing suspend2 into kernel. Granted, end result may
> > not be suspend2, it may be something like suspend3, but it will be
> > better result than u-swsusp or suspend2 is today...
> 
> It's not an option because I'm not trying not to step all over your codebase, 
> because I'm not moving suspend2 to userspace and because it doesn't make 
> sense to add another layer of abstraction by sticking /dev/snapshot in the 
> middle of kernel space code. There may be more reasons, but I haven't looked 
> at the /dev/snapshot code at all.

Please take a look at /dev/snapshot.

Parse error at the first sentence (too many nots), anyway:

1) we do not want two implementations of same code in kernel. [swsusp
vs. pmdisk was a mess]

2) we are not going to merge code into kernel, when it is possible to
do same thing in userspace. (*)

3) backwards compatibility is important in stable series.

4) merging code into kernel is a lot of work.

I do not think I want to remove swsusp from kernel. Even if I wanted
to, there's 3). That means suspend2 should not go in (see 1). Even if I
removed swsusp from kernel, suspend2 is not going to be merged,
because of 2). Even if world somehow forgot that it is possible to do
suspend2 in userspace, merging 10K lines of code is (4) still lot of
work.

Oops, that looks bad for suspend2 merge. I really think you should
take a look at /dev/snapshot. Unless it is terminally broken, I can't
see how suspend2 could be merged.

									Pavel
(*) or very close to same thing. We still can't save memory full of caches.
-- 
Thanks, Sharp!
