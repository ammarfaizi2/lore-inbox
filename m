Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUBDIwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 03:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266325AbUBDIwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 03:52:18 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:35513 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id S266303AbUBDIwO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 03:52:14 -0500
Date: Wed, 4 Feb 2004 09:51:57 +0100
From: Eduard Bloch <edi@gmx.de>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: "P. Christeas" <p_christ@hol.gr>, lkml <linux-kernel@vger.kernel.org>,
       viro@math.psu.edu
Subject: Re: Q: large files in iso9660 ?
Message-ID: <20040204085157.GA21174@zombie.inka.de>
References: <200402020024.31785.p_christ@hol.gr> <20040203133551.GA11957@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040203133551.GA11957@bitwizard.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by mailgate1.uni-kl.de id i148qARL023137
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Erik Mouw [Tue, Feb 03 2004, 02:35:51PM]:
> On Mon, Feb 02, 2004 at 12:24:31AM +0200, P. Christeas wrote:
> > I've tried to create a disk (DVD) which contains a single 3.8GB file. The 
> > creation (mkisofs) worked and the disk's TOC reads 3.8GB.
> 
> No, it didn't. Last time I tried mkisofs warned about files being
> larger than 2GB. Feel free to ignore the warnings, though.

No, normal mkisofs does not warn, are you sure that your distributor did
not patch it?

> > However, the 
> > filesystem reads as if one ~9MB file only exists. 
> > I guess large files in isofs may be out of spec. 
> > 
> > Q: What's the file size limit in iso9660?
> 
> About 2GB.

Really? Quoting Joerg Schilling:

| >#include <hallo.h>
| >* christophe nowicki [Thu, Jan 22 2004, 01:22:34PM]:
| 
| >> #mount -t iso9660 -o loop burn.iso /mnt
| >> $ls -sh /mnt
| >> total 4.0M
| >> 4.0M test
| >>       ^ all my data are lost !
| >>=20
| >> During the creation process mkisofs did not make a warning ...
| 
| Definitely wrong (even for the outdated 2.0 version)!
| 
| .... see log below:
| 
| mkdir LD
| cd LD
|  mkfile -n 5g 5g
| cd ..
| /opt/schily/bin/mkisofs -o /tmp/0a LD
| /opt/schily/bin/mkisofs: Value too large for defined data type. File LD/5g is too large - ignoring
| Total translation table size: 0
| Total rockridge attributes bytes: 0
| Total directory bytes: 0
| Path table size(bytes): 10
| Max brk space used 8000
| 48 extents written (0 Mb)
| 
| 
| >Reproducible for me. IMHO it is not only the iso9660 filesize limit,
| >since Joliet should support larger files.
| 
| Definitely wrong too: Joliet is a half hearted hack on ISO-9660.
| If you like to have large files in ISO-9660 (and/or Joliet!), you would need
| multi extent file support.
| 
| In order to implement this, you need an OS to test with....
| 
| Solaris has no multi extent file support
| 
| Linux fails with several other problems in the vicinity of large files on 
| ISO-9660 and in such a case auto activates evil mount options that prevents
| you from using such media.
| 
| 
| Jörg

> The kernel (2.6 and 2.4) has the following code in isofs_read_inode():
> 
>         /*
>          * The ISO-9660 filesystem only stores 32 bits for file size.
>          * mkisofs handles files up to 2GB-2 = 2147483646 = 0x7FFFFFFE bytes
>          * in size. This is according to the large file summit paper from 1996.
>          * WARNING: ISO-9660 filesystems > 1 GB and even > 2 GB are fully
>          *          legal. Do not prevent to use DVD's schilling@fokus.gmd.de
>          */

Interesting, what should be "multiple extents" then?

>         if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
>             sbi->s_cruft == 'n') {
>                 printk(KERN_WARNING "Warning: defective CD-ROM.  "
>                        "Enabling \"cruft\" mount option.\n");

I have never seen this warning on mounting "defective" filesystems.

Regards,
Eduard.
-- 
Man weist ein Lob zurück in dem Wunsch, nochmals gelobt zu werden.
		-- François de La Rochefoucauld
