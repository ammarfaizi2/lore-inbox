Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292739AbSBZTnO>; Tue, 26 Feb 2002 14:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292749AbSBZTnF>; Tue, 26 Feb 2002 14:43:05 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:33777 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292739AbSBZTmy>;
	Tue, 26 Feb 2002 14:42:54 -0500
Date: Tue, 26 Feb 2002 12:41:30 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Rose, Billy" <wrose@loislaw.com>,
        "'Martin Dalecki'" <dalecki@evision-ventures.com>,
        Mike Fedyk <mfedyk@matchmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226124130.O12832@lynx.adilger.int>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	"Rose, Billy" <wrose@loislaw.com>,
	'Martin Dalecki' <dalecki@evision-ventures.com>,
	Mike Fedyk <mfedyk@matchmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com> <Pine.LNX.4.44L.0202261456010.1413-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44L.0202261456010.1413-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Feb 26, 2002 at 02:56:40PM -0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2002  14:56 -0300, Rik van Riel wrote:
> On Tue, 26 Feb 2002, Rose, Billy wrote:
> > My company can tolerate 0% loss of data (which is why I raised this issue).
> 
> > The ability to handle situations like a file going "poof" is why my
> > company will not use Linux on these particular file servers. My aim was
> > to change that by crushing the only thing holding Netware in my company.
> 
> You could use LVM snapshots.

No, LVM snapshots are not really practical for such applications.  The
real problem is that (a) you are limited to 256 LVs with the current
LVM code, so maybe hourly snapshots on 10 filesystems probably isn't
enough, and (b) you have to make a copy of the data for _each_ LVM
snapshot that you have, which quickly becomes expensive for a large
number of snapshots.

At one time there was a SnapFS project at SourceForge (for which I
wrote the original ext2 shapshot code), but it appears to have gone
into oblivion and the current "maintainers" are not responsive to
requests to make this available.

SnapFS has the benefits of only keeping a single copy of each version
of the file, and you can make a larger number of snapshots than with
LVM with no overhead from adding additional snapshots.

However, I have just realized that even though they deleted everything
in CVS and disabled CVS on that project entirely, I can still download a
copy of the entire CVS repository to get my original code back.  It is
clearly documented in the CVS repository that the code is GPL and has
my name in the copyright messages.  Some of the code is clearly not
compatible with current enhancements to ext2 (after my time, of course)
so before people start using it again it would need to be cleaned up
(e.g. get non-conflicting ext2 COMPAT feature bits, inode flags, ioctl
numbers, space in the on-disk superblock, etc).

It may also be possible to get the SF site admins to assign control
of the SnapFS project to someone else if they are interested in
working on this, because the current guys are off in proprietary-land,
even though the original code was GPL.  Sadly, I probably won't have
any time to look at this in the near future, but maybe a few months
down the road after I get settled into my new job.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

