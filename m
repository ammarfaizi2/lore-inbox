Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286672AbSANObF>; Mon, 14 Jan 2002 09:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286756AbSANOat>; Mon, 14 Jan 2002 09:30:49 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:39691 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286647AbSANOac>; Mon, 14 Jan 2002 09:30:32 -0500
Date: Mon, 14 Jan 2002 17:30:30 +0300
From: Oleg Drokin <green@namesys.com>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
        Ewald Peiszer <ewald.peiszer@utanet.at>
Subject: Re: [reiserfs-list] Boot failure: msdos pushes in front of reiserfs
Message-ID: <20020114173030.A1901@namesys.com>
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org> <20020114095013.A4760@namesys.com> <20020114140021.GD5711@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114140021.GD5711@emma1.emma.line.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Jan 14, 2002 at 03:00:21PM +0100, Matthias Andree wrote:

> > > 4. I asked Ewald to boot with rootfstype=reiserfs, but he reported that
> > >    this did not help, news:<a1sb7b$t2d2e$1@ID-47183.news.dfncis.de>
> > >    (German-language).
> > Hm, probably because reiserfs is not in kernel, but is an external module.
> Yes, but this module is loaded from SuSE's initrd, so it is loaded
> before the root file system is mounted. Might it be that "rootfstype" is
> already checked as the initrd is mounted rather then when the actual
> root is mounted? If so, fs/super.c deserves fixing, but I'm not
> acquainted with that code, so I cannot tell or fix that now.
Looking at init/main.c and fs/super.c,
rootfsflags parameter is never saved, moreover - it's original value is destroyed, once initrd fs is mounted.
And I only see not very nice ways of fixing this, so perhaps someone more exeprienced can come up with the solution?
(my crappy ides is not to do putname() on fs_names, if (real_root_dev != ROOT_DEV), all of this is only when CONFIG_..._INITRD
enabled)

> > > 2. mkreiserfs could also zero out so much of old data on the FS so that
> > >    the kernel reliably recognizes the FS as reiserfs and fails to mount
> > >    that stuff as msdos
> > External tools (lilo and stuff) can live there, this will destroy them.
> > 
> > Correct solution, if you create filesystem with mkreiserfs, and you
> > have no reliable way to pass fstype to kernel, when this partition is mounted 
> > should be to destroy all occurences of other fs's superblocks by yourself, obviously.
> Sure, but tell newbies how to do that. (Tell distributors first. :-)
Our internal deecision is now to detect if device, we are going to mkfs have FAT superblock,
and if it is, zero it out.

> > > 3. Distributors, when making their initrd stuff, should make sure that
> > >    all Linux-native file systems are tried first.
> > FS tryout order is hard-wired into the kernel (and depends on linking order, AFAIK).
> Yup, reiserfs is last in /proc/filesystems when loaded as module, but on
> my private machine (where it's linked into the kernel), it's right after
> ext2 and before vfat.
Do you have vfat as a loadable module?

Bye,
    Oleg
