Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288835AbSAIFle>; Wed, 9 Jan 2002 00:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288836AbSAIFlO>; Wed, 9 Jan 2002 00:41:14 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:1964 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288835AbSAIFlM>; Wed, 9 Jan 2002 00:41:12 -0500
Date: Tue, 8 Jan 2002 22:41:24 -0700
Message-Id: <200201090541.g095fOa29516@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <3C3BBD50.2020805@zytor.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>
	<20020108201451.088f7f99.rusty@rustcorp.com.au>
	<a1f9j9$5i9$1@cesium.transmeta.com>
	<20020109120108.39bcf7ad.rusty@rustcorp.com.au>
	<a1gcme$18t$1@cesium.transmeta.com>
	<200201090330.g093UB427696@vindaloo.ras.ucalgary.ca>
	<3C3BBD50.2020805@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Richard Gooch wrote:
> 
> >>>
> >>So you chown an entry, then a module is unloaded and reloaded, now
> >>what happens?
> >>
> >>It's the old "virtual filesystem which really wants persistence"
> >>issue again...
> >>
> > 
> > Works beautifully with devfs+devfsd :-)
> > 
> > Permissions get saved elsewhere in the namespace (perhaps even to the
> > underlying /dev) as you chown(2)/chmod(2)/mknod(2), and are restored
> > when entries are (re)created and/or at startup.
> > 
> > My /dev has persistence behaviour which looks like a FS with backing
> > store.
> 
> Yes, after quite a few years it finally got in there.  This is a Good 
> Thing[TM].  Now apply the same problem to /proc.

Actually, the COPY action has been available since APR-2000 :-)

But as for applying this to /proc, that's a good point. My current
plans are to write v2.0 of the devfs core, which will use the dcache
to maintain the devfs tree structure, rather than having my own code
to do it. That should result in a significant reduction in code side,
and maybe finally people won't hate the idea so much.

So then, one approach would be to have control files where you want to
have permissions persistence placed in devfs. Of course, for
consistency, you'd want all control files under devfs. A /dev/sys
hierarchy perhaps.

Another idea is to turn devfs into some kind of "kernfs", and have one
instance for /dev, another for /proc/sys (or /system if you like), and
run an instance of devfsd (renamed to "kernfsd" perhaps) for each of
these instances.

Of course, it depends on whether people *want* permissions persistence
for /proc/sys. Is there much call for this?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
