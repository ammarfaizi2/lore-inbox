Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310147AbSCABI7>; Thu, 28 Feb 2002 20:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310200AbSCABFm>; Thu, 28 Feb 2002 20:05:42 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:19182 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S310273AbSCABDp>;
	Thu, 28 Feb 2002 20:03:45 -0500
Date: Thu, 28 Feb 2002 18:02:29 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020228180229.C22608@lynx.adilger.int>
Mail-Followup-To: Rick Lindsley <ricklind@us.ibm.com>,
	Mike Fedyk <mfedyk@matchmail.com>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020226172227.GM4393@matchmail.com> <200203010019.g210J1V07447@eng4.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203010019.g210J1V07447@eng4.beaverton.ibm.com>; from ricklind@us.ibm.com on Thu, Feb 28, 2002 at 04:19:00PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 28, 2002  16:19 -0800, Rick Lindsley wrote:
> A lot of talk about "daemons" ... seems overkill to me.  Any reason not
> to let each user do this on their own?  I've got an rm/unrm program
> that just stores the "rescued" files in your home directory for a
> period of time based on the either the name or pathname.

Well, the daemon could be used to do only background cleanup.  You could
always have the unlink wrapper do cleanup synchronously all the time,
but this might make some deletes slow.  If you weren't running a daemon,
then eventually the unlink wrapper would do all of the cleanups for you.
However, it would not be possible with the unlink wrapper for one user
to force cleanup of another user's deleted files if the filesystem is
running out of space.  I think having a daemon do this is far safer than
making "rm" an suid program (eek).

The other problem with moving files to the owner's home directory instead
of just renaming it to a per-filesystem .undelete directory is that this
takes a long time if they are on different filesystems, or (heaven forbid)
that the home directory is NFS mounted and you just deleted a 500MB GIMP
swap file from /tmp.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

