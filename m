Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTDJTwx (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 15:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264133AbTDJTwx (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 15:52:53 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:47345 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264132AbTDJTww (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 15:52:52 -0400
Date: Thu, 10 Apr 2003 14:04:00 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Lorenzo Allegrucci <l.allegrucci@tiscali.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2/3 fragments support
Message-ID: <20030410140400.G26054@schatzie.adilger.int>
Mail-Followup-To: Lorenzo Allegrucci <l.allegrucci@tiscali.it>,
	linux-kernel@vger.kernel.org
References: <200304102135.19381.l.allegrucci@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304102135.19381.l.allegrucci@tiscali.it>; from l.allegrucci@tiscali.it on Thu, Apr 10, 2003 at 09:35:19PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 10, 2003  21:35 +0000, Lorenzo Allegrucci wrote:
> Fragments support on ext2/3 filesystems seems disabled
> or non fully functional.
> Are there any plans to implement fragments?

They have never been enabled.  The "goal" is to imlement fragments as a
type of extended attribute, so that they can be packed into a single block
or inline in a larger inode (along with other EA data) instead of being
fixed-size hunks.

The first thing that needs doing is fixing the current ext2/3 EA sharing
scheme, which currently only shares blocks if they are identical and is
therefore only really useful for ACLs.

The best proposal so far for EA sharing is to put them into a directory-like
structure (maybe one dir per block group or something) and have the EA type
and data be packed inline into the directory (like the inode number and
filename are done with regular directories).  Each inode would also have a
"catalog" of the EAs that it has (itself an EA, either inline in a larger
inode or in the directory pointed to by, say, i_faddr).  Shared entries would
be like hard links pointed to by mutliple catalogs, with a refcount.

This was discussed on ext2-devel about a year ago, but no takers on the
implementation yet (I might eventually need to implement it this year if
nobody beats me to it, because we need better EAs than one per 4kB of disk).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

