Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313061AbSC0SEV>; Wed, 27 Mar 2002 13:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313056AbSC0SED>; Wed, 27 Mar 2002 13:04:03 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:31480 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313055AbSC0SDt>; Wed, 27 Mar 2002 13:03:49 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 27 Mar 2002 11:02:47 -0700
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
Message-ID: <20020327180247.GU21133@turbolinux.com>
Mail-Followup-To: Matthew Kirkwood <matthew@hairy.beasts.org>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <p73y9ge3xww.fsf@oldwotan.suse.de> <Pine.LNX.4.33.0203271419230.28110-100000@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 27, 2002  14:47 +0000, Matthew Kirkwood wrote:
> Postgres doesn't pre-allocate datafiles.  They reckon it's not
> their job to implement a filesystem, and I'm inclined to agree.
> They do prefer fdatasync on datafiles and (I think) O_DATASYNC
> for their journal files where available, but I haven't checked
> that my build is doing that.

If the I/O is normally sync driven, you should consider testing ext3
with "data=journal".  While this seems counterintuitive because it is
writing the data to disk twice, it can often be faster in real-world
"bursty" environments because the sync I/O goes to the journal in one
contiguous write, and it can then be written to the rest of the fs
asynchronously safely.  You can also set up an external journal device
so that the journal is on another disk and avoid seeking between the
journal and the rest of the filesystem.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

