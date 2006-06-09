Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWFIWrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWFIWrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWFIWrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:47:25 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:35460 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751421AbWFIWrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:47:24 -0400
Date: Fri, 9 Jun 2006 15:47:00 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
       Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609224700.GB29684@ca-server1.us.oracle.com>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609210319.GF10524@thunk.org> <20060609212410.GJ3574@ca-server1.us.oracle.com> <20060609215137.GG10524@thunk.org> <20060609220711.GA29684@ca-server1.us.oracle.com> <20060609223129.GI10524@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609223129.GI10524@thunk.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 06:31:29PM -0400, Theodore Tso wrote:
> The potential problem with this is that system administrator may never
> realize that the filesystem is just getting silently skipped.  (And a
> big fat warning printed by e2fsck doesn't help when distro's like
> Ubuntu use a graphical boot sequence that hides warning messages
> printed by e2fsck).

	Yeah, you're not the only one to point this out.

> Is it really that hard to edit /etc/fstab so that the fsck pass is
> skipped?  

	Depends on how close you are in proximity to the console, I
suspect.  Point is, something _broke_.
	Regardless of the name, clearly we have a _different_
filesystem.  With a clean unmount, a journaled ext3 is still a valid
ext2.  With a clean unmount, an extended-attribute ext3 is still a valid
plain ext3 and a valid ext2.  With a clean unmount, a dir_index ext3 is
still a valid plain ext3 and a valid ext2.  An extents ext3 is NEVER a
valid plain ext3 or ext2.
	What happens today if you have a filesystem in fstab that
has no fsck in /sbin (eg, we all pick the name 'ext4', it says 'ext4' in
fstab, but there is no /sbin/fsck.ext4)?  Does "fsck -a" skip the
partition, or halt and fail the boot?  If the latter, I suspect that the
only solution is "I hope you don't encounter this on remote machines ha
ha ha".  If it skips, we have yet another reason that using the same
name is a bad thing.

Joel

-- 

"Sometimes when reading Goethe I have the paralyzing suspicion
 that he is trying to be funny."
         - Guy Davenport

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
