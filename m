Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVF0PsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVF0PsP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVF0Pp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:45:57 -0400
Received: from [61.149.22.166] ([61.149.22.166]:20667 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S261705AbVF0PfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 11:35:06 -0400
Date: Mon, 27 Jun 2005 23:21:05 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200506271521.j5RFL5Z02225@freya.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-06-24, Greg KH wrote:
>Anyway, here's yet-another-ramfs-based filesystem, ndevfs.  It's a very
>tiny:
>$ size fs/ndevfs/inode.o 
>   text    data     bss     dec     hex filename
>   1571     200       8    1779     6f3 fs/ndevfs/inode.o
>replacement for devfs for those embedded users who just can't live
>without the damm thing.  It doesn't allow subdirectories, and only uses
>LSB compliant names.  But it works, and should be enough for people to
>use, if they just can't wean themselves off of the idea of an in-kernel
>fs to provide device nodes.
>
>Now, with this, is there still anyone out there who just can't live
>without devfs in their kernel?
>
>Damm, the depths I've sunk to these days, I'm such a people pleaser...
>
>Comments?  Questions?  Criticisms?

	This file system is not a replacement for devfs.

	In an email that Andrew Morton sent to me in November 2004
about my small replacement devfs (which, ulike ndevfs _is_ actually a
serious development path for devfs), he essentially set a rather high
criterion for integrating a replacement.  "Either we make this
thing 110% compatible with existing userland or we hold off for 2.7.x."
ndevfs should be subject to the same standard or, preferably, the
standard should be relaxed for both devfs-like projects, as I think
it doesn't benefit devfs users or anyone else to be so stringent.

	Also, I'm sure this was just an oversight, but you ought
to post your proposed file system to linux-fsdevel.  I think some
people who care about file system particularly might watch that
list more carefully than lkml.

	To avoid arguing by unsupported assertion, I'll explain why
I believe ndevfs is not a replacement for devfs, even if it seems a
bit obvious.

	To start with the most obvious, subdirectories in /dev is
something many people find to be a much more readable user interface
(which can save human time and avoid mistakes, which is often the whole
point of computers).

	Perhaps less obvious, ndevfs system lacks demand-loading
functionality, which will typically make your system consume _more_
memory than a system using either the old devfs or my lookup trapping
facility that I separated from my devfs variant.  With demand loading,
it is not necessary to load modules for sound interfaces, or devices
that are available but will not be used before the computer shuts down,
or even to spin up disks to scan partition tables that will not be used.
It can also be useful to be able to create soft devices on demand that
have no hardware counterpart, especially in /dev/mapper/.

	If this file system gets integrated and my devfs implementation
does not, it will a send a message to contributors about personal
favoritism over technical merit, especially when I previously set a
public example by agreeing to hold off on integration until after 2.6.

	I want to be clear that I would not mind seeing ndevfs
integrated as an _additional_ file system that people could use as
an alternative to devfs, but if that is done, I think other more
meritorious file system should be get integrated as well, including
the devfs that I made (I'm happy to see old devfs continue to be
available too).

	Currently, I think it is not too strong a term to say
that devfs in the stock kernel tree is being sabotaged, when substantial
improvements are refused integration on the basis of artificially
high compatability standards not requested by its user community and
with some of the most non-objective--no that's not clear enough,
"BS"--technical claims are added to official documentation in places
like fs/Kconfig ("note that devfs has been obseleted by udev....only
provided for legacy installations...unfortunately different from the
names normal Linux installations use").

	Andrew, before you integrate ndevfs, you should integrate the
devfs variant that I made too.  I say this not because I feel that I've
been treated a bit unfairly (although I'm obviously being quite candid
that I do feel that way about this matter), but because Linux will be
better off if the ability to do things that devfs allows is more widely
available both because of potential memory savings and because better
user interfaces often really do make a particular software system
(such as Linux) the better solution (e.g., being able to do "ls /dev/discs"
to see how many disk-like devices the kernel already sees).

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
