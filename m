Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWGQUsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWGQUsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 16:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWGQUsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 16:48:08 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:50667 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751187AbWGQUsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 16:48:07 -0400
Date: Mon, 17 Jul 2006 22:48:04 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jeff Anderson-Lee <jonah@eecs.berkeley.edu>
Cc: "'fsdevel'" <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
Message-ID: <20060717204804.GA18516@harddisk-recovery.com>
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net> <000001c6a9b3$81186ea0$ce2a2080@eecs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c6a9b3$81186ea0$ce2a2080@eecs.berkeley.edu>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 08:13:04AM -0700, Jeff Anderson-Lee wrote:
> In the past I've wondered why so many experimental FS projects die this
> death of obscurity in that they only work under FreeBSD or some ancient
> version of Linux.? I'm beginning to see why that is so:? the Linux core
> simply changes too fast for it to be a decent FS R&D environment!

That hasn't been a problem for OCFS2 and FUSE (recently merged), and
also doesn't seem to be a problem for GFS.

> I have been looking at implementing a COW archival file system for Linux on
> and off for some time now.? While I had hoped to develop these new FS ideas
> under Linux, so that they could have a longer life-time and wider exposure,
> that seems to be a pipe dream with the current situation.? The file system,
> VFS, and mm code has been changing so much lately it would be like trying to
> build on quicksand.? The LKML has such a high volume that I cannot afford
> the time to follow it 100%, but issues that would affect FS development are
> often raised there, instead of in linux-fsdevel.? linux-mm often contains
> issues that would affect linux-fsdevel without cross posting.? The overhead
> of following all of these lists is a huge burden of time that subtracts for
> the time available for development (and the rest of my job).

A good MUA is very important to follow high volume lists (I use Mutt
and Sylpheed, anything that supports threading should do): skim the
subjects, delete any thread you're not interested in. The result is
quite a small amount of useful posts. If you still think linux-kernel
is too much, linux-fsdevel should do. In my experience the important
changes go there first (or are CC'ed from linux-kernel).

> I saw a log-structured file system being developed as a Google summer
> project recently.? It's likely doomed to obscurity by the fs-related
> code-churning in the Linux kernel.? Since it is "experimental" it won't be
> included in the kernel distribution and hence won't get the benefit of
> kernel developers making sweeping changes that touch all the file system
> dependent code.? You practically need it to be your full-time job in order
> to do any research or development work under Linux with this kind of
> environment.

FYI the amount of vfs changes is quite small. Use git to figure out:

  git-log v2.6.12..v2.6.17 | git-shortlog | grep -i vfs | grep -vi devfs | wc -l
  57
  git-log v2.6.17..v2.6.18-rc2 | git-shortlog | grep -i vfs | grep -vi devfs | wc -l
  15

There's some clutter in those numbers, so the real amount is even
smaller. Your claim about a high amount of changes in the vfs code
doesn't seem to be backed by evidence from the kernel changelog.

> The frequent chant of LKML is "don't write a new f/s, make changes to an
> existing FS".?? While there is much merit to this approach it limits the
> ideas that can be tried to small incremental changes.? Also, since every
> existing f/s is essentially considered as "production", each change must be
> vetted by the LKML -- not ideal for "experimentation".
> 
> Things that could make Linux a better environment for FS development might
> include:
> 
> 1) Create a F/S "sandbox" where experimental FS can be added that will be
> benefit from sweeping changes that affect f/s specific code, or

You can use FUSE for that: your fs lives in userspace where you can
experiment at will. FUSE will take care of the kernel specific things.
 
> 2) A lessening (moratorium?) on sweeping changes for a while, so that FS
> developers would have a chance to try new ideas without being flooded with
> changes needed just to keep up with the latest kernel, or

See Documentation/stable_api_nonsense.txt.

> 3) Better isolation of the FS dependent and FS independent code, so that
> fewer sweeping changes are needed.
> 
> Of these: (1) is likely impractical, as it imposes an additional burden on
> kernel developers to support obscure or experimental f/s.? (2) is only a
> stop-gap, as at some point sweeping changes might again be made that would
> out-date most experimental f/s.? (3) seems the most logical course: work
> towards a better interface between the FS dependent and independent layers
> (e.g. VFS, mm) that does a better job of isolating the layers from each
> other.

I opt for option (4): accept that the number of changes are low enough
to follow for any filesystem.

> Without that, *BSD (and now possibly OpenSolaris) will be preferred over
> Linux for FS research, which typically means that few if any people benefit
> from the results: a loss for both Linux and the community at large.

IMHO that's just FUD. High rates of change haven't obstructed Linux in
any way to get a larger installed base than Solaris and *BSD.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
