Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbWFIVvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbWFIVvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbWFIVvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:51:54 -0400
Received: from thunk.org ([69.25.196.29]:58086 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030541AbWFIVvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:51:51 -0400
Date: Fri, 9 Jun 2006 17:51:37 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609215137.GG10524@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609210319.GF10524@thunk.org> <20060609212410.GJ3574@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609212410.GJ3574@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 02:24:10PM -0700, Joel Becker wrote:
> 	Heck, forget the name, just make the breakage more explicit.  Do
> it at mkfs/tunefs time.  "tunefs -extents" or "mkfs -t ext3 -extents".
> A mount option assumes that you can do with or without it.  If you do it
> once, you can mount the next time without it and stuff Just Works.  Even
> htree follows this.  A clean unmount leaves a clean directory structure
> that a non-htree driver can use.

Agreed; I've was never a fan of how we enabled extended attributes
using a mount option, as it clutters the /etc/fstab line, among other
things.  (I added the tune2fs -o feature so that default mount options
could be stored in the superblock to try to cover that design botch,
but the real answer is that extended attributes should never have been
done via a mount option, or at least not only as the right only thing
you had to do before the feature became enabled.)

The right approach is what we did with journaling (tune2fs -j or
tune2fs -O has_journal) and what we did with htree support (tune2fs -O
dir_index), to explicitly enable that feature, and that's certainly
what I will be pushing for.

						- Ted

