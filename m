Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290211AbSAORrh>; Tue, 15 Jan 2002 12:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290212AbSAORra>; Tue, 15 Jan 2002 12:47:30 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:22789 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S290211AbSAORrQ>; Tue, 15 Jan 2002 12:47:16 -0500
Date: Tue, 15 Jan 2002 18:47:12 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Cc: feedback@suse.de
Subject: Re: [reiserfs-list] Boot failure: msdos pushes in front of reiserfs
Message-ID: <20020115174712.GB3182@emma1.emma.line.org>
Mail-Followup-To: reiserfs-list@namesys.com,
	linux-kernel@vger.kernel.org, feedback@suse.de
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org> <20020114095013.A4760@namesys.com> <20020114140021.GD5711@emma1.emma.line.org> <20020114173030.A1901@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20020114173030.A1901@namesys.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Oleg Drokin wrote:

> Looking at init/main.c and fs/super.c, rootfsflags parameter is never
> saved, moreover - it's original value is destroyed, once initrd fs is
> mounted.  And I only see not very nice ways of fixing this, so perhaps
> someone more exeprienced can come up with the solution?  (my crappy
> ides is not to do putname() on fs_names, if (real_root_dev !=
> ROOT_DEV), all of this is only when CONFIG_..._INITRD enabled)

Thanks for confirming a bug, so I understand that mounting an initrd
loses the rootfsflags, and as the actual root= parameter is kept over an
initrd boot, it should also be possible for rootfsflags= -- can the
rootfsflags maybe be saved along with the root= parameter?

> > Yup, reiserfs is last in /proc/filesystems when loaded as module, but on
> > my private machine (where it's linked into the kernel), it's right after
> > ext2 and before vfat.
> Do you have vfat as a loadable module?

Hum, yes, but that's not the point, someone turned up with a SuSE 7.3
default kernel .config, and it had ...MSDOS=y ...REISERFS=m -- that says
about all, msdos is higher in the list, reiserfs is then loaded from
initrd, and thus at the bottom of the list. Strange enough SuSE compile
MSDOS which hardly anyone needs at boot time into the kernel, but not
reiserfs (admittedly, reiserfs takes up some memory, but then, it's a
native file system and should be loaded before non-native file systems
such as msdos, vfat, ntfs, freevxfs or whatever). This one is for the
distributors to fix.

Had they left MSDOS as a module, things would have worked out: 1. ext2
in the kernel 2. initrd loads reiserfs 3. actual root (reiserfs) is
mounted 4. only now, msdos.o becomes available.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
