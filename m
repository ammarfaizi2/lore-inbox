Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293492AbSBYTua>; Mon, 25 Feb 2002 14:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293494AbSBYTuV>; Mon, 25 Feb 2002 14:50:21 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:2544 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S293492AbSBYTuL>;
	Mon, 25 Feb 2002 14:50:11 -0500
Date: Mon, 25 Feb 2002 12:49:53 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>, Dan Maas <dmaas@dcine.com>,
        "Rose, Billy" <wrose@loislaw.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020225124953.M12832@lynx.adilger.int>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Dan Maas <dmaas@dcine.com>, "Rose, Billy" <wrose@loislaw.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <Pine.LNX.3.95.1020225125900.26412A-100000@chaos.analogic.com> <20020225184021.GA27211@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020225184021.GA27211@matchmail.com>; from mfedyk@matchmail.com on Mon, Feb 25, 2002 at 10:40:21AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 25, 2002  10:40 -0800, Mike Fedyk wrote:
> On Mon, Feb 25, 2002 at 01:08:23PM -0500, Richard B. Johnson wrote:
> > > Rather than implementing this in the filesystem itself, I'd first try
> > > writing a libc shim that overrides unlink(). You could copy files to
> > > safety, or do anything else you want, before they actually get deleted...
> >
> > Yes... unlink() becomes `mv /path/filename /deleted/path/filename`
> > Simple.  For idiot users, you can just make such an alias for those
> 
> It would be nice if there was a 'deleted' dir per mount point, as that would
> keep similar speeds as rm.  Also, 'deleted' would probably have to be marked
> writable, but not readable and would need a suid binary to read that dir and
> limit the output to only list files owned by the calling uid.  But that's a
> bit too offtopic for this list...

Yes, the deleted (prefer /.deleted or similar) directory would _have_ to
be per mount point for a few reasons:
1) speed - copying all deleted files across mountpoints would be _slow_.
2) space - you would have to have a _huge_ root directory otherwise.
3) locality - need to handle network filesystems properly (e.g. being able
              to undelete a file on a network fs if it was deleted on a
	      different host).

While I've seen this "change unlink in libc" suggestion many, many times
I don't think I've ever seen it implemented.  Is it just because the people
who can do it don't want to, and by the time the people who want it can
implement it they don't want it anymore?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

