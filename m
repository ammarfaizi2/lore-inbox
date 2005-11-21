Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVKULrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVKULrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVKULrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:47:03 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:16073 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S932273AbVKULq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:46:59 -0500
Date: Mon, 21 Nov 2005 12:46:54 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051121114654.GA25180@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20051121101959.GB13927@wohnheim.fh-wedel.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Jörn Engel wrote:

> o Checksums for data blocks
>   Done by jffs2, not done my any hard disk filesystems I'm aware of.

Then allow me to point you to the Amiga file systems. The variants
commonly dubbed "Old File System" use only 448 (IIRC) out of 512 bytes
in a data block for payload and put their block chaining information,
checksum and other "interesting" things into the blocks. This helps
recoverability a lot but kills performance, so many people (used to) use
the "Fast File System" that uses the full 512 bytes for data blocks.

Whether the Amiga FFS, even with multi-user and directory index updates,
has a lot of importance today, is a different question that you didn't
pose :-)

>   yet.  (I barely consider reiser4 to exist.  Any filesystem that is
>   not considered good enough for kernel inclusion is effectively still
>   in development phase.)

What the heck is reiserfs? I faintly recall some weirdo crap that broke
NFS throughout the better parts of 2.2 and 2.4, would slowly write junk
into its structures that reiserfsck could only fix months later.

ReiserFS 3.6 still doesn't work right (you cannot create an arbitrary
amount of arbitrary filenames in any one directory even if there's
sufficient space), after a while in production, still random flaws in
the file systems that then require rebuild-tree that works only halfway.
No thanks.

Why would ReiserFS 4 be any different? IMO reiserfs4 should be blocked
from kernel baseline until:

- reiserfs 3.6 is fully fixed up

- reiserfs 4 has been debugged in production outside the kernel for at
  least 24 months with a reasonable installed base, by for instance a
  large distro using it for the root fs

- there are guarantees that reiserfs 4 will be maintained until the EOL
  of the kernel branch it is included into, rather than the current "oh
  we have a new toy and don't give a shit about 3.6" behavior.

Harsh words, I know, but either version of reiserfs is totally out of
the game while I have the systems administrator hat on, and the recent
fuss between Namesys and Christoph Hellwig certainly doesn't raise my
trust in reiserfs.

-- 
Matthias Andree
