Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWFZGlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWFZGlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 02:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWFZGlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 02:41:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55619 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964851AbWFZGlw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 02:41:52 -0400
Date: Mon, 26 Jun 2006 08:43:13 +0200
From: Jens Axboe <axboe@suse.de>
To: =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
Cc: James <iphitus@gmail.com>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [PATCH] fcache: a remapping boot cache
Message-ID: <20060626064313.GB3966@suse.de>
References: <20060515091806.GA4110@suse.de> <20060515101019.GA4068@suse.de> <20060516074628.GA16317@suse.de> <4d8e3fd30605301438k457f6242x1df64df9bab7f8f1@mail.gmail.com> <20060531061234.GC29535@suse.de> <1e1a7e1b0606232044x11136be5p332716b757ecd537@mail.gmail.com> <20060624110959.GQ4083@suse.de> <b8bf37780606240503s4713283eo2b8aa43513751da9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b8bf37780606240503s4713283eo2b8aa43513751da9@mail.gmail.com>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24 2006, André Goddard Rosa wrote:
> On 6/24/06, Jens Axboe <axboe@suse.de> wrote:
> >On Sat, Jun 24 2006, James wrote:
> >> Set this up on my laptop yesterday with some awesome results. I'm
> >> using 2.6.17-ck1 which has v2.1.
> >>
> >> Heres some bootcharts, before, after, and a prime run.
> >>
> >> http://archlinux.org/~james/normal.png
> >> http://archlinux.org/~james/fs-fcache.png
> >> http://archlinux.org/~james/fs-fcache-prime.png
> >>
> >> Repeated boots show about the same 6 second improvement, 32 down to 26
> >> seconds. Looking at the slowdowns in the fs-fcache run, most are due
> >> to cpu load, waiting on network or, modprobe, and not disk access. X
> >> now starts nearly instantaneously.
> >>
> >> As an experiment, I primed my cache right through to logging into my
> >> desktop environment. It was so effective, that now when I login, the
> >> GNOME splash screen only flickers onto the screen briefly, and the
> >> panels appear almost instantly. This is a big improvment over without
> >> fcache, where you'd see each component of GNOME being loaded on the
> >> splash screen, nautilus, metacity, and the panels would take quite a
> >> bit of time to render and load all their applets.
> >>
> >> Impressive work, I hope to see it broadened to other filesystems,
> >> improved and merged to vanilla soon because it has clear improvements.
> >
> >Thanks for giving it a spin! I have plans to implement some improvements
> >on monday that will speed it up even more, I hope I can talk you into
> >retesting it then. Basically it make sure we always get full speed out
> >of the drive by extending the 4kb reads with a sliding window cache.
> >That will help both drive efficiency, and also speed up the cases where
> >sub sequent boots differ just a little bit from the primed boot (often
> >the case with parallel init scripts). It should win you a few seconds
> >more in total, would be my guess.
> >
> >I hope to be able to extend it to xfs and reiser in the very near future
> >as well, should not be hard to do.
> 
> Impressive good work, Jens!

Thanks

> Do you have any distribution in contact with you already?

Not sure what you mean... My original intention with fcache was to use
it as a research project into what perfect block layout would do to the
boot process, since that seems to be a hot topic for some people.
Personally, the machines I do boot frequently are often bigger beasts
for testing purposes and they spend minutes getting to grub anyways. I
mostly use suspend/resume to keep my on times fast.

But it is interesting, and perhaps some parts of fcache will find its
way into distrobutions sometime (either directly, or parts of fcache
being reused for a slightly different approach).

-- 
Jens Axboe

