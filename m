Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273578AbRIUPj7>; Fri, 21 Sep 2001 11:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273580AbRIUPjt>; Fri, 21 Sep 2001 11:39:49 -0400
Received: from hermes.domdv.de ([193.102.202.1]:46093 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S273578AbRIUPjj>;
	Fri, 21 Sep 2001 11:39:39 -0400
Message-ID: <XFMail.20010921173903.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <01092119193901.01004@iron.auriga.ru>
Date: Fri, 21 Sep 2001 17:39:03 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Nick Ivanter <nick@emcraft.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre13: Panic mounting initrd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Sep-2001 Nick Ivanter wrote:
> Andreas,
> 
> Looks like you somehow haven't compiled ext2fs support into your new kernel. 
> Try to check that.
> 
If things would be that easy...

Snippets from a slight modification to mount_root() in fs/super.c

        for (fs_type = file_systems ; fs_type ; fs_type = fs_type->next) {
printk("VFS: Processing %s\n",fs_type->name);
                if (!(fs_type->fs_flags & FS_REQUIRES_DEV))
                        continue;
                if (!try_inc_mod_count(fs_type->owner))
                        continue;
printk("VFS: Trying %s\n",fs_type->name);


And now the results during boot (snippets again):

VFS: Processing bdev
VFS: Processing proc
VFS: Processing sockfs
VFS: Processing tmpfs
VFS: Processing pipefs
VFS: Processing ext2
VFS: Trying ext2
VFS: Processing msdos
VFS: Trying msdos
VFS: Processing vfat
VFS: Trying vfat
VFS: Processing iso9660
VFS: Trying iso9660
VFS: Processing nfs
VFS: Processing reiserfs
VFS: Trying reiserfs
Kernel Panic: ...

This clearly shows that there's definitely something going _very_ wrong.
Best bet is loading/decompression of initrd. As far as I'm following the list
there were initrd modifications discussed/done by Alexander Viro/Andrea
Arcangeli.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
