Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314554AbSEPS7n>; Thu, 16 May 2002 14:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314557AbSEPS7m>; Thu, 16 May 2002 14:59:42 -0400
Received: from [195.223.140.120] ([195.223.140.120]:11612 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314554AbSEPS7l>; Thu, 16 May 2002 14:59:41 -0400
Date: Thu, 16 May 2002 20:59:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Juan Quintela <quintela@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020516185937.GG1025@dualathlon.random>
In-Reply-To: <20020516160754.GR1025@dualathlon.random> <Pine.LNX.4.44L.0205161536160.32261-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 03:37:49PM -0300, Rik van Riel wrote:
> On Thu, 16 May 2002, Andrea Arcangeli wrote:
> > On Thu, May 16, 2002 at 11:27:37AM +0200, Juan Quintela wrote:
> > > I am missing something, or how do you pass the notail option to your
> > > reiserfs rootfs when the initrd is ext2.
> >
> > fair enough (the new initrd API allows that, but it's very ugly that it
> > is not dynamic from a kernel param like rootfstype would be, but it
> > instead has to be written on disk within the initrd), however as said
> > that's all due the brokeness of the rootfs params, they should apply
> > only to the fianl real root dev, never to the initrd.
> 
> There's another issue.  The real root device might not be known
> at the time the initrd is first loaded.
> 
> This is the case in some installers, which seem to use pivot_root
> after the installer is done so the user doesn't need to reboot
> after the install is done...
> 
> Of course, the real root device won't be known until after the user
> has done the partitioning of the hard disk(s).

Sure I see that, and that's also allowed by the new initrd API, and in
such case you cannot make use of the two rootfs* params anyways because
as you say you don't know what the wanted partitioning in advance.

What i'm saying is that if you want to add notail option to the root
mount after you finished installing your system (so with a normally non
interactive initrd) you can't make use of the rootfs* parameters to
tweak the root mount during lilo (like you could do without initrd)
because they're applied to both initrd and real root dev and that's
clearly another bug (but not very important). And with the new initrd
API such bug basically doesn't matter because the rootfstype will be
forced in the static initrd image (while without initrd, or with the old
initrd API + the bugfix that applies rootfs* only to the root dev I
could make use of the rootfs* flags).

Andrea
