Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWFIWbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWFIWbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWFIWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:31:48 -0400
Received: from thunk.org ([69.25.196.29]:45530 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751403AbWFIWbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:31:47 -0400
Date: Fri, 9 Jun 2006 18:31:29 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609223129.GI10524@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609210319.GF10524@thunk.org> <20060609212410.GJ3574@ca-server1.us.oracle.com> <20060609215137.GG10524@thunk.org> <20060609220711.GA29684@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609220711.GA29684@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 03:07:11PM -0700, Joel Becker wrote:
> 	Excellent.  And now let's close the other side of compatibility.
> The attribute problem we discussed with e2fsck has a simple solution:
> exit cleanly when you don't understand a filesystem.
> 	If e2fsck finds an INCOMPAT flag it doesn't understand, it
> didn't *fail* to fsck, it just plain doesn't understand the filesystem.
> This should not, in any way, prevent bootup from continuing.  Later,
> mount may succeed (if the kernel is new enough) or fail (if not), but my
> system won't be completely unusable by surprise (assuming that / isn't
> the affected filesystem).

The potential problem with this is that system administrator may never
realize that the filesystem is just getting silently skipped.  (And a
big fat warning printed by e2fsck doesn't help when distro's like
Ubuntu use a graphical boot sequence that hides warning messages
printed by e2fsck).

Is it really that hard to edit /etc/fstab so that the fsck pass is
skipped?  

I might be willing to make it be a configurable option in
/etc/e2fsck.conf, but it *is* dangerous to have e2fsck exit with
success without having actually checked the filesystem.

						- Ted
