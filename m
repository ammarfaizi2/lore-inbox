Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289311AbSAOAAF>; Mon, 14 Jan 2002 19:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289308AbSANX7y>; Mon, 14 Jan 2002 18:59:54 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:52220 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289311AbSANX7v>;
	Mon, 14 Jan 2002 18:59:51 -0500
Date: Mon, 14 Jan 2002 16:58:49 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Theodore Tso <tytso@mit.edu>, Juan Quintela <quintela@mandrakesoft.com>,
        Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        felix-dietlibc@fefe.de, andersen@codepoet.org
Subject: Re: [RFC] klibc requirements, round 2
Message-ID: <20020114165849.B26688@lynx.adilger.int>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Theodore Tso <tytso@mit.edu>,
	Juan Quintela <quintela@mandrakesoft.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, felix-dietlibc@fefe.de,
	andersen@codepoet.org
In-Reply-To: <20020114125433.A1357@thunk.org> <Pine.LNX.4.43.0201141550170.31316-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.43.0201141550170.31316-100000@waste.org>; from oxymoron@waste.org on Mon, Jan 14, 2002 at 03:57:20PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 14, 2002  15:57 -0600, Oliver Xymoron wrote:
> On Mon, 14 Jan 2002, Theodore Tso wrote:
> > The development sources for e2fsprogs will already work with diet
> > libc.  Unfortunately, diet libc doesn't do shared libraries, so
> > resulting binaries are sufficiently big that I doubt they would be
> > interesting for initrd and rescue floppy applications (which is why I
> > tried the experiment in the first place).
> 
> For normal boot (which is what we are talking about, as all booting is
> moving to initramfs), we want enough code to get to the point where we
> mount root read-only (no fsck!) and that means enough to load modules and
> possibly get NFS up. And whatever else that's already in the kernel simply
> for boot that can be moved to userspace. Nothing else.

Actually, the whole point of Juan's suggestion was that you _don't_ want
to fsck a filesystem that is currently mounted.  There is always a
potential problem that fsck will change the on-disk data of the filesystem
in a way that is not coherent with what the kernel has in-memory, which
should force a system reboot before continuing (which most initscripts
don't do).  For ext2/ext3 this may be relatively safe (data/metadata don't
move around much), but reiserfsck cannot (or will not) fsck a mounted
filesystem at all.

It would be interesting to see if e2fsck could be linked into busybox or
another multi-call binary to avoid the overhead of the static libc linking.
I don't think there are any technical obstacles, just a matter of someone
sitting down and doing it.  It would still be pretty big (150kB or so).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

