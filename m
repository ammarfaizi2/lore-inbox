Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288855AbSANGuu>; Mon, 14 Jan 2002 01:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288870AbSANGua>; Mon, 14 Jan 2002 01:50:30 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:38661 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288850AbSANGuT>; Mon, 14 Jan 2002 01:50:19 -0500
Date: Mon, 14 Jan 2002 09:50:13 +0300
From: Oleg Drokin <green@namesys.com>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
        ewald.peiszer@gmx.at, matthias.andree@stud.uni-dortmund.de
Subject: Re: [reiserfs-list] Boot failure: msdos pushes in front of reiserfs
Message-ID: <20020114095013.A4760@namesys.com>
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Jan 13, 2002 at 11:38:03PM +0100, Matthias Andree wrote:

> 3. I presume that msdos is linked into the kernel, and is thus tried
>    first as root file system, the kernel then panicks as it cannot find
>    /sbin/init (of course, it's in ReiserFS format, not msdos).
It is tried _and_ somewhat succesfuly, because there is still MSDOS "superblock".
 
> 4. I asked Ewald to boot with rootfstype=reiserfs, but he reported that
>    this did not help, news:<a1sb7b$t2d2e$1@ID-47183.news.dfncis.de>
>    (German-language).
Hm, probably because reiserfs is not in kernel, but is an external module.

> 5. It seems as though some traces of FAT16 shining through reiserfs
>    still make msdos think it can actually mount the file system.
Exactly.

> I see various points where this can be attacked:
> 1. SuSE and other distributors' installation tools, when formatting a
>    partition with mkfs, should zero out the first couple of MBytes with
>    dd if=/dev/zero of=/dev/hda13 bs=4096 count=1024 or something. I'm
>    not exactly sure how much is needed to get rid of the msdos traces.
Erasing first 512 bytes block is enough to get rid fo msdos superblock, I think.

> 2. mkreiserfs could also zero out so much of old data on the FS so that
>    the kernel reliably recognizes the FS as reiserfs and fails to mount
>    that stuff as msdos
External tools (lilo and stuff) can live there, this will destroy them.

Correct solution, if you create filesystem with mkreiserfs, and you
have no reliable way to pass fstype to kernel, when this partition is mounted 
should be to destroy all occurences of other fs's superblocks by yourself, obviously.

> 3. Distributors, when making their initrd stuff, should make sure that
>    all Linux-native file systems are tried first.
FS tryout order is hard-wired into the kernel (and depends on linking order, AFAIK).

> Ewald has only recently migrated from Windows to Linux and direly wants
> his installation to boot. For now, I asked him to recompile his kernel
> to let msdos, umsdos and vfat be only modules rather than linked into
> the kernel, rebuild his initrd with SuSE's mk_initrd and rerun lilo,
> that should work around his problem, but it's certainly not good and may
> turn away people from Linux who are less enduring and patient than
> Ewald.
why have not you asked him to do 'dd if=/dev/zero of=/dev/his_partition bs=512 count=1'?
(and this won't destroy existing reiserfs filesystem).

Bye,
    Oleg
