Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUEENEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUEENEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264666AbUEEND5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 09:03:57 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:8879 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264662AbUEENCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 09:02:47 -0400
Subject: Re: [Linux-NTFS-Dev] Re: [BUG] 2.6.5 ntfs
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: m.gibula@conecto.pl, ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0405051423360.28183-100000@mlf.linux.rulez.org>
References: <Pine.LNX.4.21.0405051423360.28183-100000@mlf.linux.rulez.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service
Message-Id: <1083762029.916.59.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 14:00:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-05 at 13:47, Szakacsits Szabolcs wrote:
> On Wed, 5 May 2004, Anton Altaparmakov wrote:
> 
> > > NTFS-fs error: ntfs_decompress(): Failed. Returning -EOVERFLOW.
> 
> I'm aware at least ntfsprogs mapping pairs decompression doesn't check
> upper boundary and this can cause problems on corrupted NTFS. This might
> or might not have anything to do with the above.

Would you care to point out what code in particular is unbounded?  All
the code is checking for overflows as far as I am aware and will give
you an io error on any corrupt ntfs...

> > > NTFS-fs error (device hde4): ntfs_read_compressed_block(): ntfs_decompress() 
> > > failed in inode 0x78a with error code 75. Skipping this compression block.
> > > 
> > > But no oops ... 
> > > If you want I can run whatever is necessary.
> > 
> > If you run "chkdsk /f" from windows on this partition, does it detect
> > any errors?
> 
> It would be nice to get the NTFS metadata first (please see below).  
> However I also suspect, it's again an NTFS corruption that the Windows
> driver tolerates/handles better ...

Too late and it is not.  chkdsk detected no errors.

> > Assuming chkdsk doesn't detect and fix any errors, this would definitely
> > be worth investigating.  I don't think it has anything to do with the
> > oops but I would very much like a copy of this inode because it might
> > mean our decompression code has a bug in it and I want to check this
> > out.  To create a copy, I will assume you have the latest ntfsprogs
> > installed, then use ntfscat to dump your $MFT like this:
> > 
> > ntfscat -i 0 /dev/hde4 > ~/mymftdump
> 
> What's wrong with the below instead?
> 
> 	ntfsclone --metadata --output ntfsmeta.img /dev/hde4
> 	tar -cjSf ntfsmeta.img.tar.bz2 ntfsmeta.img
> 
> It has everything needed, zeros all the unused space for best compression,
> wipes private resident user data and it's even mountable. The compressed
> NTFS metadata is usually max 1-5 MB (of course please send it off-list).

It is still too big for people with modems and gives the same (ok, a bit
smaller) as the ntfscat method...  Otherwise nothing wrong with it of
course.  I now have the inode in question btw.  Note the ntfsclone still
doesn't give you the compressed data stream of the inode you want so it
is no more useful than the approach I described...

> If the ntfsclone consistency check wouldn't pass I have a patch that
> disables it (if time allows I'm just working on the refactoring of the
> relevant ntfsprogs utils for this purpose and having an ntfsck).
> 
> >   [Error: Formatting error: Non-hexadecimal character in QP encoding]
> 
> Apparently Sourceforge still doesn't like quoted-printable 
> Content-Transfer-Encoding ...

)-:  Not much I can do about it.  AFAICS Evolution cannot send email in
any other way...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/


