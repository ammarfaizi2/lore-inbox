Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSFIVg4>; Sun, 9 Jun 2002 17:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSFIVg4>; Sun, 9 Jun 2002 17:36:56 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:53212 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S315259AbSFIVgy>; Sun, 9 Jun 2002 17:36:54 -0400
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
From: Nicholas Miell <nmiell@attbi.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>, christoph@lameter.com,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <200206092053.g59Krsl506602@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2002 14:36:49 -0700
Message-Id: <1023658610.1518.12.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-09 at 13:53, Albert D. Cahalan wrote:
> Nicholas Miell writes:
> 
> > Putting shortcut support into the VFAT driver is as bad a decision as
> > the automatic text-file CRLF->LF conversions was, for several reasons.
> 
> No, NOTHING done with VFAT is as bad as the text conversion.
> That one was not implementable in any sane way, unless you
> think sequential read-only access (like /proc) is sane.
> 
> > First of all, some programs (WINE) will actually want to use the .lnk
> > files, and transparently converting them to symlinks will complicate
> > that.
> 
> WINE needs to be able to handle a symlink on ext2, so it can
> damn well convert back. It's OK to give WINE some hack to get at
> the content; it's not OK to hack bash to interpret .lnk files.

Why would bash even want to interpret shortcut files? They're a proprietary,
Windows-only format that have no real use beyond icons in the Start Menu
or on the desktop. Hacking the filesystem to treat something that
fundamentally is not a symlink as a symlink is even stupider than
hacking bash to do the same thing.
 
> > More importantly, shortcuts are a hell of a lot more complicated than
> > has been implied. Not only can they point to local files or UNCs (the
> > \\server\share\path notation), they can also point to any object in the
> > (Windows) shell's namespace, which includes lots of virtual objects that
> > don't actually exist on disk.
> 
> One can live with an occasional broken symlink:
> "foo" --> "[UNIMPLEMENTED LINK TYPE]"

One can also live with "foo.lnk". (It's much easier and saner, too.)

> > Finally, I haven't seen any justification for why symlinks on VFAT are
> > needed, beyond some vague statements that it's useful when dual booting.
> > Face it, VFAT isn't a Unix filesystem and introducing ugly hacks to make
> > it more similar to one will only cause problems in the long run. If you
> > want symlinks, use a real filesystem or use umsdos on your favorite FAT
> > filesystem. (Assuming that umsdos still works...).
> 

> [ insane abuse of VFAT for multi-user systems ]

You're not serious, right?

- Nicholas

