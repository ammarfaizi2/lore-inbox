Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268234AbTALFOW>; Sun, 12 Jan 2003 00:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268235AbTALFOV>; Sun, 12 Jan 2003 00:14:21 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:22723 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S268234AbTALFOU>; Sun, 12 Jan 2003 00:14:20 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Rob Wilkens <robw@optonline.net>
Cc: Ryan Anderson <ryan@michonline.com>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Date: Sat, 11 Jan 2003 21:10:16 -0800 (PST)
Subject: Re: The GPL, the kernel, and everything else.
In-Reply-To: <1042347339.1033.191.camel@RobsPC.RobertWilkens.com>
Message-ID: <Pine.LNX.4.44.0301112103110.31214-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2003, Rob Wilkens wrote:

> > 2. modules not only need to be called with the correct parameters, they
> > also need to do the proper locking. as locking evolves what needs to be
> > done by the module changes. This can only be solved by every module doing
> > locking 'just in casee' at which point the unessasary locking becomes a
> > significant performance issue (Larry McVoy has written a document about
> > why locking is bad and why excessive locking is very bad, search archives
> > for the link to his site)
>
> I don't need to read an article to know why locking is bad.  However, if
> we can broadly generalize drivers into categories (instead of just
> "modules", for example, there could be a generic "video module"
> structure and that could have a specific kind of locking that a video
> driver would need, and the same would go for other specific types of
> drivers).

the problem is that the locking that's nessasary for a storage driver
depends on the locking that's implemented in the filesystem that's calling
the driver. that locking changes over time.

it used to be that locking was simple, you took the BKL and that was it
(and then only if you needed to, if you were only called from a place that
already heldthe BKL you didn't need to do anything)

as time goes on and existing algorithms are replaced by others the locking
requirements change. useing my example above, if the filesystem layer is
changed so that it no longer needs the BKL then the storage driver needs
to aquire it itself (if it needs it, not all of them will)

> > 4. since no designer (or group of designers) can think of everything your
> > API is going to be incomplete anyway. you can either pretend this isn't
> > the case and limit yourself to the things that you origionally imagined,
> > change your API (and now what do you do with things that used the
>
> Why is it that Windows doesn't seem to have a problem providing a
> generic binary driver interface -- one that is portable accross
> operating systems as mentioned before -- drivers which work on Windows
> 98 are binary compatible with Windows 2000 and Windows XP despite major
> difference in the systems never mind minor kernel changes.
>
> I'd suggest that a linux kernel developer get their hands on a copy of
> the specs for the wdm (windows device driver model) and learn what
> useful information they can from it.

I don't know what you've been running, but windows device drivers are not
compatable across all the different versions of windows (try installing a
windows 9x driver in NT for example).

> > as for signing kernel modules as being 'good' you have a serious problem
> > in the Linux world that there is no central authority to do any such
> > signing.
>
> Microsoft uses Verisign I believe, which is a company linux commands
> like "whois" already use to do nameserver lookups for example.  It's a
> third party, and hardware manufacturers probably already have
> certificates from them.

verisign does not decide what drivers to sign, microsoft does, microsoft
signs them useing a key they got from verisign. that's a very different
situation.

David Lang


