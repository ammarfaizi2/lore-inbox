Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbRBHKni>; Thu, 8 Feb 2001 05:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129699AbRBHKn2>; Thu, 8 Feb 2001 05:43:28 -0500
Received: from mail.myrealbox.com ([192.108.102.201]:25767 "EHLO myrealbox.com")
	by vger.kernel.org with ESMTP id <S129094AbRBHKnP>;
	Thu, 8 Feb 2001 05:43:15 -0500
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 8 Feb 2001 11:47:34 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [reiserfs] SPEC SFS fails at low loads...
CC: Andi Kleen <ak@suse.de>, tigran@veritas.com
Message-ID: <3A828756.9682.4BCA4046@localhost>
In-Reply-To: Tigran Aivazian's message of "7 Feb 2001 17:37:30 +0100"
In-Reply-To: <ouphf26m6ez.fsf@pigdrop.muc.suse.de>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Btw, GFS (http://www.sistina.com) also needs 64bit inode 
number support. They offer a patch called inode.patch that is a 
backport of the 2.4 code.


Pedro

On 8 Feb 2001, at 0:15, Andi Kleen wrote:

> Tigran Aivazian <tigran@veritas.com> writes:
> 
> > Hi,
> > 
> > Under 2.4.1, after a little bit of running SPEC SFS (with NFSv3) I
> > get these messages on the server:
> > 
> > vs-13042: reiserfs_read_inode2: [0 1 0x0 SD] not found
> > vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found
> > vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found
> > vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found
> > 
> > and the run aborts.
> > 
> > Any clues?
> 
> Reiserfs really needs 64bit of inode in the NFS file handles,
> otherwise this happens as soon as you run out of the file handle cache
> with many active clients. The 2.2 code did a brute force search in
> this case (the handles are unique in 32bit, it's just very costly to
> look them up without the other 32bit), but it usually consumed so much
> CPU time that people thought the server crashed.
> 
> There are patches to do that for knfsd for both 2.2 and 2.4, but they
> haven't been merged yet. It needs a small VFS enhancement and knfsd
> changes.
> 
> Note that stock (unpatched) unfsd also doesn't work in all cases for
> other reasons, it makes assumptions about the inode space that do not
> work out on a longer used reiserfs. This has also been fixed.
> 
> -Andi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
