Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWFSVpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWFSVpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWFSVpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:45:43 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:2120 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964907AbWFSVpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:45:42 -0400
Date: Mon, 19 Jun 2006 14:45:37 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org
Cc: mark.fasheh@oracle.com
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619214537.GV29684@ca-server1.us.oracle.com>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	linux-kernel@vger.kernel.org, mark.fasheh@oracle.com
References: <20060619152003.830437000@candygram.thunk.org> <20060619153109.817554000@candygram.thunk.org> <20060619160146.GQ29684@ca-server1.us.oracle.com> <20060619170627.GC15216@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619170627.GC15216@thunk.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 01:06:27PM -0400, Theodore Tso wrote:
> How strongly do you feel about reporting stat.st_blksize out to be the
> clustersize?  Keeping in mind that if you report a value which is too
> big, /bin/cp will start coredumping....

	What's "too big"?  We certainly don't specify 128MB, but we will
specify up to 1MB.
	When we have large cluster size filesystems, we've seen backups
with O_DIRECT-enabled versions of cp(1) and dd(1) go way faster than
when they read/write 4K at a time.  This matters to folks who have the
files open O_DIRECT by other processes and cannot trust the page cache.
At least, that's is how it was when we originally did this :-)

> If I take Christoph's suggestion of simply removing sb->s_blksize
> altogether, and forcing filesystems that want to return a non-default
> value for stat.st_blksize to supply their own filesystem-specific
> getattr, will you mind terribly?

	Well, Christoph points out we already have a valid getattr()
that calls generic_fillattr() and then overloads our stat->blksize.  So
I think we're safe.  I don't think we need sb->s_blksize, but I'll defer
to Mark for the final say.

Joel

-- 

"The lawgiver, of all beings, most owes the law allegiance.  He of all
 men should behave as though the law compelled him.  But it is the
 universal weakness of mankind that what we are given to administer we
 presently imagine we own."
        - H.G. Wells

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
