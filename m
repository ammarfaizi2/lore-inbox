Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288188AbSAQGjA>; Thu, 17 Jan 2002 01:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288190AbSAQGiv>; Thu, 17 Jan 2002 01:38:51 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:11536 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288188AbSAQGil>; Thu, 17 Jan 2002 01:38:41 -0500
Date: Thu, 17 Jan 2002 09:38:39 +0300
From: Oleg Drokin <green@namesys.com>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org, feedback@suse.de
Subject: Re: [reiserfs-list] Boot failure: msdos pushes in front of reiserfs
Message-ID: <20020117093839.A20206@namesys.com>
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org> <20020114095013.A4760@namesys.com> <20020114140021.GD5711@emma1.emma.line.org> <20020114173030.A1901@namesys.com> <20020115174712.GB3182@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115174712.GB3182@emma1.emma.line.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Jan 15, 2002 at 06:47:12PM +0100, Matthias Andree wrote:
> > Looking at init/main.c and fs/super.c, rootfsflags parameter is never
> > saved, moreover - it's original value is destroyed, once initrd fs is
> > mounted.  And I only see not very nice ways of fixing this, so perhaps
> > someone more exeprienced can come up with the solution?  (my crappy
> > ides is not to do putname() on fs_names, if (real_root_dev !=
> > ROOT_DEV), all of this is only when CONFIG_..._INITRD enabled)
> Thanks for confirming a bug, so I understand that mounting an initrd
> loses the rootfsflags, and as the actual root= parameter is kept over an
> initrd boot, it should also be possible for rootfsflags= -- can the
> rootfsflags maybe be saved along with the root= parameter?

No. rootfsflags is saved. What is not saved is rootfstype. And yes, it can be saved, of course.

> > > Yup, reiserfs is last in /proc/filesystems when loaded as module, but on
> > > my private machine (where it's linked into the kernel), it's right after
> > > ext2 and before vfat.
> > Do you have vfat as a loadable module?
> Hum, yes, but that's not the point, someone turned up with a SuSE 7.3
This is the point in fact. If you'd have both reiserfs and vfat compiled-in,
you'd see that vfat ebfore reiserfs in /proc/filesystems.

Bye,
    Oleg
