Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279846AbRKAXRi>; Thu, 1 Nov 2001 18:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279853AbRKAXRa>; Thu, 1 Nov 2001 18:17:30 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:23560 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S279846AbRKAXRQ>; Thu, 1 Nov 2001 18:17:16 -0500
Message-ID: <3BE1D7DE.3C768CFB@namesys.com>
Date: Fri, 02 Nov 2001 02:16:46 +0300
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: writing a plugin for reiserfs compression
In-Reply-To: <Pine.LNX.4.30.0111012218420.3201-100000@mustard.heime.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> > > I just thought there was a patch doing windows nt-like
> > > compress-em-all-realtime-and-get-doomed!
> >
> > I don't know what the actual heuristics for determining which files are
> > compression with the ext2 patch.  It is definitely NOT a compressed
> > block device.  Files are compressed in chunks (32kB?), so that it is
> > possible to seek and do read-modify-write (e.g. appending to a file)
> > without decompressing the entire file and/or recompressing it.  This also
> > protects against block corruption, since you would limit the amount of
> > data lost to the end of the chunk after the bad spot.
> 
> But still... Are the files are compressed as they are created/modified on
> the filesystem? My main point was to avoid the compression overhead and
> just decompress the file at access time if it's compressed. Compression
> should (IMO) be done nightly.
> 
> Perhaps a file should be decompressed when it's modified and either (a)
> set scheduled to next nightly compression or (b) stay uncompressed the
> next <n> days. I mean - as a file is being modified, the chance is large
> that the file will be accessed pretty soon...
> 
> > Yes, definitely disabling compression for a file is good.  The "accessed
> > in last 7 days flag" is questionable.  This could be determined via the
> > atime on Unix and doesn't need a separate flag.  Also, the difference
> > between "do not compress" and "can't compress" is very small.  If it is
> > found that the file is incompressible, you could just as easily set the
> > "do not compress" flag.
> 
> I agree on the 'accessed in last <n> days'. It'd be better to check atime.
> 
> I'd still like to separate 'do not compress' and 'can't compress', as to
> show why the falg has been set - the former is set by the admin and the
> latter by the system.
> 
> roy

I think you'll find it easiest to code it such that doing anything to the file
body, reading or writing, decompresses it.  Fancier stuff can wait for later
versions.

Hans
