Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277094AbRKAV17>; Thu, 1 Nov 2001 16:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279784AbRKAV1s>; Thu, 1 Nov 2001 16:27:48 -0500
Received: from mustard.heime.net ([194.234.65.222]:55972 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S277094AbRKAV1b>; Thu, 1 Nov 2001 16:27:31 -0500
Date: Thu, 1 Nov 2001 22:27:24 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Andreas Dilger <adilger@turbolabs.com>
cc: <reiser@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: writing a plugin for reiserfs compression
In-Reply-To: <20011101141438.F16554@lynx.no>
Message-ID: <Pine.LNX.4.30.0111012218420.3201-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I just thought there was a patch doing windows nt-like
> > compress-em-all-realtime-and-get-doomed!
>
> I don't know what the actual heuristics for determining which files are
> compression with the ext2 patch.  It is definitely NOT a compressed
> block device.  Files are compressed in chunks (32kB?), so that it is
> possible to seek and do read-modify-write (e.g. appending to a file)
> without decompressing the entire file and/or recompressing it.  This also
> protects against block corruption, since you would limit the amount of
> data lost to the end of the chunk after the bad spot.

But still... Are the files are compressed as they are created/modified on
the filesystem? My main point was to avoid the compression overhead and
just decompress the file at access time if it's compressed. Compression
should (IMO) be done nightly.

Perhaps a file should be decompressed when it's modified and either (a)
set scheduled to next nightly compression or (b) stay uncompressed the
next <n> days. I mean - as a file is being modified, the chance is large
that the file will be accessed pretty soon...

> Yes, definitely disabling compression for a file is good.  The "accessed
> in last 7 days flag" is questionable.  This could be determined via the
> atime on Unix and doesn't need a separate flag.  Also, the difference
> between "do not compress" and "can't compress" is very small.  If it is
> found that the file is incompressible, you could just as easily set the
> "do not compress" flag.

I agree on the 'accessed in last <n> days'. It'd be better to check atime.

I'd still like to separate 'do not compress' and 'can't compress', as to
show why the falg has been set - the former is set by the admin and the
latter by the system.

roy

