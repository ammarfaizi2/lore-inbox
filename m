Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289240AbSANOCM>; Mon, 14 Jan 2002 09:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289242AbSANOCD>; Mon, 14 Jan 2002 09:02:03 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:34832 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289240AbSANOBz>; Mon, 14 Jan 2002 09:01:55 -0500
Date: Mon, 14 Jan 2002 15:00:21 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Cc: Ewald Peiszer <ewald.peiszer@utanet.at>
Subject: Re: [reiserfs-list] Boot failure: msdos pushes in front of reiserfs
Message-ID: <20020114140021.GD5711@emma1.emma.line.org>
Mail-Followup-To: reiserfs-list@namesys.com,
	linux-kernel@vger.kernel.org, Ewald Peiszer <ewald.peiszer@utanet.at>
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org> <20020114095013.A4760@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20020114095013.A4760@namesys.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Oleg Drokin wrote:

> It is tried _and_ somewhat succesfuly, because there is still MSDOS "superblock".

True.

> > 4. I asked Ewald to boot with rootfstype=reiserfs, but he reported that
> >    this did not help, news:<a1sb7b$t2d2e$1@ID-47183.news.dfncis.de>
> >    (German-language).
> Hm, probably because reiserfs is not in kernel, but is an external module.

Yes, but this module is loaded from SuSE's initrd, so it is loaded
before the root file system is mounted. Might it be that "rootfstype" is
already checked as the initrd is mounted rather then when the actual
root is mounted? If so, fs/super.c deserves fixing, but I'm not
acquainted with that code, so I cannot tell or fix that now.

> > 2. mkreiserfs could also zero out so much of old data on the FS so that
> >    the kernel reliably recognizes the FS as reiserfs and fails to mount
> >    that stuff as msdos
> External tools (lilo and stuff) can live there, this will destroy them.
> 
> Correct solution, if you create filesystem with mkreiserfs, and you
> have no reliable way to pass fstype to kernel, when this partition is mounted 
> should be to destroy all occurences of other fs's superblocks by yourself, obviously.

Sure, but tell newbies how to do that. (Tell distributors first. :-)
> 
> > 3. Distributors, when making their initrd stuff, should make sure that
> >    all Linux-native file systems are tried first.
> FS tryout order is hard-wired into the kernel (and depends on linking order, AFAIK).

Yup, reiserfs is last in /proc/filesystems when loaded as module, but on
my private machine (where it's linked into the kernel), it's right after
ext2 and before vfat.

> why have not you asked him to do 'dd if=/dev/zero
> of=/dev/his_partition bs=512 count=1'?  (and this won't destroy
> existing reiserfs filesystem).

Because I wasn't sure about the superblock checking behaviour of msdos.o
and whether this would harm reiserfs.o. I'm not telling newbies things
when I'm not absolutely sure they don't make things worse, I don't want
to scare them away from Linux.

Ewald, can you try

dd if=/dev/zero of=/dev/hda13 bs=512 count=1

from your rescue system and then check if your actual system boots
properly without help of SuSE's install floppies/CD?

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
