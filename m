Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWGHVKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWGHVKd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 17:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWGHVKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 17:10:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:744 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030391AbWGHVKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 17:10:32 -0400
Date: Sat, 8 Jul 2006 23:10:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Message-ID: <20060708211003.GC2546@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <200607081238.16753.rjw@sisk.pl> <200607082131.47832.ncunningham@linuxmail.org> <200607082052.02557.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607082052.02557.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We have kswapd frozen, hooks to stop other processes trying to free memory 
> > (yes, I'm going to switch to your method of taking the pages off the lists), 
> > and userspace processes are frozen or their pages are excluded from the list.
> > 
> > > However, if we are sure that we can use LRU pages as additional storage in
> > > b), they just can be included in the memory image without copying
> > > and we only need some extra room for the other data and code.
> > > If LRU pages take 50% of memory, this would allow us to create
> > > a signle snapshot image as big as 75% of RAM (on x86_64).  IMO the
> > > remaining 25% are not worth the increased complexity of suspend2,
> > > especially that on 1 GB machine 75% of RAM is too much to save
> > > for performance reasons (ie. the extra time you save by making the
> > > system more responsive after resume is lost for saving and restoring
> > > the image, even if compression is used).
> > 
> > It's only too slow on swsusp. With Suspend2, I regularly suspend 1GB images on 
> > both my desktop and laptop machines. I agree that it might be
> > slower on a 

uswsusp is as fast as suspend2. It does same LZF compression.

> > > Furthermore, I tried to measure how much time would actually be saved if
> > > the images were greater than 50% of RAM (current swsusp's limit) and it
> > > turned out to be 10% at the very last, with compression (on a 256MB box
> > > with PII).
> > 
> > I think you'll find that this depends very much on the kind of workload you 
> > have, and how you try to compare apples with apples. If you're running lots 
> > of memory intensive apps (say VMware with a couple of hundred meg allocated, 
> > Open Office writer, Kmail, a couple of terminals and so on - I'm just 
> > describing what I normally run), you'll miss that extra memory more.

Do you think you could get some repeatable benchmark for Rafael? He
worked quite hard on feature only to find out it makes little difference...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
