Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSFJDMT>; Sun, 9 Jun 2002 23:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316397AbSFJDMT>; Sun, 9 Jun 2002 23:12:19 -0400
Received: from adsl-63-205-245-1.dsl.snfc21.pacbell.net ([63.205.245.1]:15082
	"EHLO amboise.dolphin") by vger.kernel.org with ESMTP
	id <S316235AbSFJDMS>; Sun, 9 Jun 2002 23:12:18 -0400
Date: Sun, 9 Jun 2002 20:12:17 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
X-X-Sender: fgouget@amboise.dolphin
To: linux-kernel@vger.kernel.org
cc: Jeremy White <jwhite@codeweavers.com>
Subject: Re: isofs unhide option:  troubles with Wine
In-Reply-To: <TiM$20020525030142$2365@deschutes.mathewson.int>
Message-ID: <Pine.LNX.4.43.0206091947390.6638-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replying a bit late 'cause I was on vacation at the time (and because I
have stronger feelings about this issue than Jeremy :-)


On Sat, 25 May 2002, Joseph Mathewson wrote:
[...]
> > Further, I would argue that if you accept that unhide is a
> > reasonable default for me to force into the fstab, then
> > it is a reasonable default for the kernel to have.
>
> Is this not an issue that could be put to RedHat/Mandrake/SuSE/Turbo/etc to
> include the above fstab in their standard install.  If the user is going to have
> to upgrade their kernel to get this default, they will understand fstab.  If
> they do not understand fstab, they are going to upgrade their kernel by
> upgrading their distro anyway.  So why not push for this option in the default
> fstab of popular distros?

The goal is not to tell users to upgrade their kernels. The goal is to
make the problem gradually disappear by fixing the kernel now. (when
distributions start shipping with the fixed kernel we'll have much fewer
complaints already)


Now I will argue that making 'hidden' files inaccessible is a kernel
bug.

On Windows if you use FindFirstFile + FindNextFile (equivalent to
opendir/readdir), you get all files, including hidden files. Similarly,
you can use CreateFile to open a hidden file. In other words there is no
difference between hidden and regular files a the API level.

Now, switch to Linux and try opendir+readdir. Unless you specified the
'unhide' option, hidden files are not returned. Similarly you cannot use
open on a hidden file. For all purposes and intent 'hidden' files are
inaccessible on Linux.

Now, hidden files are not something new, FAT had that since the
beginning. Yet, the FAT driver as never made hidden files inaccessible.
I'm sure there would have been riots if it had (and I missed on all the
fun). Imagine being unable to tweak bootsect.dos or boot.ini?

I also believe that ECMA 119 section 9.1.6 intends the 'Existence' bit
to be the same as the 'hidden' flag of FAT. Certainly MS uses it the
same way. ECMA says:

    If set to ZERO, shall mean that the existence of the file shall be
    made known to the user upon an inquiry by the user.
    If set to ONE, shall mean that the existence of the file need not be
    made known to the user.

Now, the way I read it, the user is the guy sitting in front of the
computer, not the 'userland' program making the API call. Thus what ECMA
says is that this bit can be used by applications like 'dir' or 'Windows
Explorer' to filter out some file entries. In any case, it is not
even mandatory to do so.
(note I agree with Andries wrt. Associated files)

So, we will certainly send a patch for this, but:
1. should it make 'unhide' the default and add a 'hide' option?
2. or should it completely ignore the 'hidden' bit?

I am very much in favor of option 2. But does anyone know of a case
where making hidden files inaccessible is desired?

(adding an ioctl to get that bit would be nice if there is none
currently but we may not go that far :-)


--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
                      Computers are like airconditioners
                They stop working properly if you open WINDOWS

