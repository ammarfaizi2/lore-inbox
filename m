Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264344AbUEEMrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbUEEMrk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbUEEMrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:47:40 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:24074 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S264344AbUEEMri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:47:38 -0400
Date: Wed, 5 May 2004 14:47:34 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: m.gibula@conecto.pl, ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-NTFS-Dev] Re: [BUG] 2.6.5 ntfs
In-Reply-To: <1083758242.916.42.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.21.0405051423360.28183-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 May 2004, Anton Altaparmakov wrote:

> > NTFS-fs error: ntfs_decompress(): Failed. Returning -EOVERFLOW.

I'm aware at least ntfsprogs mapping pairs decompression doesn't check
upper boundary and this can cause problems on corrupted NTFS. This might
or might not have anything to do with the above.

> > NTFS-fs error (device hde4): ntfs_read_compressed_block(): ntfs_decompress() 
> > failed in inode 0x78a with error code 75. Skipping this compression block.
> > 
> > But no oops ... 
> > If you want I can run whatever is necessary.
> 
> If you run "chkdsk /f" from windows on this partition, does it detect
> any errors?

It would be nice to get the NTFS metadata first (please see below).  
However I also suspect, it's again an NTFS corruption that the Windows
driver tolerates/handles better ...

> Assuming chkdsk doesn't detect and fix any errors, this would definitely
> be worth investigating.  I don't think it has anything to do with the
> oops but I would very much like a copy of this inode because it might
> mean our decompression code has a bug in it and I want to check this
> out.  To create a copy, I will assume you have the latest ntfsprogs
> installed, then use ntfscat to dump your $MFT like this:
> 
> ntfscat -i 0 /dev/hde4 > ~/mymftdump

What's wrong with the below instead?

	ntfsclone --metadata --output ntfsmeta.img /dev/hde4
	tar -cjSf ntfsmeta.img.tar.bz2 ntfsmeta.img

It has everything needed, zeros all the unused space for best compression,
wipes private resident user data and it's even mountable. The compressed
NTFS metadata is usually max 1-5 MB (of course please send it off-list).

If the ntfsclone consistency check wouldn't pass I have a patch that
disables it (if time allows I'm just working on the refactoring of the
relevant ntfsprogs utils for this purpose and having an ntfsck).

>   [Error: Formatting error: Non-hexadecimal character in QP encoding]

Apparently Sourceforge still doesn't like quoted-printable 
Content-Transfer-Encoding ...

	Szaka

